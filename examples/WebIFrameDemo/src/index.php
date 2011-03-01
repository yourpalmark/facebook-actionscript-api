<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	 	<!-- Include support librarys first -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>		
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		
		<script type="text/javascript">
		
		
			var APP_ID = "YOUR_APP_ID";			
			var REDIRECT_URI = "http://apps.facebook.com/YOUR_APPLICATION/";		
									
			var PERMS = "email,publish_stream,offline_access,read_stream"; //comma separated list of extended permissions
			
			function init() {				
				FB.init({appId:APP_ID, status: true, cookie: true});
				FB.getLoginStatus(handleLoginStatus);
			}
			
			function handleLoginStatus(response) {
				if (response.session) { //Show the SWF
				
					$('#ConnectDemo').append('<h1>You need at least Flash Player 9.0 to view this page.</h1><p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" /></a></p>');					
					
					//A 'name' attribute with the same value as the 'id' is REQUIRED for Chrome/Mozilla browsers
					swfobject.embedSWF("IFrameDemo.swf?<? echo(time()) ?>", "ConnectDemo", "550", "600", "9.0", null, null, null, {name:"ConnectDemo"});
					
				 } else { //ask the user to login
				 
				 	var params = window.location.toString().slice(window.location.toString().indexOf('?'));										
					top.location = 'https://graph.facebook.com/oauth/authorize?client_id='+APP_ID+'&scope='+PERMS+'&redirect_uri=' + REDIRECT_URI + params;
														
				  }
			}
			
			$(init);
		</script>
	</head>
	<body>
		<div id="fb-root"></div>
		<div id="ConnectDemo"></div>
	</body>
</html>