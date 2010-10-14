<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	 	<!-- Include support librarys first -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
		
		<!-- Include FBJSBridge to allow for SWF to Facebook communication. -->
		<script type="text/javascript" src="FBJSBridge.js?<? echo(time()) ?>"></script>
		
		<script type="text/javascript">
			function embedPlayer() {
				var flashvars = {};
				embedSWF("YOUR_APPLICATION_URL/MediaUploadWeb.swf?<? echo(time()) ?>", "flashContent", "800", "600", "9.0");
			}
		</script>
  </head>
  <body>
<div id="fb-root">
</div>
  <div id="flashContent">
        	<h1>You need at least Flash Player 9.0 to view this page.</h1>
                <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
        </div>
        
<div id="debug"></div>
<script type="text/javascript">
			embedPlayer();
		</script>
</body>
</html>