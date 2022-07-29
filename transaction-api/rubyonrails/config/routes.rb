Rails.application.routes.draw do
    # add code
  
    get 'apis/transactions' => 'apis#transactions'
    
    # end code
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
