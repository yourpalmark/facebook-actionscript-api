<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>	 	
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>	
	</head>
	<body>
		<div id="fb-root"></div>
		<div id="flashContent">
			<h1>You need at least Flash Player 9.0 to view this page.</h1>
			<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>
		</div>  
		<script type="text/javascript">
			//Dynamic publishing with swfObject 
			
			//A 'name' attribute with the same value as the 'id' is REQUIRED for Chrome/Mozilla browsers
			swfobject.embedSWF("FlashWebExample.swf?<? echo(time()) ?>", "flashContent", "650", "700", "9.0", null, null, null, {name:"flashContent"}); 			
		</script>
	</body>
</html>