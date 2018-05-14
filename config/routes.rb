Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'new', to: 'games#new', as: :new
  post 'score', to: 'games#score'
  # I'm not quite sure why this needs to be a post here.
  # In the previous problem, we used a gets even when submitting a form.
end
