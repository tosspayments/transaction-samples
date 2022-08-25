# payment-window/go

Go 를 이용한 결제창 샘플입니다.



## 테스트 방법
<br>

### 설치
Go 공식 웹사이트인 https://go.dev/dl/ 에서 해당 OS 버전의 Go 를 다운로드하여 설치 합니다.

* 설치 및 환경 구성 참고 링크 주소
> http://golang.site/go/article/2-Go-%EC%84%A4%EC%B9%98%EC%99%80-Go-%ED%8E%B8%EC%A7%91%EA%B8%B0-%EC%86%8C%EA%B0%9C
<br>

### 실행
샘플 소스의 기본 포트는 9090 으로 되어 있습니다.
다음과 같이 go 명령어를 통해 서버를 구동 합니다.

```> go run transaction.go ```

브라우저에서 http://localhost:9090 를 호출하면 거래조회 API를 통해 거래내역 리스트를 조회한 결과가 응답값으로 리턴 됩니다.
