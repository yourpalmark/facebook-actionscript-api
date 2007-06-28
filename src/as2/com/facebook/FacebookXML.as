
/**
 * Facebook API XML interface
 * @see http://developers.facebook.com/documentation.php
 * @author Tim Whitlock <tim at white interactive dot com>
 * @history Feb 2007 first version
 * @history Jun 2007 altered class names
 */



import com.timwhitlock.crypto.md5;
import com.facebook.Facebook;
import com.facebook.lists.FBAlbumList;


class com.facebook.FacebookXML extends XML {
	
	#include "version.as"

	/** 
	 * Current list of request arguments to be sent to REST server
	 * @var Object
	 */
	private var args:Object;

	/** 
	 * Current list of response arguments received from REST server
	 * @var Object
	 */
	private var tree:Object;

	/**
	 * Class of root data object in response
	 */	
	public var dataClass:Function;
	
	/**
	 * Incremental call ID as expected by Faceboook server.
	 * @var Number
	 */
	private static var callID:Number = 0;
	
	/**
	 * configurable timeout length in milliseconds
	 */
	public var timeout:Number = 10000;
	
	/**
	 * interval id for timeout facility
	 */
	private var timeoutID:Number;
	
	
	/**
	 * Status description according to current status integer
	 * @return String
	 */	
	function get statusDetail():String {
		switch( this.status ){
		case  0  : return "No error, XML is Okay.";
		case -2  : return "A CDATA section was not properly terminated.";
		case -3  : return "The XML declaration was not properly terminated.";
		case -4  : return "The DOCTYPE declaration was not properly terminated.";
		case -5  : return "A comment was not properly terminated.";
		case -6  : return "An XML element was malformed.";
		case -7  : return "Out of memory.";
		case -8  : return "An attribute value was not properly terminated.";
		case -9  : return "A start-tag was not matched with an end-tag.";
		case -10 : return "An end-tag was encountered without a matching start-tag.";
		// custom status codes
		case   1 : return 'Facebook server returned error';
		case   2 : return 'Error parsing Facebook XML';
		case   3 : return 'Request timed out';
		default  : return "unknown error #"+this.status;
   		}
	}
	
	
	/**
	 * Signature as described by Facebook api documentation
	 * @var String read only
	 */
	function get sig():String{
		var a:Array = [];
		for( var p:String in this.args ){
			if( p !== 'sig' ){
				a.push( p + '=' + this.args[p] );
			}
		}
		a.sort();
		var s:String = '';
		for( var i:Number = 0; i < a.length; i++ ){
			s += a[i];
		}
		s += Facebook.SECRET;
		return new md5( s ).toString();
	}	
	
	
	
	/**
	 * Constructor
	 */
	function FacebookXML( dataClass:Function ){
		super();
		this.dataClass = dataClass;
		this.reset();
	}
	
	

	/**
	 * Clear object for re-use.
	 * Although it is recommended to construct a new object for each call
	 */
	function reset():Void{
		this.clearTimeout();
		this.ignoreWhite = true;
		this.tree = { };
		this.parseXML('');
		this.status = 0;
		this.loaded = false;
		this.args = {
			v: '1.0',
			api_key: Facebook.API_KEY,
			format: 'XML'
		};
	}
	
	
	
	/**
	 * Set a name value pair to be sent in request postdata
	 */
	function setRequestArgument( name:String, value:String ):Void{
		this.args[name] = value;	
	}
	
		
	
	/**
	 * Make call to REST server
	 * @param String name of Facebook api method, e.g. "facebook.photos.getAlbums"
	 * @param String optional URL of script defaults to Facebook.REST_URL
	 */
	function post( method:String, u:String ):Boolean {
		// check if object already in use
		if( this.timeoutID != null ){
			throw 'FacebookXML instance is already waiting for data';
		}
		// use Facebook REST url by default		
		if( !u ){
			u = Facebook.REST_URL;
		}
		// set Facebook api method if passed
		if( !method && u === Facebook.REST_URL ){
			throw "All calls to REST server must declare a method";
		}
		if( method ){
			this.setRequestArgument( 'method', method );
			switch( method ){
			case 'facebook.auth.getSession':
			case 'facebook.auth.createToken':
				break;
			default:
				// Method requires session to exist
				if( !Facebook.SESSION_KEY ){
					throw "method requires a session key ("+method+")";
				}
				this.setRequestArgument( 'session_key', Facebook.SESSION_KEY );
				// Adding time to callID for safer uniqueness - 
				// This needs some testing - still problematic if lots of clients?
				var call_id:String = ( new Date().valueOf() ).toString() + ( ++FacebookXML.callID ).toString();
				this.setRequestArgument( 'call_id', call_id );
			}
		}
		// using loadvars to post request because it is "application/x-www-form-urlencoded"
		// Response will get loaded back into this object
		var Poster:LoadVars = new LoadVars();
		for( var p:String in this.args ){
			Poster[p] = this.args[p];
		}
		Poster.sig = this.sig;
		Poster.addRequestHeader( 'User-Agent', Facebook.USER_AGENT );
		Poster.addRequestHeader( 'Referer', _root._url );
		if( ! Poster.sendAndLoad( u, this, 'POST') ){
			this.onError( "Failed to post to url "+ u );
			return false;
		}
		// wait for response.
		this.setTimeout();
		return true;
	}
	
	

	
	
