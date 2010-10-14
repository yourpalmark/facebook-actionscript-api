<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	 	<!-- Include support librarys first -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>
		
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		
		<!-- Include FBJSBridge to allow for SWF to Facebook communication. -->
		<script type="text/javascript" src="FBJSBridge.js?<? echo(time()) ?>"></script>
		<script type="text/javascript">
			function embedPlayer() {
				var flashvars = {};
				embedSWF("YOUR_DOMAIN/IFrameDemo.swf?<? echo(time()) ?>", "IFrameDemo", "550", "600", "9.0");
			}
			
			function init() {
				embedPlayer();
			}
			
			
			
			function redirect() {
				var params = window.location.toString().slice(window.location.toString().indexOf('?'));
				top.location = 'https://graph.facebook.com/oauth/authorize?client_id=YOUR_APPLICATION_ID&scope=email,publish_stream,offline_access,read_stream&redirect_uri=http://apps.facebook.com/YOUR_APPLICATION/'+params;
				  }
			}
			
			$(init);
		</script>
  </head>
  <body>
<div id="fb-root">
</div>
  <div id="IFrameDemo">
        <h1>You need at least Flash Player 9.0 to view this page.</h1><p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
  </div>
</body>
</html>