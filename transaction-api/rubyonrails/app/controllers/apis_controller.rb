class PaymentController < ApplicationController

  def transactions
    startDate = "2022-07-01"
	  endDate = "2022-07-29"
	  startingAfter = ""
	  limit = 100
         
    search = "?startDate=#{startDate}&endDate=#{endDate}&startingAfter=#{startingAfter}&limit=#{limit}"
      
    options = {
      headers: {
        Authorization: "Basic " + Base64.strict_encode64("test_sk_D4yKeq5bgrpKRd0JYbLVGX0lzW6Y:"),
        "Content-Type": "application/json"
      }
    }
      
	  begin
      response = HTTParty.get("https://api.tosspayments.com/v1/transactions" + search, options).parsed_response
      @Response = response
    end
      
  end
  
end