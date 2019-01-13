Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      devise_for(
        :users,
        path: '',
        path_names: { sign_in: 'login', sign_out: 'logout', registration: 'signup' },
        controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
      )

      resource :parking_places, only: %i[create index]
    end
  end
end
