var match = "570px";

if(navigator.appName == "Microsoft Internet Explorer") 
{ 
	if(navigator.appVersion.match(/8./i) == '8.') { 
		match = "100%";
	}
} 

var str = '';

str += '<div id="DivID">';
str += '<OBJECT id="WebPDF" width="98%" height='+ match +' classid="clsid:39E08D82-C8AC-4934-BE07-F6E816FD47A1" ';
str	+= 'codebase="iWebPDF.cab#version=8.2.0.980" VIEWASTEXT>';
str += '</object>';
str += '</div>';
document.write(str);