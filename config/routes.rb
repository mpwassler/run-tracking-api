Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/api' do
    namespace :v1 do
      resources :runs do
        get 'matched', to: 'runs#matched'
      end
    end
  end
end
