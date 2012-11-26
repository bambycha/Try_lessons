function getXMLHTTPRequest() {
   var req =  false;
   try {
      /* для Firefox */
      req = new XMLHttpRequest(); 
   } catch (err) {
      try {
         /* для некоторых версий IE */
         req = new ActiveXObject("MsXML2.XMLHTTP");
      } catch (err) {
         try {
            /* для других версий IE */
            req = new ActiveXObject("Microsoft.XMLHTTP");
         } catch (err) {
            req = false;
         }
      }
   }
   return req;
}

function send_todo(id) {
   var thePage = '/save_todo';
   var text = 'todo_body=' + document.getElementById("todo_body").value + ';id=' + id;
   myRand = parseInt(Math.random()*999999999999999);
   var theURL = thePage /*+"?rand="+myRand*/;
   myReq.open("POST", theURL, true);
   myReq.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
   myReq.setRequestHeader("Content-length", text.length);
   myReq.setRequestHeader("Connection", "close");
   myReq.onreadystatechange = theHTTPResponse;
   myReq.send(text);
}

function theHTTPResponse() {
   if (myReq.readyState == 4) {
      if(myReq.status == 200) {
         var string = myReq.responseText;
         //document.getElementById("todo_body").value = string;
         alert(string);
      }
   } 
}
