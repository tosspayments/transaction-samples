<?php
error_reporting(E_ALL);
ini_set("display_errors", true);


$startDate = "2022-03-01";
$endDate = "2022-03-31";
$startingAfter = "";
$limit = 100;

$secretKey = 'test_ak_ZORzdMaqN3wQd5k6ygr5AkYXQGwy'; 

$url = 'https://api.tosspayments.com/v1/transactions';

$data = "?startDate=" . $startDate . "&endDate=" . $endDate . "&startingAfter=" . $startingAfter .  "&limit=" . $limit;

$credential = base64_encode($secretKey . ':');

$curlHandle = curl_init($url . $data);


curl_setopt_array($curlHandle, [

    CURLOPT_RETURNTRANSFER => TRUE,
    CURLOPT_HTTPHEADER => [
        'Authorization: Basic ' . $credential
    ]
]);





$response = curl_exec($curlHandle);

$httpCode = curl_getinfo($curlHandle, CURLINFO_HTTP_CODE);
echo $httpCode;
$isSuccess = $httpCode == 200;
$responseJson = json_decode($response, true);





?>

<!DOCTYPE html>
<html lang="ko">
<head>
    <title>조회 성공</title>
    <meta http-equiv="x-ua-compatible" content="ie=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
</head>
<body>
<section>
    <?php
    if ($isSuccess) { ?>
        <h1>조회 성공</h1>
        <p>결과 데이터 : <?php echo json_encode($responseJson, JSON_UNESCAPED_UNICODE); ?></p>
        
        <p>
        <?php
            
            foreach($responseJson as $transaction) {
                echo "transactionKey : " . $transaction["transactionKey"] . "<br>";
                echo "paymentKey : " . $transaction["paymentKey"] . "<br>";
                echo "orderId : " . $transaction["orderId"] . "<br>";
                echo "method : " . $transaction["method"] . "<br>";
                echo "amount : " . $transaction["amount"] . "<br>";
                echo "status : " . $transaction["status"] . "<br>";
                echo "transactionAt : " . $transaction["transactionAt"] . "<br>";
                
            }
        
           
        ?>
       
           
        </p>
        <?php
    } else { ?>
        <h1>조회 실패</h1>

        <p>에러메시지 : <?php echo $responseJson->message ?></p>
        <span>에러코드: <?php echo $responseJson->code ?></span>
        <?php
    }
    ?>

</section>
</body>
</html>
