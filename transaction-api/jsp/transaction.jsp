<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.util.Iterator" %>

<%

    String startDate = "2022-03-01";
    String endDate = "2022-03-31";
    String startingAfter = "";
    String limit = "100";

  String secretKey = "test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy:";
  
  Encoder encoder = Base64.getEncoder(); 
  byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
  String authorizations = "Basic "+ new String(encodedBytes, 0, encodedBytes.length);

  String parameters = "?startDate=" + startDate + "&endDate=" + endDate + "&startingAfter=" + startingAfter +  "&limit=" + limit;
  
  URL url = new URL("https://api.tosspayments.com/v1/transactions"+ parameters);
  
  HttpURLConnection connection = (HttpURLConnection) url.openConnection();
  connection.setRequestProperty("Authorization", authorizations);
  
  connection.setRequestMethod("GET");

 
  int code = connection.getResponseCode();
  boolean isSuccess = code == 200 ? true : false;
  
  InputStream responseStream = isSuccess? connection.getInputStream(): connection.getErrorStream();
  
  Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
  JSONParser parser = new JSONParser();
  JSONObject jsonObject = null;
  JSONArray jsonArray = null;

  if (isSuccess) {
      jsonArray = (JSONArray) parser.parse(reader);
  }else{
      jsonObject = (JSONObject) parser.parse(reader);
  }
  
  responseStream.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <%
    if (isSuccess) { %>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <%= jsonArray.toJSONString() %></p>
        
        <p>
        <%
            

            Iterator i = jsonArray.iterator();

            while (i.hasNext()) {
                JSONObject transaction = (JSONObject) i.next();
                out.println("transactionKey : " + transaction.get("transactionKey") + "<br>");
                out.println("paymentKey : " + transaction.get("paymentKey") + "<br>");
                out.println("orderId : " + transaction.get("orderId") + "<br>");
                out.println("method : " + transaction.get("method") + "<br>");
                out.println("amount : " + transaction.get("amount") + "<br>");
                out.println("status : " + transaction.get("status") + "<br>");
                out.println("transactionAt : " + transaction.get("transactionAt") + "<br>");
                              
            }

            
        
        %>
        
        
    <%} else { %>
        <h1>조회 실패</h1>
        <p><%= jsonObject.get("message") %></p>
        <span>에러코드: <%= jsonObject.get("code") %></span>
        <%
    }
    %>

</section>
</body>
</html>

