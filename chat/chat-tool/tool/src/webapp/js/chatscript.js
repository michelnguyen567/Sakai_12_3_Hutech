/**********************************************************************************
 * $URL: $
 * $Id: $
 ***********************************************************************************
 *
 * Copyright (c) 2017 The Sakai Foundation
 *
 * Licensed under the Educational Community License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.opensource.org/licenses/ECL-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **********************************************************************************/

var socket = null;
function initialize() {
    
    socket = new WebSocket("ws://35.196.216.62/sakai-chat-tool/story/notifications");
    socket.onmessage = onSocketMessage;
   
  	
}

function khoitao(){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: "",
            nguoiCoQuyenLive:"",
            nguoiDangLive:"",
            act:"khoitao"
        };
        socket.send(JSON.stringify(stickerToSend));
}
function choQuyenLive(id){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: "",
            nguoiCoQuyenLive:id,
            nguoiDangLive:"",
            act:"choQuyenLive"
        };
        socket.send(JSON.stringify(stickerToSend));
}

function changeType(type2){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: type2,
            nguoiCoQuyenLive:"",
            nguoiDangLive:"",
            act:"changeType"
        };
        socket.send(JSON.stringify(stickerToSend));
}
function userTatLive(){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: "",
            nguoiCoQuyenLive:"",
            nguoiDangLive:"",
            act:"userTatLive"
        };
        socket.send(JSON.stringify(stickerToSend));
}
function stop(){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: "",
            nguoiCoQuyenLive:"",
            nguoiDangLive:"",
            act:"stop"
        };
        socket.send(JSON.stringify(stickerToSend));
}

function dangLive(id){
	var roomid =document.getElementById("topForm:chatidhidden").value;
	var stickerToSend = {
            action: "",
            roomid: roomid,
            type: "",
            nguoiCoQuyenLive:"",
            nguoiDangLive:id,
            act:"dangLive"
        };
        socket.send(JSON.stringify(stickerToSend));
    
}

function onSocketMessage(event) {
	if (event.data) {
		var roomid =document.getElementById("topForm:chatidhidden").value;
	 //lay du lieu nhan duoc
      var receivedSticker = JSON.parse(event.data);
      //alert(receivedSticker.type+ "  "+ receivedSticker.nguoiCoQuyenLive+" "+receivedSticker.nguoiDangLive);
      //alert("nguoi dang live " +  receivedSticker.nguoiDangLive);
      if (receivedSticker.roomid==roomid)
    	  {
	    	  if (receivedSticker.act=="khoitao"){
	        	  roomCheck.type=receivedSticker.type;
	        	  roomCheck.nguoiCoQuyenLive=receivedSticker.nguoiCoQuyenLive;
	        	  //if (roomCheck.nguoiCoQuyenLive==portal.user.id)// {document.getElementById("button").style.display="initial";}
	        	  roomCheck.nguoiDangLive=receivedSticker.nguoiDangLive;
				  //alert(receivedSticker.nguoiDangLive);
	        	  chatscript.doUpdateChatData();
	          }else
        	  if (receivedSticker.act=="choQuyenLive"){
	    		  roomCheck.nguoiCoQuyenLive=receivedSticker.nguoiCoQuyenLive;
				  roomCheck.nguoiDangLive=receivedSticker.nguoiCoQuyenLive;
	    		  if (receivedSticker.nguoiCoQuyenLive==portal.user.id){
	    			  document.getElementById("button").click();
	    		  }
        	  }else 
        	  if (receivedSticker.act=="changeType") {
        	  	  roomCheck.type=receivedSticker.type;
        	  	  if (roomCheck.type=="vanDap"){
        	  	  	checkPresence2();	
        	  	  }
        	  	  
        	  	  //alert( roomCheck.type);
        	  }else 
        	  if (receivedSticker.act=="stop") {
        	  	  /*if (roomCheck.nguoiCoQuyenLive==portal.user.id){
        	  	  	document.getElementById("button").style.display="none";
        	  	  }*/
        	  	  //alert("<abc></abc>");
        	  	  if (roomCheck.nguoiDangLive==portal.user.id){
        	  	  	//alert("asd");
        	  	  	document.getElementById("cancells").click();
        	  	  }
        	  	  
        	  	  roomCheck.nguoiDangLive=receivedSticker.nguoiDangLive;
        	  	  roomCheck.nguoiCoQuyenLive=receivedSticker.nguoiCoQuyenLive;
        	  }else
        	  if (receivedSticker.act=="userTatLive") {chatscript.doUpdateChatData();}

    	  }
      

  }
	
}
document.addEventListener("DOMContentLoaded",function(){
	setTimeout(function(){
		khoitao();
		
	},900);
})


