package com.facebook.graph.core
{
	import flash.external.ExternalInterface;

	public class FacebookJSBridge
	{
		public static const NS:String = "FBAS";
		
		public function FacebookJSBridge()
		{
			try
			{
				if( ExternalInterface.available )
				{
					ExternalInterface.call( script_js );
					ExternalInterface.call( "FBAS.setSWFObjectID", ExternalInterface.objectID );
				}
			}
			catch( error:Error ) {}
		}
		
		private const script_js:XML =
			<script>
				<![CDATA[
					function()
					{
						FBAS =
						{
							setSWFObjectID:
								function( swfObjectID )
								{
									FBAS.swfObjectID = swfObjectID;
								},
								
							init:
								function( opts )
								{
									FB.init( FB.JSON.parse( opts ) );
									
									FB.Event.subscribe( 'auth.sessionChange', function( response )
									{
										FBAS.updateSwfSession( response.session );
									} );
								},
								
							setCanvasAutoResize:
								function( autoSize, interval )
								{
									FB.Canvas.setAutoResize( autoSize, interval );
								},
								
							setCanvasSize:
								function( width, height )
								{
									FB.Canvas.setSize( { width: width, height: height } );
								},
								
							login:
								function( opts )
								{
									FB.login( FBAS.handleFacebookLogin, FB.JSON.parse( opts ) );
								},
								
							addEventListener:
								function( event )
								{
									FB.Event.subscribe( event, function( response )
									{
										FBAS.getSwf().handleJsEvent( event, FB.JSON.stringify( response ) );
									} );
								},
								
							handleFacebookLogin:
								function( response )
								{
									if( response.session == null )
									{
										FBAS.updateSwfSession( null );
										return;
									}
									
									if( response.perms != null )
									{
										// user is logged in and granted some permissions.
										// perms is a comma separated list of granted permissions
										FBAS.updateSwfSession( response.session, response.perms );
									}
									else
									{
										FBAS.updateSwfSession( response.session );
									}
								},
								
							logout:
								function()
								{
									FB.logout( FBAS.handleUserLogout );
								},
								
							handleUserLogout:
								function( response )
								{
									swf = FBAS.getSwf();
									swf.logout();
								},
								
							ui:
								function( params )
								{
									obj = FB.JSON.parse( params );
									FB.ui( obj );
								},
								
							getSession:
								function()
								{
									session = FB.getSession();
									return FB.JSON.stringify( session );
								},
								
							getLoginStatus:
								function()
								{
									FB.getLoginStatus( function( response )
									{
										if( response.session )
										{
											FBAS.updateSwfSession( response.session );
										}
										else
										{
											FBAS.updateSwfSession( null );
										}
									} );
								},
								
							getSwf:
								function getSwf()
								{
									return document.getElementById( FBAS.swfObjectID );
								},
								
							updateSwfSession:
								function( session, extendedPermissions )
								{
									swf = FBAS.getSwf();
									extendedPermissions = ( extendedPermissions == null ) ? '' : extendedPermissions;
									
									if( session == null )
									{
										swf.sessionChange( null );
									}
									else
									{
										swf.sessionChange( FB.JSON.stringify( session ), FB.JSON.stringify( extendedPermissions.split( ',' ) ) );
									}
								}
						};
					}
				]]>
			</script>;
		
	}
}