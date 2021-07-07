Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    get "/movies" => "movies#index"
    get "/movies/random" => "movies#random"
    get "/movies/test" => "movies#test"
    get "/movies/title/:id" => "movies#title"
    get "/movies/:id" => "movies#show"
    get "/networks" => "networks#index"
    get "/networks/:id" => "networks#show"
    get "/genres" => "genres#index"
    get "/genres/:id" => "genres#show"
  end
end