//tao roomid cho lan dau su dung


window.onload=initialize();

var chatscript = {

	url_submit : "/direct/chat-message/",
	keycode_enter : 13,
	pollInterval : 5000,
	currentChatChannelId : null,
	timeoutVar : null,
	
	init : function(){
		
		var me = this;
		
		me.updateShownText();
		me.scrollChat();
		me.updateChatData();
		
		
		var textarea = $("#topForm\\:controlPanel\\:message");
		var submitButton = $("#topForm\\:controlPanel\\:submit");
		var resetButton = $("#topForm\\:controlPanel\\:reset");
		submitButton.bind('click', function() {
			var messageBody = textarea.val();
			submitButton.prop("disabled", true);
			var params = {
				"chatChannelId": me.currentChatChannelId,
				"body": messageBody
			}
			// If message body or currentChatChannelId are empty
			if (!me.currentChatChannelId || !messageBody || !messageBody.replace(/\n/g, "").replace(/ /g, "").length) {
				textarea.val("").focus();
				submitButton.prop("disabled", false);
				return false;
			}
			me.sendMessage(params, textarea, submitButton);
		});
		textarea.keydown(function(e) {
			var keycode = e.keyCode;
			if (keycode == me.keycode_enter && !submitButton.prop("disabled")) {
				submitButton.trigger("click");
				return false;
			}
		});
		resetButton.click(function() {
			textarea.val("").focus();
		});


		$(".chatList").on('click', '.chatRemove', function() {
			var messageItem = $(this).parent().parent();
			var messageId = messageItem.attr("data-message-id");
			var ownerDisplayName = messageItem.find(".chatName").text();
			var date = messageItem.find(".chatDate").text();
			var messageBody = messageItem.find(".chatText").html();
			me.showRemoveModal(messageId, ownerDisplayName, date, messageBody);
		});
		$("#deleteButton").click(function() { 
			var messageId = $(this).attr("data-message-id");
			me.deleteMessage(messageId);
		});

		$("#chatListWrapper").scroll(function() {
			if (($(".chatListWrapper")[0].scrollHeight - $(".chatListWrapper").scrollTop()) <= $(".chatListWrapper").height()) {
				setTimeout(function() {
					$(".divisorNewMessages[id!=divisorNewMessages]").fadeOut(300, function() {
						$(".divisorNewMessages[id!=divisorNewMessages]").remove();
					});
				}, 3000);
				$(".scrollBottom").fadeOut(300, function() {
					unreadedMessages = 0;
					me.updateUnreadedMessages();
				});
			}
		});
		$(".scrollBottom").click(function() {
			me.scrollChat();
			setTimeout(function() {
				$(".divisorNewMessages[id!=divisorNewMessages]").fadeOut(300, function() {
					$(".divisorNewMessages[id!=divisorNewMessages]").remove();
				});
			}, 3000);
			$(".scrollBottom").fadeOut(300, function() {
				unreadedMessages = 0;
				me.updateUnreadedMessages();
			});
		});
	},
	sendMessage : function(params, textarea, submitButton) {
		var me = this;
		var errorSubmit = $("#errorSubmit");
		$.ajax({
			url: me.url_submit + 'new',
			data: params,
			type: "POST",
			beforeSend: function() {
				errorSubmit.slideUp('fast');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				errorSubmit.slideDown('fast');
				textarea.focus();
				submitButton.prop("disabled", false);
			},
			success: function(data) {
				me.scrollChat();
				me.updateChatData();
				textarea.val("").focus();
				submitButton.prop("disabled", false);
			}
		});
	},
	deleteMessage : function(messageId) {
		var me = this;
		var removeModal = $("#removemodal");
		removeModal.modal("hide");
		$.ajax({
			url: me.url_submit + messageId,
			type: "DELETE",
			success: function(data) {
				removeModal.modal("hide");
				me.updateChatData();
			}
		});
	},
	updateChatData : function () {
		var me = this;
		this.doUpdateChatData();
		if(this.timeoutVar != null) {
			clearTimeout(this.timeoutVar);
		}
		this.timeoutVar = setTimeout(function() {
			me.updateChatData();
		}, this.pollInterval);
	},
	doUpdateChatData : function() {
		var me = this;
		var url = me.url_submit + portal.user.id + "/chatData.json";
		var params = {
			"siteId": portal.siteId,
			"channelId": this.currentChatChannelId
		};
		$.ajax({
			url: url,
			data: params,
			type: "GET",
			cache: false,
			success: function(data) {
				me.addMessages(data.data.messages);
				me.updatePresentUsers(data.data.presentUsers);
				me.deleteMessages(data.data.deletedMessages);
			}
		});
	},
	doUpdateName : function() {
		var me = this;
		var url = me.url_submit + portal.user.id + "/chatData.json";
		var params = {
			"siteId": portal.siteId,
			"channelId": this.currentChatChannelId
		};
		$.ajax({
			url: url,
			data: params,
			type: "GET",
			cache: false,
			success: function(data) {
				me.updateName(data.data.presentUsers);
			}
		});
	},
	updateName: function(users){
		//alert("dang live "+roomCheck.nguoiDangLive);
		for (var i=0; i<users.length; i++) {
			if (users[i].id==roomCheck.nguoiDangLive){
				var infoBar = document.getElementById('info-bar');
				infoBar.innerHTML=users[i].name + " is Streaming";
			}	
			

		}
	},
	addMessages : function (messages) {
		var me = this;
		var scrolledToBottom = true;
		if (($(".chatListWrapper")[0].scrollHeight - $(".chatListWrapper").scrollTop()) > $(".chatListWrapper").height()) {
			scrolledToBottom = false;
		}

		if (messages.length > 0 && !scrolledToBottom) {
			if ($(".divisorNewMessages").length < 2) {
				var divisorNewMessages = $("#divisorNewMessages").clone();
				divisorNewMessages.removeAttr("id");
				divisorNewMessages.removeClass("hide");
				$("#topForm\\:chatList").append(divisorNewMessages);
			}
		}

		for (var i=0; i<messages.length; i++) {
			var lastMessageOwnerId = $("#topForm\\:chatList li[class!='divisorNewMessages']").last().attr("data-owner-id");
			var messageId = messages[i].id;
			var ownerId = messages[i].owner;
			var ownerDisplayName = messages[i].ownerDisplayName;

			var messageDate = messages[i].messageDate;
			var localizedDate = messages[i].messageDateString.localizedDate;
			var localizedTime = messages[i].messageDateString.localizedTime;
			var dateID = messages[i].messageDateString.dateID;
			var dateStr = this.renderDate(localizedDate, localizedTime, dateID);

			var messageBody = messages[i].body;
			var removeable = messages[i].removeable;
			var exists = $("#topForm\\:chatList li[data-message-id=" + messageId + "]").length;
			if (!exists) {
				var messageItem = $("#chatListItem").clone();
				messageItem.removeClass("hide");
				messageItem.removeAttr("id");
				messageItem.attr("data-message-id", messageId);
				messageItem.attr("data-owner-id", ownerId);
				messageItem.find(".chatUserAvatar").css("background-image", "url(/direct/profile/" + ownerId + "/image)");
				messageItem.find(".chatMessage").attr("data-message-id", messageId);
				messageItem.find(".chatName").attr("id", ownerId);
				messageItem.find(".chatName").text(ownerDisplayName);
				messageItem.find(".chatDate").text(dateStr);
				messageItem.find(".chatText").html(messageBody);
				if (removeable) {
					messageItem.find(".chatRemove").removeClass("hide");
				}
				if (lastMessageOwnerId == ownerId) {
					messageItem.addClass("nestedMessage");
					messageItem.find(".chatMessageDate").text(dateStr);
				}
				$("#topForm\\:chatList").append(messageItem);
				someMessageAdded = true;
				chat2_totalMessages++;
				chat2_shownMessages++;
				this.updateShownText();
				if (scrolledToBottom) {
					this.scrollChat();
					setTimeout(function() {
						$(".divisorNewMessages[id!=divisorNewMessages]").fadeOut(300, function() {
							$(".divisorNewMessages[id!=divisorNewMessages]").remove();
						});
					}, 3000);
					$(".scrollBottom").fadeOut(300, function() {
						unreadedMessages = 0;
						me.updateUnreadedMessages();
					});
				} else {
					unreadedMessages++;
					me.updateUnreadedMessages();
					$(".divisorNewMessages[id!=divisorNewMessages]").find(".newMessages").text(unreadedMessages);
					$(".scrollBottom").fadeIn(300).removeClass("hide");
				}
			}
		}
	},
	deleteMessages : function (messages) {
		for (var i=0; i<messages.length; i++) {
			var messageId = messages[i].id;
			if(messageId != '*') {
				var existsMessage = $("#topForm\\:chatList li[data-message-id=" + messageId + "]").length;
				if (existsMessage > 0) {
					var message = $("#topForm\\:chatList li[data-message-id=" + messageId + "]");
					if (!message.hasClass("nestedMessage") && message.next().hasClass("nestedMessage")) {
						message.next().removeClass("nestedMessage");
					}
					message.remove();
					chat2_totalMessages--;
					chat2_shownMessages--;
					this.updateShownText();
				}
			} else {
				$("#topForm\\:chatList li:not(#chatListItem, #divisorNewMessages)").remove();
				chat2_totalMessages = 0;
				chat2_shownMessages = 0;
				this.updateShownText();
			}
		}
	},
	updatePresentUsers : function (users) {
		$("#presence").empty();
		$("#topForm\\:chatList li .chatUserOnline").removeClass("is-online");
		var checkIfStilOnRoom=false;
		//alert(this.idOnLiveStream);
		for (var i=0; i<users.length; i++) {

			var ownerId = users[i].id;
			if (ownerId!=portal.user.id)
			{var userId = ownerId;
						if(ownerId.indexOf(':') > -1) {
							userId = ownerId.substring(ownerId.indexOf(":") + 1)
						}
						var userElement = document.createElement("li");
						userElement.setAttribute("data-user-id", ownerId);
						
						userElement.setAttribute("style", "border-bottom:1px solid #999; text-align:right;"); 
						userElement.innerHTML = users[i].name;
						//alert(users[i].name);
						

						//if (this.idOnLiveStream==ownerId) checkIfStilOnRoom=true;
							
						
						try{
							//alert(roomCheck.type);
							if (roomCheck.type=="vanDap" && document.getElementById("topForm:start")!=null) {
							var btn1= document.createElement("button");
							btn1.setAttribute("data-user-id", ownerId);
							//btn1.setAttribute("data-name",users[i].name);
							btn1.id="send"+ownerId;
							var btn2=document.createElement("button");
							btn2.id="stop"+ownerId;
							btn2.setAttribute("data-user-id", ownerId);
							//an button stop
							btn1.setAttribute("style", "right:0;margin-left:20px!important;margin-right:0px!important;"); 
							btn2.setAttribute("style", "background-color:red;right:0;margin-left:20px!important;margin-right:0px!important;");
							if (roomCheck.nguoiCoQuyenLive == ownerId || roomCheck.nguoiDangLive == ownerId) {
								btn1.style.display="none";
							}
							else {btn2.style.display="none";}
			
							btn1.innerHTML="send";
							btn2.innerHTML="stop";
							
							//gan event btnsend
							btn1.addEventListener("click",function(e){
								e.preventDefault();
								var x=this.getAttribute("data-user-id");
								//var name = this.getAttribute("data-name");
								//alert(name);
								choQuyenLive(x);
								chatscript.doUpdateChatData();
							})
							
							//gan event btnstop
							btn2.addEventListener("click",function(e){
								e.preventDefault();
								stop();
								chatscript.doUpdateChatData();
							})
							
							//chen vao li
							userElement.append(btn1);
							userElement.append(btn2);
							}
						}
						catch{}
						$("#presence").append(userElement);
						$("#topForm\\:chatList li[data-owner-id=" + userId + "] .chatUserOnline").addClass("is-online");}

		}
		

		
		
	},
	showRemoveModal : function(messageId, ownerDisplayName, date, messageBody) {
		var removeModal = $("#removemodal");
		removeModal.find("#owner").text(ownerDisplayName);
		removeModal.find("#date").text(date);
		removeModal.find("#message").html(messageBody);
		removeModal.find("#deleteButton").attr("data-message-id", messageId);
		removeModal.modal("show");
	},
	scrollChat : function () {
		var scrollableChat = $("#chatListWrapper");
		scrollableChat.scrollTop(scrollableChat.prop("scrollHeight"));
	},
	updateShownText : function () {
		var countText = chat2_messageCountTemplate + '';
		countText = countText.replace('*SHOWN*', chat2_shownMessages);
		countText = countText.replace('*TOTAL*', chat2_totalMessages);
		$("#chat2_messages_shown_total").html(countText);
	},
	updateUnreadedMessages : function () {
		var text = chat2_messagesUnreadedTemplate.replace("*UNREADED*", unreadedMessages);
		$(".scrollBottom").attr("title", text);
		$(".scrollBottom .newMessages").text(unreadedMessages);
	},
	renderDate : function(localizedDate, localizedTime, dateID) {
		var msgTime = "";
		if(window.display_date && window.display_time) {
			msgTime = " " + localizedDate + " " + localizedTime + " " ;
		} else if (window.display_date) {
			msgTime = " " + localizedDate + " " ;
		} else if(window.display_time) {
			msgTime = " " + localizedTime + " " ;
		} else if(window.display_id) {
			msgTime = " (" + dateID + ") " ;
		}
		return msgTime;
	}
};
