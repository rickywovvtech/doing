Rails.application.routes.draw do
  root 'wowgrams#home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users do
    collection do
      resources :wowgrams do
        collection do
          get 'allpost'
          get 'home'
          get 'userpost'
          get 'comment'
          post 'submit_comment'
          # get 'follow'
          post 'follow'
        end
      end
    end
  end
  namespace 'api' do
    constraints format: :json do
      get 'test'=>'user_data#test'
      post 'user_data/create'=>'user_data#create'
      post 'user_data/createmongo' => 'user_data#createmongo'
    end
  end
end
