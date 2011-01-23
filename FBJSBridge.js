/*
  Copyright (c) 2010, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.

  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.

  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var divId;

var fb_path;
var fb_divID;
var fb_width;
var fb_height;
var fb_playerVersion;
var fb_flashVars;
var fb_params;
var fb_attributes;
var fb_expressInstallSwfurl;

function embedSWF(path, divID, width, height, playerVersion, flashVars,
                  params, attributes, expressInstallSwfurl) {

    this.fb_path = path;
    this.fb_divId = divID;

    this.fb_width = width;
    this.fb_height = height;
    this.fb_playerVersion = playerVersion;
    this.fb_flashVars = flashVars;

    this.fb_params = params;
    this.fb_attributes = attributes;
    this.fb_expressInstallSwfurl = expressInstallSwfurl;

    internalEmbedSwf();
}

function internalEmbedSwf() {
    swfobject.embedSWF(fb_path, fb_divId, fb_width, fb_height,
                      fb_playerVersion, fb_expressInstallSwfurl,
                      fb_flashVars, fb_params, fb_attributes);

    swfobject.registerObject(fb_divId);
}

function fb_init(opts) {
    FB.init(FB.JSON.parse(opts));

    FB.Event.subscribe('auth.sessionChange', function(response) {
        updateSwfSession(response.session);
    });
}

function fb_setCanvasAutoResize(autoSize, interval) {
    FB.Canvas.setAutoResize(autoSize, interval);
}

function fb_setCanvasSize(width, height) {
    FB.Canvas.setSize({width:width, height:height});
}

function fb_login(opts) {
    FB.login(handleFacebookLogin, FB.JSON.parse(opts));
}

function fb_addEventListener(event) {
    FB.Event.subscribe(event, function(response) {
        getSwf().handleJsEvent(event,FB.JSON.stringify(response));
    });
}

function handleFacebookLogin(response) {

    if (response.session == null) { updateSwfSession(null); return; }

    if (response.perms != null) {
      // user is logged in and granted some permissions.
      // perms is a comma separated list of granted permissions
      updateSwfSession(response.session, response.perms);
    } else {
        updateSwfSession(response.session);
    }
}

function fb_logout() {
    FB.logout(handleUserLogout);
}

function handleUserLogout(response) {
    swf = getSwf();
    swf.logout();
}

function fb_ui(params) {
    obj = FB.JSON.parse(params);
    FB.ui(obj);
}

function fb_getSession() {
    session = FB.getSession();
    return FB.JSON.stringify(session);
}

function fb_getLoginStatus() {
    FB.getLoginStatus(function(response) {
    if (response.session) {
        updateSwfSession(response.session);
    } else {
        updateSwfSession(null);
    }
    });
}

function getSwf() {
    return swfobject.getObjectById(fb_divId);
}

function updateSwfSession(session, extendedPermissions) {
    swf = getSwf();
    extendedPermissions = (extendedPermissions==null)
                        ? ''
                        : extendedPermissions;

    if (session == null) {
        swf.sessionChange(null);
    } else {
        swf.sessionChange(FB.JSON.stringify(session),
                          FB.JSON.stringify(extendedPermissions.split(',')));
    }
}
