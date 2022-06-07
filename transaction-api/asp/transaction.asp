<%@ Language="VBScript" CODEPAGE="65001"%>


<!DOCTYPE html>

<!--#include file="json2.asp"--> 
<!--#include file="base64.asp"--> 

<%
	
call initCodecs

startDate = "2022-03-01"
endDate = "2022-03-31"
startingAfter = ""
limit = 100

secretkey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy:"

parameters = "?startDate=" & startDate & "&endDate=" & endDate & "&startingAfter=" & startingAfter &  "&limit=" & limit

url = "https://api.tosspayments.com/v1/transactions" + parameters


authorization = "Basic " & base64Encode(secretkey)

set req = Server.CreateObject("MSXML2.ServerXMLHTTP")
req.open "GET", url, false
req.setRequestHeader "Authorization", authorization
req.send ""

set myJSON = JSON.parse(req.responseText)

httpCode = req.status

%>

<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta charset="UTF-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <%
        if httpCode=200  then %>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <%= req.responseText %></p>
        <p>
            <% 
            
            For i=0 to myJSON.length -1 
            
                response.write "transactionKey : " & myJSON.get(i).transactionKey & "<br>"
                response.write "paymentKey : " & myJSON.get(i).paymentKey & "<br>"
                response.write "orderId : " & myJSON.get(i).orderId & "<br>"
                response.write "method : " & myJSON.get(i).method & "<br>"
                response.write "amount : " & myJSON.get(i).amount & "<br>"
                response.write "status : " & myJSON.get(i).status & "<br>"
                response.write "transactionAt : " & myJSON.get(i).transactionAt & "<br>"
               
               
            Next

            %>
           
           
        </p>
       <%
     else  %>
        <h1>조회 실패</h1>
        <p>에러메시지 :  <%= myJSON.message%></p>
        <span>에러코드:  <%= myJSON.code%></span>
       <%
    end if
    %>

</section>
</body>
</html>
