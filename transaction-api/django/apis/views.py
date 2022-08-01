from django.shortcuts import render

import requests, json, base64, time

# Create your views here.
def index(request):
  return render(
    request,
    'apis/index.html',
  )

def transactions(request):
  startDate = "2022-07-01"
  endDate = "2022-07-29"
  startingAfter = ""
  limit = 100  
  search = "?startDate=%s&endDate=%s&startingAfter=%s&limit=%s" % (startDate, endDate, startingAfter, limit)

  url = "https://api.tosspayments.com/v1/transactions"
  secertkey = "test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y"
  userpass = secertkey + ':'
  encoded_u = base64.b64encode(userpass.encode()).decode()
  
  headers = {
    "Authorization" : "Basic %s" % encoded_u,
    "Content-Type": "application/json"
  }
  
  res = requests.get(url+search, headers=headers)
  resjson = res.json()
  pretty = json.dumps(resjson, indent=4, ensure_ascii=False)

  return render(
    request,
    'apis/transactions.html',
    {
      "res" : pretty,
    }
  )