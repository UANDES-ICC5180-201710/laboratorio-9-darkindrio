Rails.application.routes.draw do
  devise_for :people, path: 'auth'
  devise_scope :person do
    get 'auth', to: 'devise/registrations#new'
  end
  authenticate :person do
    resources :courses do
      resources :enrollments
      resources :assignments do
        resources :grades
      end
    end
    resources :people

    root to: 'courses#index'
  end

  post "/add_like" => "courses#addLike"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
