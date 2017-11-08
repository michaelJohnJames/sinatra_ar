require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './models'
require 'pry'

# Database configuration
set :database, "sqlite3:development.sqlite3"

# Define routes below
get '/' do
  erb :index
end

get '/users' do
   @users = User.all
   erb :'users/index'
end


#user new route
get '/users/new' do
  erb :'users/new'
end

#user create route
post '/users' do
  user = User.create(
    name: params[:name],
    fav_food: params[:fav_food]
  )
  redirect "/users/#{user.id}"
end


#user update route #don't need instance variable because we are not rendering just redirecting
patch '/users/:id' do
  user = User.find_by_id(params[:id])
  user.update(
    name: params[:name],
    fav_food: params[:fav_food]
  )

  redirect "users/#{user.id}"
end

#user show route
get '/users/:id' do
   @user = User.find_by_id(params[:id])
   erb :'users/show'
end



#user destroy route
delete '/users/:id' do
  user = User.find_by_id(params[:id])
  user.destroy
  redirect '/users'
end


#user edit route
get '/users/:id/edit' do
  @user = User.find_by_id(params[:id])
  erb :'users/edit'
end





#get '/users/:slug' do
#   @user = User.find_by_slug(params[:slug])
#   erb :'users/show'
#end

# Providing model information to the view
# requires an instance variable (prefixing with the '@' symbol)

# Example 'User' index route
