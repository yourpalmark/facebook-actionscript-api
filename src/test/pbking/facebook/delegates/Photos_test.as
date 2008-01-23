package test.pbking.facebook.delegates
{
	import com.pbking.facebook.Facebook;
	import com.pbking.facebook.data.photos.FacebookAlbum;
	import com.pbking.facebook.delegates.photos.GetAlbums_delegate;
	import com.pbking.facebook.delegates.photos.GetPhotos_delegate;
	import com.pbking.facebook.delegates.photos.GetTags_delegate;
	import com.pbking.facebook.delegates.photos.Upload_delegate;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import flexunit.framework.TestCase;
	import flexunit.framework.TestSuite;
	
	import mx.graphics.codec.JPEGEncoder;
	
	import test.pbking.facebook.Facebook_test;
	
	public class Photos_test extends TestCase
	{
		private static var facebook:Facebook;
		
		[Embed (source="../../../assets/test_image.JPG")]
		private static var testImage:Class;
		
		private static var testAlbum:FacebookAlbum;
		
		// CONSTRUCTION //////////
		
		public function Photos_test(methodName:String=null)
		{
			super(methodName);
		}
		
		public static function suite(testFacebook:Facebook):TestSuite
		{
			facebook = testFacebook;
			
			var ts:TestSuite = new TestSuite();
			
			ts.addTest( new Photos_test("testUpload")); 
			ts.addTest( new Photos_test("testGetAlbums"));
			ts.addTest( new Photos_test("testGetPhotosForAlbum"));
			ts.addTest( new Photos_test("testGetPhotos"));
			ts.addTest( new Photos_test("testGetTags"));
			
			return ts;
		}
		
		// TESTS //////////

		/**
		 * Test Set Encode and Upload
		 */
		public function testUpload():void
		{
			var testDO:DisplayObject = new testImage();
			var bmd:BitmapData = new BitmapData(testDO.width, testDO.height, false, 0xFFFFFF);
			bmd.draw(testDO);
			
			var jpgEncoder:JPEGEncoder = new JPEGEncoder(85);
			var jpgStream:ByteArray = jpgEncoder.encode(bmd);
			
			facebook.photos.upload(jpgStream, null, "", addAsync(testUploadReply, Facebook_test.timeoutTime));
		}
		private function testUploadReply(e:Event):void
		{
			var d:Upload_delegate = e.target as Upload_delegate;
			assertTrue(d.errorMessage, d.success);
			assertTrue(d.uploadedPhoto);
		}
		
		public function testGetAlbums():void
		{
			facebook.photos.getAlbums(facebook.user, false, addAsync(testGetAlbumsReply, Facebook_test.timeoutTime));
		}
		private function testGetAlbumsReply(e:Event):void
		{
			var d:GetAlbums_delegate = e.target as GetAlbums_delegate;
			assertTrue(d.errorMessage, d.success);
			testAlbum = d.albums[0];
		}
		
		public function testGetPhotosForAlbum():void
		{
			facebook.photos.getPhotosForAlbum(testAlbum, addAsync(testGetPhotosForAlbumReply, Facebook_test.timeoutTime));
		}
		private function testGetPhotosForAlbumReply(e:Event):void
		{
			var d:GetPhotos_delegate = e.target as GetPhotos_delegate;
			assertTrue(d.errorMessage, d.success);
		}
		
		public function testGetPhotos():void
		{
			facebook.photos.getPhotos(facebook.user.uid, null, null, addAsync(testGetPhotosReply, Facebook_test.timeoutTime));
		}
		private function testGetPhotosReply(e:Event):void
		{
			var d:GetPhotos_delegate = e.target as GetPhotos_delegate;
			assertTrue(d.errorMessage, d.success);
			testAlbum.photos = d.photos;
		}
		
		public function testGetTags():void
		{
			var ta:FacebookAlbum = testAlbum;
			facebook.photos.getTags(ta.photos.source, true, addAsync(testGetTagsReply, Facebook_test.timeoutTime));
		}
		private function testGetTagsReply(e:Event):void
		{
			var d:GetTags_delegate = e.target as GetTags_delegate;
			assertTrue(d.errorMessage, d.success);
		}

	}
}