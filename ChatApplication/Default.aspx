<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ChatApplication.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Chat Application</title>
    <script src="Script/jquery-3.3.1.min.js"></script>
    <script src="Script/jquery.signalR-2.2.2.min.js"></script>
    <script src="signalr/hubs"></script>
   
   
    <style type="text/css">
        .auto-style1 {
            width: 200px, text-align:center;
            height: 163px;
        }
    </style>
   
   
</head>
<body>
   Enter Name: <input id="txtName" type="text" />
    <input id="btnSetName" type="button" value="Set Name" /><br /><br />
    Enter Message: <input id="txtMessage" type="text" style="width:400px"/><br /><br />
    <input id="btnSend" type="button" value="Send Message" />
    <div id="divName" style="display:block;margin: 5px auto;font-size:20px;" class="auto-style1"></div>
 <script>
    $(function () {
        let txtName = document.querySelector('#txtName');
        let txtMessage = document.querySelector('#txtMessage');
        let btnSetName = document.querySelector('#btnSetName');
        let btnSend = document.querySelector('#btnSend');
        let divName = document.querySelector('#divName');
        let divMessages = document.querySelector('#divMessages');

        let chat = $.connection.chatHub;
        btnSetName.onclick = function () {
            divName.innerText = 'Name: ${ txtName.value }';
        }
        chat.client.sendMessage = function (name, message) {
            $(divMessages).append($('<div style='border: 1px solid black; padding: 5px; margin: 5px; ' > <b>${name}:  </b> ${message}</div>'))
        }
    $.connection.hub.start().done(function() {
        btnSend.onclick = function () {
            chat.server.send('${txtName.value}', '${txtMessage.value}');
        };
    });
     var SpeechRecognition = SpeechRecognition() || webkitSpeechRecognition;
     var SpeechGrammarList = SpeechGrammarList || webkitSpeechGrammarList;
     var grammar = '#JSGF V1.0;'
     var recognition = new SpeechRecognition();
     var SpeechRecognitionList = new SpeechGrammarList();
     SpeechRecognitionList.addFromString(gramar, 1);
     recognition.lang = 'en-US';
     recognition.interimResults = true;
     recognition.onresult = function (event) {
         let command = event.result[0][0].transcript;
         let isfinal = event.result[0].isFinal;
         txtMessage.value = command;
         if (isFinal) {
             chat.server.send(txtName.value, command); 
         }
     }
     document.querySelector('#btnGiveCommand').onclick = function () {
         recognition.start();

     };
     recognition.onspeechend = function () {
         recognition.stop();
     };
     recognition.onerror = function () {
         txtMessage.value = 'Error occured in recognition:' + event.error;
     }
    });
</script>
</body>
</html>
