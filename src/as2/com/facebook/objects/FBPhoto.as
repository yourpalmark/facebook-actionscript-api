/*
  <photo>
    <pid>34585991612804</pid>
    <aid>34585963571485</aid>
    <owner>1240077</owner>
    <src>http://ip002.facebook.com/v11/135/18/8055/s1240077_30043524_2020.jpg</src>
    <src_big>http://ip002.facebook.com/v11/135/18/8055/n1240077_30043524_2020.jpg</src>
    <src_small>http://ip002.facebook.com/v11/135/18/8055/t1240077_30043524_2020.jpg</src>
    <link>http://www.facebook.com/photo.php?pid=30043524&id=8055</link>
    <caption>From The Deathmatch (Trailer) (1999)</caption>
    <created>1132553361</created>
  </photo>
  */
  
 
class com.facebook.objects.FBPhoto extends com.facebook.objects.FBObject {
	 
	/** standard members */
    var aid:String = '';	
	var pid:String = '';	
	var owner:String = '';	
	var created:Date;	
	var src:String = '';	
	var src_big:String = '';	
	var src_small:String = '';	
	var link:String = '';	
	var caption:String = '';	

	/** pseudo constants */
	static function get SIZE_SMALL():Number { return 100; }
	static function get SIZE_MEDIUM():Number { return 130; }
	static function get SIZE_LARGE():Number { return 604; }

	
	
	/** 
	 * Constructor 
	 */
	function FBPhoto(){
		this.created = new Date();
	}
	
	
	
	/**
	 * Create new object of this class from raw data
	 */
	static function build( data:Object ):FBPhoto {
		var Obj:FBPhoto = new FBPhoto();
		Obj.setProperties( data );
		return Obj;
	}		
		 
}
 