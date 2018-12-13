<f:view>
    <sakai:view title="#{msgs['custom.chatroom']}">
        <h:outputText value="#{Portal.latestJQuery}" escape="false"/>
        <sakai:script contextBase="/sakai-chat-tool" path="/js/chatscript.js"/>
        <script type="text/javascript">
            if ( window.frameElement) window.frameElement.className='wcwmenu';
        </script>
		<style>
		
		#remote {
			
			-webkit-transform: rotateY(180deg);
			height: 500px;
			width: 98%;
			margin:10px;
			border-radius: 5px;
			
			vertical-align: middle;
		}
		#remote2 {
			
			-webkit-transform: rotateY(180deg);
			height: 40%;
			width: 100%;
			margin:0px;
			border-radius: 5px;
			
			vertical-align: middle;
		}
		#remoteVideo {
			-webkit-transition-duration: 2s;
			-webkit-transition-property: opacity;
			height: 100%;
			width: 100%;
			opacity: 0;
			background:black;
			border-radius: 5px;
			border: 2px solid;
		}
		#remoteVideo2 {
			-webkit-transition-duration: 2s;
			-webkit-transition-property: opacity;
			height: 100%;
			width:100%;
			opacity: 0;
			background:black;
			border-radius: 5px;
			border: 2px solid;
		}
		#info-bar {
			
			
			color: black;
			font-size: 20px;
			font-weight: bold;
			height: 100px;
			line-height: 38px;
			position: absolute;
			text-align: center;
			width: 100%;
			text-shadow: 1px 1px rgb(14, 105, 137);
			
			box-shadow: 0 0 6px white;
		}
		#info-bar2 {
			<!--background-color: #15DBFF;-->
			bottom: 55%;
			color: black;
			font-size: 10px;
			font-weight: bold;
			height: 100px;
			line-height: 38px;
			position: absolute;
			text-align: center;
			width: 100%;
			text-shadow: 1px 1px rgb(14, 105, 137);
			<!--border: 2px solid rgb(47, 102, 118);-->
			box-shadow: 0 0 6px white;
		}
		#stats-bar {
			background-color: rgba(255, 255, 255, 0.92);
			top: 20px;
			left: 20px;
			color: black;
			font-size: 17px;
			line-height: 1.5em;
			position: absolute;
			border: 2px solid rgba(0, 0, 0, 0.82);
			border-radius: 7px;
			font-family: Arial;
			
			text-align: left;
			display: none;
		}

		#stats-bar-html {
			padding: 5px 10px;
		}

		#hide-stats-bar {
			float: right;
			cursor: pointer;
			color: red;
			font-size: 20px;
			font-weight: bold;
			margin-right: 8px;
		}

		#hide-stats-bar:hover, #hide-stats-bar:active {
			color: #6c1414;
		}
		
		.modal1 {
			display: block; /* Hidden by default */
			position: fixed; /* Stay in place */
			z-index: 1; /* Sit on top */
			padding-top: 300px; /* Location of the box */
			left: 0;
			top: 0;
			width: 100%; /* Full width */
			height: 100%; /* Full height */
			overflow: auto; /* Enable scroll if needed */
			background-color: rgb(0,0,0); /* Fallback color */
			background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
		}

		/* Modal Content */
		.modal-content1 {
			background-color: #fefefe;
			margin: auto;
			padding: 20px;
			border: 1px solid #888;
			width: 35%;
			text-align: center;
			border-radius: 10px;
		}
		@media only screen and (max-width: 800px) {
			.modal-content1 {
				width: 80%;
			}
			#remote {
				height: 100%;
				width: 100%;
				margin: 0;
			}
			#livestream {
				height: 19em !important;
			}
			#remoteVideo {
				width:100%;
			}
			#remote2 {
				height: 100%;
				width: 100%;
				margin: 0;
			}
			#livestream2 {
				height: 19em !important;
			}
			#remoteVideo2 {
				width:100%;
			}
		}
		
		@media only screen and (min-width: 428px) and (max-width: 800px)
		{
			#livestream{
				height: 35em !important;
			}
			#remoteVideo {
				width:100%;
			}
			#livestream2{
				height: 35em !important;
			}
			#remoteVideo2 {
				width:100%;
			}
		}
		
		/* The Close Button */
		.close1 {
			color: #aaaaaa;
			float: right;
			font-size: 28px;
			font-weight: bold;
		}

		.close1:hover,
		.close1:focus {
			color: #000;
			text-decoration: none;
			cursor: pointer;
		}
		</style>	
		<script type="text/javascript" src="/sakai-chat-tool/jsp/roomCheck.js"></script>
        <h:form id="topForm">
            <h:inputHidden id="chatidhidden" value="#{ChatTool.currentChatChannelId}" />
            <sakai:tool_bar rendered="#{ChatTool.canManageTool || ChatTool.siteChannelCount > 1 || ChatTool.maintainer}">
				<h:commandLink id="start" action="#" rendered="#{ChatTool.canManageTool}">
                    <h:outputText value="Start"/>
                </h:commandLink>
                <h:commandLink id="stop" action="#" rendered="#{ChatTool.canManageTool}" style="display: none;">
                    <h:outputText value="ShutDown"/>
                </h:commandLink>
                <h:commandLink action="#{ChatTool.processActionListRooms}" rendered="#{ChatTool.canManageTool}">
                    <h:outputText value="#{msgs.manage_tool}" />
                </h:commandLink>
                <h:commandLink action="#{ChatTool.processActionListRooms}" rendered="#{ChatTool.siteChannelCount > 1}">
                    <h:outputText value="#{msgs.change_room}" />
                </h:commandLink>
                <h:commandLink rendered="#{ChatTool.maintainer}"
                action="#{ChatTool.processActionPermissions}">
                    <h:outputText value="#{msgs.permis}" />
                </h:commandLink>
            </sakai:tool_bar>
            <div id='buttonEvent' show="true" style="display: none;" >
            	<button id="dayHoc">Day Hoc</button>
            	<button id="vanDap">Bao Cao</button>
            </div>
			
			<div id="isHaveEx" check="false">
				
			</div>
            
			
			<!--FIX--> 
			
			<div class="panel panel-chat panel-default" id="livestream" style="float: left;width: 69%; height:41.5em;max-height:100%;padding: 0;margin: 14px 0 0 0;">
				<div class="panel-heading">
				
					<h3 class="insColor insBak insBorder" style="width:80%;">
						LiveStream
						<button id="button" style="right:0;display:none">LiveStream</button>
						<button id="cancells"  style="right:0;display: none">cai nay la getid nhung dat id sai ma lam bieng sua (khong duoc xoa)</button>
						
					</h3>
					
				</div>
				
				<div class="panel-body panel-body-chat tab-content backgroundls" style="max-width: 100%;position: relative;">
				
					<!--voice-->
					
					<div class="panel panel-chat panel-default" id="livestream2" style="left:10px;width: 15%;height: 6.5em;max-height: 100%;padding: 0px;margin: 0px;position: absolute;z-index: 2;bottom: 6px;display: none;">
						
						
						
							<video id="remoteVideo2" autoplay playsinline>
							</video>
							<div id="info-bar2"></div>
						
							
					</div> 

					<!--live stream-->
					<div id="card">
						<div id="remote">
							<video controls="controls" id="remoteVideo" autoplay playsinline>
							</video>
						</div>
					</div>

					<div id="info-bar"></div>
				
				</div>
			</div> 
			
			<!-- <sakai:view_title value="Chat Box"/> -->
            <div class="panel panel-chat panel-default" style="width:29%">
                <div class="panel-heading">
                    <sakai:instruction_message value="#{ChatTool.datesMessage}" rendered="#{ChatTool.datesMessage ne null}" />
                <!--    <sakai:view_title value="#{ChatTool.viewingChatRoomText}"/> -->
					
					<h3 style="text-align:center">CHAT BOX</h3>
                    <h:panelGroup styleClass="chat-block">
                        <h:panelGroup styleClass="viewoptions-grp">
                        
                            <h:selectOneMenu id="viewOptions" value="#{ChatTool.viewOptions}" onchange="this.form.submit();">
                                <f:selectItem itemValue="1" itemLabel="#{msgs.timeOnly}" />
                                <f:selectItem itemValue="3" itemLabel="#{msgs.timeAndDate}" />
                                <f:selectItem itemValue="2" itemLabel="#{msgs.dateOnly}" />
                                <f:selectItem itemValue="0" itemLabel="#{msgs.neitherDateOrTime}" />
                                <f:selectItem itemValue="4" itemLabel="#{msgs.uniqueid}" />
                            </h:selectOneMenu> 
                        </h:panelGroup>
                        <h:panelGroup styleClass="msgoptions-grp">
                        
                            <h:selectOneMenu id="messageOptions" value="#{ChatTool.messageOptions}" onchange="this.form.submit();">
                                <f:selectItems value="#{ChatTool.messageOptionsList}" />
                            </h:selectOneMenu>
                        </h:panelGroup>
                    </h:panelGroup>
                </div>

                <ul class="nav nav-tabs" role="tabpanel" style="display:block;">
                    <li class="active">
                        <a href="#chatListWrapperCont" role="tab" data-toggle="tab"><span><h:outputText value="#{msgs.messages}" /></span></a>
                    </li>
                    <li>
                        <a href="#chatPresenceWrapper" role="tab" data-toggle="tab"><span><h:outputText value="#{msgs.lay_user}" /></span></a>
                    </li>
                </ul>
			
                <div class="panel-body panel-body-chat tab-content" id="chatLeft">
                    <div id="chatListWrapperCont" class="chatListWrapperCont tab-pane active">
                        <div id="chatListWrapper" class="chatListWrapper">
                         <!--   <div class="chatListHeadWrapper">
                                <h:outputText value="#{msgs.lay_note}" rendered="#{ChatTool.canRenderAllMessages}" />
                                <h:outputFormat value="#{msgs.lay_restricted_note_days}" rendered="#{ChatTool.canRenderDateMessages}" >
                                    <f:param value="#{ChatTool.currentChannel.chatChannel.timeParam}" />
                                </h:outputFormat>
                                <h:outputFormat value="#{msgs.lay_restricted_note_messages}" rendered="#{ChatTool.canRenderNumberMessages}" >
                                    <f:param value="#{ChatTool.currentChannel.chatChannel.numberParam}" />
                                </h:outputFormat>
                                <h:outputText value="#{msgs.lay_restricted_note_none}" rendered="#{ChatTool.canRenderNoMessages}" />
                            </div> -->
                            <div id="chat2_messages_shown_total" class="shown_total"></div>
                            <script type="text/javascript">
                                var chat2_totalMessages = <h:outputText value="#{ChatTool.roomMessagesCount}" />;
                                var chat2_shownMessages = chat2_totalMessages;
                                var chat2_messageCountTemplate = "<h:outputText value="#{ChatTool.messagesShownTotalText}" />"; // replace *SHOWN* and *TOTAL*
                                var chat2_messagesUnreadedTemplate = "<h:outputText value="#{ChatTool.unreadedMessagesText}" />"; // replace *SHOWN* and *TOTAL*
                                var unreadedMessages = 0;
                            </script>
                            <sakai:messages  rendered="#{!empty facesContext.maximumSeverity}" />
                            <div id="Monitor" class="chatListMonitor">
                                <%@ include file="roomMonitor.jspf" %>
                            </div>
                        </div>
                        <div class="scrollBottom hide" title="<h:outputText value="#{ChatTool.unreadedMessagesText}" />">
                            <span class="newMessages" aria-label="<h:outputText value='#{msgs.unreaded}' />"></span>
                            <span class="scrollIcon fa fa-angle-down fa-2x" aria-label="<h:outputText value='#{msgs.unreaded}' />"></span>
                        </div>
                    </div>
                    <div id="chatPresenceWrapper" class="chatListOnline tab-pane">
                        <h3 class="chatListHeadWrapper">
                            <h:outputText value="#{msgs.lay_user}" />
                        </h3>
                        <ul name="presence" id="presence" class="wcwmenu presenceList">
                        </ul>
                    </div>
                </div>    
                <div class="panel-footer">
                    <f:subview id="controlPanel" rendered="#{ChatTool.canPost}">
                        <div>
                            <div id="errorSubmit" class="alertMessage" style="display:none">
                                <h:outputText value="#{msgs['therewaspro']}" />
                            </div>
                            <c:out value="<textarea id='topForm:controlPanel:message' value='" escapeXml="false" /><h:outputText value="#{ChatTool.newMessageText}" /><c:out value="' placeholder='" escapeXml="false" /><h:outputText value="#{msgs['control.lab']}" /><c:out value="' rows='3' cols='125'></textarea>" escapeXml="false" /> 
                            <div class="act">
                                <h:commandButton type="button" id="submit" value="#{msgs['control.post']}" styleClass="active" disabled="true"  />
                                <h:commandButton type="button" id="reset" value="#{msgs['control.clear']}" disabled="true" />
                            </div>
                        </div>
                    </f:subview>
                </div>
            </div>
			 
        </h:form>

        <t:div styleClass="messageInformation chat-post-warning" rendered="#{!ChatTool.canPost && ChatTool.datesRestricted}">
            <h:outputText value="#{msgs.custom_date_restricted}" />
            <h:outputText value="#{ChatTool.datesMessage}" />
        </t:div>
        <p style="clear:both;display:block;"></p>

        <div class="modal fade" tabindex="-1" role="dialog" id="removemodal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <span class="close" data-dismiss="modal" aria-label="<h:outputText value="#{msgs['gen.cancel']}" />" aria-hidden="true">&times;</span>
                        <h4 class="modal-title"><h:outputText value="#{msgs['delete.delete']}" /></h4>
                    </div>
                    <div class="modal-body">
                        <p><h:outputText value="#{msgs['delete.sure']}" /></p>
                        <c:out value="<table>" escapeXml="false" />
                            <c:out value="<tr>" escapeXml="false" />
                                <c:out value="<th>${msgs['gen.from']}</th>" escapeXml="false" />
                                <c:out value="<td id='owner'></td>" escapeXml="false" />
                            <c:out value="</tr>" escapeXml="false" />
                            <c:out value="<tr>" escapeXml="false" />
                                <c:out value="<th>${msgs['gen.date']}</th>" escapeXml="false" />
                                <c:out value="<td id='date'></td>" escapeXml="false" />
                            <c:out value="</tr>" escapeXml="false" />
                            <c:out value="<tr>" escapeXml="false" />
                                <c:out value="<th>${msgs['gen.mess']}</th>" escapeXml="false" />
                                <c:out value="<td id='message'></td>" escapeXml="false" />
                            <c:out value="</tr>" escapeXml="false" />
                        <c:out value="</table>" escapeXml="false" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" id="cancelButton" class="btn btn-default" data-dismiss="modal"><h:outputText value="#{msgs['gen.cancel']}" /></button>
                        <button type="button" id="deleteButton" class="btn btn-primary"><h:outputText value="#{msgs['gen.delete']}" /></button>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            chatscript.currentChatChannelId = "<h:outputText value="#{ChatTool.currentChatChannelId}" />";
            chatscript.pollInterval = "<h:outputText value="#{ChatTool.pollInterval}" />";
            chatscript.init();
        </script>
        <!--asd-->
		
        <script type="text/javascript">
            setMainFrameHeight('<h:outputText value="#{ChatTool.framePlacementId}" />');
        </script>

        <!--event input key mss-->
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded",function(){
				
				var start=document.getElementById("topForm:start");
				if (start!=null){
					var check=document.getElementById("buttonEvent");
					start.onclick=function(e){
						e.preventDefault();
						if (document.getElementById("isHaveEx").getAttribute("check")=="false") {
							alert("chua co ex");
							return;
						}
						
						if (check.getAttribute("show")=="true") {
							check.style.display="block";
							check.setAttribute("show","false");
						}
						else{
							check.style.display="none";
							check.setAttribute("show","true");
						}
						
					}
					setTimeout(function(){
						//alert(roomCheck.type);
						if (roomCheck.type!=null && roomCheck.type!="null"){
						start.style.display="none";
						document.getElementById("topForm:stop").style.display="block";
						}
					
					},1500);
					
					document.getElementById("dayHoc").onclick=function(e){
						e.preventDefault();
						start.style.display="none";
						document.getElementById("topForm:stop").style.display="block";
						check.style.display="none";
						check.setAttribute("show","true");
						changeType("dayHoc","","");
						dangLive(portal.user.id);
					}
					document.getElementById("vanDap").onclick=function(e){
						e.preventDefault();
						start.style.display="none";
						document.getElementById("topForm:stop").style.display="block";
						check.style.display="none";
						check.setAttribute("show","true");
						changeType("vanDap","","");

					}
					document.getElementById("topForm:stop").onclick=function(e){
						e.preventDefault();
						start.style.display="block";
						document.getElementById("topForm:stop").style.display="none";
						changeType("null","","");
						stop();
						document.getElementById("cancells").click();
					}

				}
			setTimeout(function(){
						//alert(roomCheck.type);
						
						if (roomCheck.type=="vanDap") {
							document.getElementById("livestream2").style.display="initial";
							checkPresence2();	
						}
						
					},1500);
			
			var button=document.getElementById("button");
			button.onclick=function(e){
				e.preventDefault();
				dangLive(roomCheck.nguoiCoQuyenLive);

			}


				
			var textarea= document.getElementById("topForm:controlPanel:message");
			textarea.addEventListener("input",function(){

				if (textarea.value != ""){
					document.getElementById("topForm:controlPanel:submit").disabled = false;
					document.getElementById("topForm:controlPanel:reset").disabled= false;
					
				}
				else {
					document.getElementById("topForm:controlPanel:submit").disabled = true;
					document.getElementById("topForm:controlPanel:reset").disabled= true;
					
				}

			},false)
					
			})
			
			
		</script>
		
		
		<script type="text/javascript" src="/sakai-chat-tool/js/socket.io.js"></script>

		<script type="text/javascript" src="/sakai-chat-tool/js/adapter.js"></script>
		<script type="text/javascript" src= "/sakai-chat-tool/js/RTCMultiConnection.min.js"></script>
		<script type="text/javascript" src= "/sakai-chat-tool/js/CodecsHandler.js"></script>
		<script type="text/javascript" src= "/sakai-chat-tool/js/IceServersHandler.js"></script>
		<script type="text/javascript" src= "/sakai-chat-tool/js/getStats.js"></script>
		
		<!--<script type="text/javascript">
            	document.addEventListener("DOMContentLoaded", function(event) {
   					
				
					// Get the <span> element that closes the modal
					

   					
					var y= document.getElementById("button");
					
					var t=window.location.href;
					var ta=t.indexOf('?s=');
					
						
						if(ta==-1)
						{
							window.location.href = t + "?s=" +id;
						}
					
			
 				}); 
            	
            </script> --> 
        <script>
			
			var id =document.getElementById("topForm:chatidhidden").value;
			(function() {
			var params = {},
				r = /([^&=]+)=?([^&]*)/g;

			function d(s) {
				
				return decodeURIComponent(s.replace(/\+/g, ' '));
			}
			
			var match, search = "?s=" +id;

			while (match = r.exec(search.substring(1)))
				params[d(match[1])] = d(match[2]);

			window.params = params;

		})();
		
		// http://www.rtcmulticonnection.org/docs/constructor/
		if (roomCheck.type=="vanDap"){
			// neu la nguoi dnag live
			if (roomCheck.nguoiDangLive==portal.user.id){
				
			var connection = new RTCMultiConnection("mute"+params.s);
			var connection2 = new RTCMultiConnection("voice"+params.s);
			}
			//neu la admin
			else if (document.getElementById("topForm:start")!=null) {
				
				var connection = new RTCMultiConnection(params.s);
				var connection2 = new RTCMultiConnection("avoice"+params.s);
			}
			//neu la user
			else {
				var connection = new RTCMultiConnection(params.s);
				var connection2 = new RTCMultiConnection("voice"+params.s);
			}
		}
		else {
			if (document.getElementById("topForm:start")==null){
				
			var connection = new RTCMultiConnection(params.s);
			var connection2 = new RTCMultiConnection("voice"+params.s);
			}
			else {
				var connection = new RTCMultiConnection("a"+params.s);
				var connection2 = new RTCMultiConnection("avoice"+params.s);
			}
		}
		
		
		// connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';
    	connection.socketURL = 'https://webrtcweb.com:9001/';
    	connection2.socketURL=	'https://webrtcweb.com:9001/';
	//	connection.socketURL = 'https://localhost:9001/';
	//	connection2.socketURL = 'https://localhost:9001/';
		
		connection.enableLogs = true;
		connection2.enableLogs= true;

		connection.session = {
			audio: true,
			video: true,
			oneway: true
		};
		connection2.session = {
			audio: true,
			video: true,
			oneway: true
		};
		
		// www.rtcmulticonnection.org/docs/sdpConstraints/
		connection.sdpConstraints.mandatory = {
			//OfferToReceiveAudio: true,
			OfferToReceiveVideo: true
		};
		connection2.sdpConstraints.mandatory = {
			//OfferToReceiveAudio: true,
			OfferToReceiveVideo: true
		};

		connection.getExternalIceServers = false;
		connection.iceServers = IceServersHandler.getIceServers();
		connection2.getExternalIceServers = false;
		connection2.iceServers = IceServersHandler.getIceServers();
		
		function setBandwidth(sdp) {
			sdp = sdp.replace(/b=AS([^\r\n]+\r\n)/g, '');
			sdp = sdp.replace(/a=mid:video\r\n/g, 'a=mid:video\r\nb=AS:10000\r\n');
			return sdp;
		}

		connection.processSdp = function(sdp) {
			var bandwidth = params.bandwidth;
			var codecs = params.codecs;
			
			if (bandwidth) {
				try {
					bandwidth = parseInt(bandwidth);
				} catch (e) {
					bandwidth = null;
				}

				if (bandwidth && bandwidth != NaN && bandwidth != 'NaN' && typeof bandwidth == 'number') {
					sdp = setBandwidth(sdp, bandwidth);
					sdp = BandwidthHandler.setVideoBitrates(sdp, {
						min: bandwidth,
						max: bandwidth
					});
				}
			}

			if (!!codecs && codecs !== 'default') {
				sdp = CodecsHandler.preferCodec(sdp, codecs);
			}
			return sdp;
		};
		connection2.processSdp = function(sdp) {
			var bandwidth = params.bandwidth;
			var codecs = params.codecs;
			
			if (bandwidth) {
				try {
					bandwidth = parseInt(bandwidth);
				} catch (e) {
					bandwidth = null;
				}

				if (bandwidth && bandwidth != NaN && bandwidth != 'NaN' && typeof bandwidth == 'number') {
					sdp = setBandwidth(sdp, bandwidth);
					sdp = BandwidthHandler.setVideoBitrates(sdp, {
						min: bandwidth,
						max: bandwidth
					});
				}
			}

			if (!!codecs && codecs !== 'default') {
				sdp = CodecsHandler.preferCodec(sdp, codecs);
			}
			return sdp;
		};
		
		connection.optionalArgument = {
			optional: [],
			mandatory: {}
		};
		connection2.optionalArgument = {
			optional: [],
			mandatory: {}
		};

		</script>

		<script>
		// DOM objects
		var remoteVideo = document.getElementById('remoteVideo');
		var remoteVideo2 = document.getElementById('remoteVideo2');
		var card = document.getElementById('card');
		var card2 = document.getElementById('card2');
		var containerDiv;

		if (navigator.mozGetUserMedia) {
			attachMediaStream = function(element, stream) {
				console.log("Attaching media stream");
				element.mozSrcObject = stream;
				element.play();
			};
			reattachMediaStream = function(to, from) {
				console.log("Reattaching media stream");
				to.mozSrcObject = from.mozSrcObject;
				to.play();
			};
		} else if (navigator.webkitGetUserMedia) {
			attachMediaStream = function(element, stream) {
				if (typeof element.srcObject !== 'undefined') {
					element.srcObject = stream;
				} else if (typeof element.mozSrcObject !== 'undefined') {
					element.mozSrcObject = stream;
				} else if (typeof element.src !== 'undefined') {
					element.src = URL.createObjectURL(stream);
				} else {
					console.log('Error attaching stream to element.');
				}
			};
			reattachMediaStream = function(to, from) {
				to.src = from.src;
			};
		} else {
			console.log("Browser does not appear to be WebRTC-capable");
		} 
		// onstream event; fired both for local and remote videos

		var infoBar = document.getElementById('info-bar');
		var infoBar2 = document.getElementById('info-bar2');
		//admin cancel livestream
		var cancells = document.getElementById('getId');

		var btnadmin= document.getElementById("topForm:test");
		
		
		connection.onstatechange = function(state) {
			infoBar.innerHTML = state.name + ': ' + state.reason;

			if(state.name == 'request-rejected' && params.p) {
				infoBar.innerHTML = 'Password (' + params.p + ') did not match with broadcaster, that is why your participation request has been rejected.<br>Please contact him and ask for valid password.';
			}

			if(state.name === 'room-not-available') {
				infoBar.innerHTML = 'Screen share session is closed or paused. You will join automatically when share session is resumed.';
			}
		};
		connection2.onstatechange = function(state) {
		//	infoBar2.innerHTML = state.name + ': ' + state.reason;

			if(state.name == 'request-rejected' && params.p) {
		//		infoBar2.innerHTML = 'Password (' + params.p + ') did not match with broadcaster, that is why your participation request has been rejected.<br>Please contact him and ask for valid password.';
			}

			if(state.name === 'room-not-available') {
		//		infoBar2.innerHTML = 'Screen share session is closed or paused. You will join automatically when share session is resumed.';
			}
		};
		
		connection.onstreamid = function(event) {
			infoBar.innerHTML = 'Remote peer is about to send his screen.';
		};
		connection2.onstreamid = function(event) {
			infoBar.innerHTML = 'Remote peer is about to send his screen.';
		};

		connection.onstream = function(e) {
			//alert(roomCheck.nguoiDangLive);
			/*if	(roomCheck.nguoiDangLive==portal.user.id ){
						//alert("da chan tieng");
						e.stream.getAudioTracks().forEach(function(track){
						e.stream.removeTrack(track);
						//.src="youtu.be/MLeIBFYY6UY";
					})}*/
			if	(roomCheck.nguoiDangLive!=portal.user.id ){
			if (e.type == 'remote') {
				connection.remoteStream = e.stream;
				
				infoBar.style.display = 'none';
				remoteStream = e.stream;
				
					
					/*if	(roomCheck.nguoiDangLive==portal.user.id ){
						
						e.stream.getAudioTracks().forEach(function(track){
						e.stream.removeTrack(track);
						
					})}*/

				
				
				attachMediaStream(remoteVideo, e.stream);
				waitForRemoteVideo();
				remoteVideo.setAttribute('data-id', e.userid);
				
				connection.socket.emit(connection.socketCustomEvent, {
					receivedYourScreen: true
				});
			}
			}
		};
		connection2.onstream = function(e) {

			
			if (e.type == 'remote') {
				var kiemtra= document.getElementById("topForm:start");
				if (roomCheck.type=="vanDap" && kiemtra!=null) {
					//alert("da chan vandap");
					e.stream.getAudioTracks().forEach(function(track){
					e.stream.removeTrack(track);})	
				}
				connection2.remoteStream = e.stream;
				
				
				infoBar2.style.display = 'none';
				remoteStream2 = e.stream;
				//var kiemtra= document.getElementById("topForm:start");
				
				attachMediaStream(remoteVideo2, e.stream);
				waitForRemoteVideo2();
				remoteVideo2.setAttribute('data-id', e.userid);
				
				connection2.socket.emit(connection2.socketCustomEvent, {
					receivedYourScreen: true
				});
			}
		};


		// if user left
		connection.onleave = function(e) {
			if(e.userid !== params.s) return;
			/*var start=document.getElementById("topForm:start");
			if (start==null) {
				changeType("null","","");
				start.style.display="block";
				document.getElementById("topForm:stop").style.display="none";
			}
			else {
				userTatLive();
			}*/
			
			transitionToWaiting();
			connection.onSessionClosed();
			//alert('Live stream off');
			location.reload();
		};
		connection2.onleave = function(e) {
			if(e.userid !== params.s) return;
			
			transitionToWaiting2();
			connection2.onSessionClosed();
			//alert('Live stream off');
		//	location.reload();
		};
		
		
		
		
		connection.onSessionClosed = function() {
			infoBar.innerHTML = 'Screen sharing has been closed.';
			try{
			infoBar.style.display = 'initial';
			statsBar.style.display = 'none';}
			catch{}
			connection.close();
			connection.closeSocket();
			connection.userid = connection.token();
			
			remoteVideo.pause();
			remoteVideo.src = 'https://cdn.webrtc-experiment.com/images/muted.png';
			//window.location.href = temo;
			setTimeout(checkPresence, 2000);
		};
		connection2.onSessionClosed = function() {
		//	infoBar2.innerHTML = 'Screen sharing has been closed.';
			
			connection2.close();
			connection2.closeSocket();
			connection2.userid = connection2.token();
			
			remoteVideo2.pause();
			remoteVideo2.src = 'https://cdn.webrtc-experiment.com/images/muted.png';
			//window.location.href = temo;
			setTimeout(checkPresence2, 2000);
		};

		connection.ondisconnected = connection.onSessionClosed;
		connection.onstreamended = connection.onSessionClosed;

		function waitForRemoteVideo() {
			// Call the getVideoTracks method via adapter.js.
			var videoTracks = remoteStream.getVideoTracks();

			if (videoTracks.length === 0 || remoteVideo.currentTime > 0) {

				transitionToActive();
			} else {
				setTimeout(waitForRemoteVideo, 1000);
			}
		}
		function waitForRemoteVideo2() {

			// Call the getVideoTracks method via adapter.js.
			var videoTracks2 = remoteStream2.getVideoTracks();
			if (videoTracks2.length === 0 || remoteVideo2.currentTime > 0) {
				transitionToActive2();
				
			} else {
				setTimeout(waitForRemoteVideo2, 1000);
			}
			
		}

		function transitionToActive() {
			remoteVideo.style.opacity = 1;
			card.style.webkitTransform = 'rotateY(180deg)';
		//	window.onresize();
		}
		function transitionToActive2() {
			remoteVideo2.style.opacity = 1;
		//	card2.style.webkitTransform = 'rotateY(180deg)';
		//	window.onresize();
		}

		function transitionToWaiting() {
				card.style.webkitTransform = 'rotateY(0deg)';
				remoteVideo.style.opacity = 0;
			}
		function transitionToWaiting2() {
			card2.style.webkitTransform = 'rotateY(0deg)';
			remoteVideo2.style.opacity = 0;
		}
		</script>

		<script>
		

		connection.socketCustomEvent = params.s;
		connection2.socketCustomEvent = params.s;
		function checkPresence() {
			if (roomCheck.nguoiDangLive!=portal.user.id){
			infoBar.innerHTML = 'Dang cho nguoi LiveStream';
			
			connection.checkPresence(params.s, function(isRoomExist) {
				if (isRoomExist === false) {
					infoBar.innerHTML = 'Dang cho nguoi LiveStream';

					setTimeout(function() {
						infoBar.innerHTML = 'Dang cho nguoi LiveStream';
						setTimeout(checkPresence, 1000);
					}, 4000);
					return;
				}
				
				infoBar.innerHTML = 'Joining room: ' + params.s;
				
				if (roomCheck.type=="vanDap"){
					//van dap thi nhung nguoi k phai nguoi dang live ket noi
					if (roomCheck.nguoiDangLive!=portal.user.id){
						connection.join("mute"+params.s);
						connection.join(params.s)
						//khong ket noi
					}
					else {connection.join("mute"+params.s);infoBar.innerHTML='Dang live';}
				}
				else {
					//k phai van dap thi nhung nguoi k phai admin ket noi
					if (document.getElementById("topForm:start")==null){
						connection.join(params.s);
						
					}
					else {connection.join("a"+params.s);infoBar.innerHTML='Dang live';}
				}
			});
			}
		}
		function checkPresence2(){
			try{
			connection2.checkPresence("voice"+params.s, function(isRoomExist) {
				if (isRoomExist === false) {
				//	infoBar2.innerHTML = 'Room does not exist: voice' + params.s;

					setTimeout(function() {
				//		infoBar2.innerHTML = 'Checking room: voice' + params.s;
						setTimeout(checkPresence, 1000);
					}, 4000);
					return;
				}
				//neu la admin
				//alert(roomCheck.type);
				if(roomCheck.type=="vanDap"){
				if (document.getElementById("topForm:start")!=null){
					connection2.join("mute"+params.s);
					//khong ket noi
				}
				else {connection2.join("voice"+params.s);
				//alert("in");
				}
				}
			});
		}catch{}
		}


		if(params.s) {
			checkPresence();
			//checkPresence2();
		}

		var dontDuplicate = {};
		connection.onPeerStateChanged = function(event) {
			if(!connection.getRemoteStreams(params.s).length) {
				if(event.signalingState === 'have-remote-offer') {
					try{
					infoBar.innerHTML = 'Received WebRTC offer from: ' + params.s;
				chatscript.doUpdateName();}

					catch{}
					//admin cancel livestream
					if (btnadmin!=null)
					{
						cancells.style.display = "initial";
					}
				}

				else if(event.iceGatheringState === 'complete' && event.iceConnectionState === 'connected') {
					try{
					
					infoBar.innerHTML = 'WebRTC handshake is completed. Waiting for remote video from: ' + params.s;}
					catch{}
				}
			}

			if(event.iceConnectionState === 'connected' && event.signalingState === 'stable') {
				if(dontDuplicate[event.userid]) return;
				dontDuplicate[event.userid] = true;

				if(DetectRTC.browser.name === 'Safari' || DetectRTC.browser.name === 'Edge') {
					// todo: getStats for safari/edge?
					return;
				}

				var peer = connection.peers[event.userid].peer;

				if(DetectRTC.browser.name === 'Firefox') {
					getStats(peer, (connection.remoteStream || peer.getRemoteStreams()[0]).getTracks()[0], function(stats) {
						onGettingWebRCStats(stats, event.userid);
					}, 1000);
					return;
				}

				getStats(peer, function(stats) {
					onGettingWebRCStats(stats, event.userid);
				}, 1000);
				
				//statsBar.style.display = 'block';
			}
		};

		var statsBar = document.getElementById('stats-bar');
		var statsBarHTML = document.getElementById('stats-bar-html');
		var NO_MORE = false;

		

		function onGettingWebRCStats(stats, userid) {
			if(!connection.peers[userid] || NO_MORE) {
				stats.nomore();
				return;
			}

			var html = 'Codecs: ' + stats.audio.recv.codecs.concat(stats.video.recv.codecs).join(', ');
			html += '<br>';
			html += 'Resolutions: ' + stats.resolutions.recv.width + 'x' + stats.resolutions.recv.height;
			html += '<br>';
			html += 'Data: ' + bytesToSize(stats.audio.bytesReceived + stats.video.bytesReceived);
			// html += '<br>';
			// html += 'Speed: ' + bytesToSize(stats.bandwidth.speed || 0);
			try{
			statsBarHTML.innerHTML = html;}
			catch{}
		}

		function bytesToSize(bytes) {
			var k = 1000;
			var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
			if (bytes === 0) {
				return '0 Bytes';
			}
			var i = parseInt(Math.floor(Math.log(bytes) / Math.log(k)), 10);
			return (bytes / Math.pow(k, i)).toPrecision(3) + ' ' + sizes[i];
		}

		window.addEventListener('offline', function() {
			infoBar.innerHTML = 'You seems offLine.';
		}, false);

		window.addEventListener('online', function() {
			infoBar.innerHTML = 'You seems onLine. Reloading the page..';
			//location.reload();
		}, false);
		</script>

		
    </sakai:view>
</f:view>
