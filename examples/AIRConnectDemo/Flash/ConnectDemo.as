package {
	
	import com.facebook.events.FacebookEvent;
	import com.facebook.utils.DesktopSessionHelper;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.List;
	import fl.controls.TextArea;
	import fl.data.DataProvider;	
	
	public class ConnectDemo extends Sprite {
		
		public const API_KEY:String = 'YOUR_API_KEY';
		
		public var allPermissions:Array = ['email','offline_access','status_update','photo_upload','create_event','create_note','rsvp_event','sms','share_item','publish_stream','read_stream','read_mailbox','video_upload','create_listing'];
		
		//UI elements
		public var permList:List;
		public var loginBtn:Button;
		public var logoutBtn:Button;
		public var hasPermBtn:Button;
		public var checkPermBtn:Button;
		public var grantPermsBtn:Button;
		public var revokePermsBtn:Button;
		public var checkFacebook:CheckBox;
		public var statusTxt:TextArea;
		
		protected var dp:DataProvider;
		
		protected var desktopSessionHelper:DesktopSessionHelper;
		
		public function ConnectDemo(){
			super();
			
			dp = new DataProvider();
			while (allPermissions.length){ dp.addItem({label:allPermissions.shift()}); }			
			permList.allowMultipleSelection = true;
			permList.dataProvider = dp;
			
			loginBtn.addEventListener(MouseEvent.CLICK, onLoginClick, false, 0, true);
			logoutBtn.addEventListener(MouseEvent.CLICK, onLogoutClick, false, 0, true);
			hasPermBtn.addEventListener(MouseEvent.CLICK, onHasPermClick, false, 0, true);
			checkPermBtn.addEventListener(MouseEvent.CLICK, onCheckPermClick, false, 0, true);
			grantPermsBtn.addEventListener(MouseEvent.CLICK, onGrantPermsClick, false, 0, true);
			revokePermsBtn.addEventListener(MouseEvent.CLICK, onRevokePermsClick, false, 0, true);
			
			desktopSessionHelper = new DesktopSessionHelper();
			desktopSessionHelper.apiKey = API_KEY;
			desktopSessionHelper.addEventListener(FacebookEvent.CONNECT, onConnect, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.LOGOUT, onLogout, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.LOGIN_FAILURE, onLoginFailur, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.PERMISSIONS_LOADED, onPermissionsLoaded, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.PERMISSION_STATUS, onPermissionStatus, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.PERMISSION_CHANGE, onPermissionChange, false, 0, true);
			desktopSessionHelper.addEventListener(FacebookEvent.ERROR, onError, false, 0, true);									
		}
		
		protected function onLoginClick(event:MouseEvent):void {
			desktopSessionHelper.login();
		}
		protected function onLogoutClick(event:MouseEvent):void {
			desktopSessionHelper.logout();
			desktopSessionHelper.shutdown();
			stage.nativeWindow.close();
		}
		protected function onHasPermClick(event:MouseEvent):void {			
			desktopSessionHelper.hasPermission(permList.selectedItem.label, checkFacebook.selected);
		}
		protected function onCheckPermClick(event:MouseEvent):void {
			statusTxt.appendText('check permission: ' + permList.selectedItem.label + ' : ' + desktopSessionHelper.checkPermission(permList.selectedItem.label) + '\n');
		}
		protected function onGrantPermsClick(event:MouseEvent):void {
			var perms:Array = [];
			for each(var obj:Object in permList.selectedItems){ perms.push(obj.label); }
			desktopSessionHelper.grantPermissions(perms)	
		}
		protected function onRevokePermsClick(event:MouseEvent):void {
			var perms:Array = [];
			for each(var obj:Object in permList.selectedItems){	perms.push(obj.label); }
			desktopSessionHelper.revokePermissions(perms);
		}
		
		protected function onConnect(event:FacebookEvent):void {
			statusTxt.appendText('on connect \n');	
		}
		protected function onLogout(event:FacebookEvent):void {
			statusTxt.appendText('on logout \n');
		}
		protected function onLoginFailur(event:FacebookEvent):void {
			statusTxt.appendText('on login failure \n');
		}
		protected function onPermissionsLoaded(event:FacebookEvent):void {
			statusTxt.appendText('on permission loaded \n');
		}
		protected function onPermissionStatus(event:FacebookEvent):void {
			statusTxt.appendText('on permission status:' + event.permission + ' : ' + event.hasPermission + '\n');
		}		
		protected function onPermissionChange(event:FacebookEvent):void {
			statusTxt.appendText('on permission change:' + event.permission + ' : ' + event.hasPermission + '\n');
		}
		protected function onError(event:FacebookEvent):void {
			statusTxt.appendText('on error:' + event.error.errorMsg + '\n');
		}
	}
}