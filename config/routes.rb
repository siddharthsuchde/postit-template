PostitTemplate::Application.routes.draw do
  resources :posts, except: [:destroy]
  root to: 'posts#index'
  
end
