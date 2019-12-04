Rails.application.routes.draw do
  
  get 'send/index'
  post 'send/index'

  get 'fetch/index'
  post 'fetch/index'

  get 'fetch/atcoder'
  post 'fetch/atcoder'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