	/**
	 * @internal
	 * Overloaded XML.onData callback
	 */
	private function onData( src:String ):Void {
		this.loaded = true;
		this.clearTimeout();
		if( this.status ){
			// error already raised - probably timeout
			return;
		}
		if( src == null ){
			// No XML Document
			this.onError( 'XML document was not loaded' );
			return;
		}
		// response XML and test status again
		this.parseXML( src );
		if( this.status ){
			// Bad XML document
			this.onError( this.statusDetail );
			return;
		}
		// XML ok, but could be error response.
		// parse into generic tree structure
		this.tree = this.parseTree( this.firstChild );
		if( !this.tree ){
			this.status = 2;
			this.onError( this.statusDetail );
			return;
		}
		// build error object if error reponse
		if( this.firstChild.nodeName == 'error_response' ){
			this.status = 1;
			this.onError( "Error " + this.tree.error_code + ", " + this.tree.error_msg );
			return;
		}
		else if( this.tree.fb_error != null ){
			// alternative error XML.
			this.status = 1;
			this.onError( "Error " + this.tree.fb_error.code + ", " + this.tree.fb_error.msg );
			return;
		}
		// convert tree to known object types
		if( this.dataClass ){
			// call static build method with raw data
			this.tree = this.dataClass.build.apply( null, [this.tree] );
		}
		//  Fully parsed valid Facebook XML
		this.onLoad( this.tree );
	}
	
	
	
	
	/**
	 * Default onLoad handler - you should define your own in client code
	 */
	public function onLoad( tree:Object ):Void {
		_global.trace("FacebookXML loaded, but no onLoad handler defined");
	}
	
	
	
	/**
	 * Default onError handler.. onLoad(false) is NOT called on error
	 */
	public function onError( detail:String ):Void {
		_global.trace("FacebookXML error - no onError handler defined");
		_global.trace( detail );
	}	
	
	
	
	
	
	/**
	 * Recursive XML tree parsing function
	 */
	private function parseTree( elNode:XMLNode, Parent:Object ):Object {
		if( elNode == null ){
			return null;
		}
		var isArray:Boolean = elNode.attributes['list'] == 'true';
		if( Parent == null ){
			// Root entry.. should probably check document element for namespace or something
			Parent = isArray ? [ ] : { };
		}
		for( var i:Number = 0; i < elNode.childNodes.length; i++ ){
			var elChild:XMLNode = elNode.childNodes[i];
			if( elChild.childNodes.length == 0 ){
				continue;
			}
			var key:String = isArray ? i : elChild.nodeName;
			if( elChild.firstChild.nodeType === 3 ){
				// single text value
				Parent[ key ] = elChild.firstChild.nodeValue;
			}
			else if( elChild.attributes['list'] == 'true' ){
				Parent[ key ] = [ ];
				this.parseTree( elChild, Parent[ key ] );
			}
			else {
				Parent[ key ] = { };
				this.parseTree( elChild, Parent[ key ] );
			}
		} 
		return Parent;
	}
	

	
	
	/**
	 * @param String dot-separated path to value required. pass "" to get root node
	 * @return Mixed
	 */	
	function getResponseArgument( p:String ){
		if( !p ){
			return this.tree;
		}
		var path:Array = p.split('.');
		var Node:Object = this.tree;
		while( path.length > 0 ){
			Node = Node[ path.shift() ];
			if( Node == null ){
				break;
			}
		}
		return Node;
	}

	
	
	/**
	 * @internal
	 */
	private function onTimeout():Void {
		this.clearTimeout();
		this.status = 3;
		this.onError( this.statusDetail );
	}
	
	
	
	
	/**
	 * @internal
	 */
	private function setTimeout():Void {
		this.clearTimeout();
		this.timeoutID = setInterval( this, 'onTimeout', this.timeout );
	}
	
	
	
	
	/**
	 * @internal
	 */
	private function clearTimeout():Void {
		if( this.timeoutID !== null ){
			clearInterval( this.timeoutID );
			this.timeoutID = null;
		}
	}

	
	
	
}
