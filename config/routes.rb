Rails.application.routes.draw do
  namespace :api do
    post 'applicants', to: 'applicants#create'
  end
end
