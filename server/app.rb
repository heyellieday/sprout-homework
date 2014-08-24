require 'sinatra'
require 'sinatra/jsonp'
require 'rubygems'
require 'twitter'

helpers Sinatra::Jsonp

twitter_client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "nQJ58YwK219UusRIADKszeTgs"
  config.consumer_secret     = "hCppbTmpZAREItaEh0oO0wBs4hDrcMGwp0ajn3gtbBpWe3KBjl"
  config.access_token        = "2753277314-PSCinXZb7z58GI3shVAKSpUbnmyTIBH5zsDDPlh"
  config.access_token_secret = "0PbHFNTIJZ6N5xUD2SNLGhmIUMj8TLav9quQCKoXBnpMx"
end

get '/api/lists' do
  jsonp twitter_client.lists.map(&:attrs)
end

get '/api/lists/:user_id' do
  jsonp twitter_client.lists(:user_id).map(&:attrs)
end

get '/api/followers/list' do
  jsonp twitter_client.followers.map(&:attrs)
end

get '/api/is/user/:user_id/in/list/:list_id' do
  jsonp twitter_client.list_members(:list_id).map(&:attrs)
end

delete '/api/twitter/user/:user_id/in/list/:list_id' do
  jsonp twitter_client.list_members(:list_id, :user_id).map(&:attrs)
end

put '/api/twitter/user/:user_id/in/list/:list_id' do
  jsonp twitter_client.add_list_member(:list_id, :user_id).map(&:attrs)
end

post '/api/users/lookup' do
  jsonp twitter_client.users(params[:users]).map(&:attrs)
end

get '/api/users/lookup' do
  jsonp twitter_client.users('heyellieday, SproutHomework').map(&:attrs)
end

get '/api/users/lookup/:user_id' do
  jsonp twitter_client.users(:user_id).map(&:attrs)
end