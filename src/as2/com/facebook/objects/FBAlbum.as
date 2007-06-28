/*
  <album>
    <aid>34595963571485</aid>
    <cover_pid>34595991612812</cover_pid>
    <owner>1240077</owner>
    <name>Films you will never see</name>
    <created>1132553109</created>
    <modified>1132553363</modified>
    <description>No I will not make out with you</description>
    <location>York, PA</location>
  </album>
*/


import com.facebook.objects.FBObject;
import com.facebook.objects.FBPhoto;


/**
 * 
 */
class com.facebook.objects.FBAlbum extends FBObject {
	
	/** standard members */	
	var aid:String = '';	
	var cover_pid:String = '';	
	var owner:String = '';	
	var name:String = '';	
	var created:Date;	
	var modified:Date;	
	var description:String = '';	
	var location:String = '';	
	var link:String = '';	
	var size:Number = 0;	
	
	/**  */
	var coverPhoto:FBPhoto;
	
	
	/** 
	 * Constructor 
	 */
	function FBAlbum(){
		super();
		this.created = new Date();
		this.modified = new Date();
	}
	
	
	/**
	 * Create new object of this class from raw data
	 */
	static function build( data:Object ):FBAlbum {
		var Obj:FBAlbum = new FBAlbum();
		Obj.setProperties( data );
		return Obj;
	}
	

	
	
	
	
	
	
	
	
	
}