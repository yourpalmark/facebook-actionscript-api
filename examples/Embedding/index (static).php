<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
	<head>
	 	
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
		<script type="text/javascript" src="http://connect.facebook.net/en_US/all.js"></script>		
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
		
		<script type="text/javascript">
			//This example uses static publishing with swfObject. Login is handled in the swf.
						
			//Note that the inner object tag requires an id and name attribute with the same value, and that its different from the outer object tag id. 
			//This 'name' attribute is REQUIRED for Chrome/Mozilla browsers. 
			
			swfobject.registerObject("myId", "9.0.115");			
		</script>
  </head>
<body>
	<div id="fb-root"></div>
	<div>	
		<object id="myId" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="650" height="700">
        <param name="movie" value="YOUR_SWF.swf" />
        <!--[if !IE]>-->
        <object id="flashContent" name="flashContent" type="application/x-shockwave-flash" data="YOUR_SWF.swf" width="650" height="700">
        <!--<![endif]-->
          <p>Alternative content</p>
        <!--[if !IE]>-->
        </object>
        <!--<![endif]-->
      </object>
	</div>  	
</body>
</html>