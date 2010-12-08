<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	 	<!-- Include support librarys first -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>		
	</head>
	<body>
		<div id="fb-root"></div><!-- required div tag -->
		<div id="flashContent">
			<h1>You need at least Flash Player 9.0 to view this page.</h1>
			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
		</div>
        
		<script type="text/javascript">			
			swfobject.embedSWF("MediaUploadWeb.swf?<? echo(time()) ?>", "flashContent", "800", "600", "9.0", null, null, null, {name:"flashContent"});
		</script>
	</body>
</html>