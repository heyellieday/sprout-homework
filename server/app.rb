require 'sinatra'
require 'sinatra/jsonp'
require 'rubygems'
require 'twitter'
require 'omniauth-twitter'
require 'json'

require 'sinatra/cross_origin'

configure do
  enable :sessions
  enable :cross_origin
end

helpers Sinatra::Jsonp

helpers do
  def admin?
    session[:admin]
  end
end

use OmniAuth::Builder do
  provider :twitter, 'nQJ58YwK219UusRIADKszeTgs', 'hCppbTmpZAREItaEh0oO0wBs4hDrcMGwp0ajn3gtbBpWe3KBjl'
end

twitter_client = nil

before do
   redirect to("/auth/twitter") unless admin? || params[:oauth_token] != nil
   twitter_client = Twitter::REST::Client.new do |config|
    config.consumer_key        = "nQJ58YwK219UusRIADKszeTgs"
    config.consumer_secret     = "hCppbTmpZAREItaEh0oO0wBs4hDrcMGwp0ajn3gtbBpWe3KBjl"
    config.access_token        = session[:token]
    config.access_token_secret = session[:secret]
  end
end



get '/login' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
  session[:token] = env['omniauth.auth']['credentials']['token']
  session[:secret] = env['omniauth.auth']['credentials']['secret']
  redirect to('http://localhost:9000')
end

get '/api/sprout-user' do
  jsonp  twitter_client.user.attrs
end

get '/api/lists' do
  jsonp twitter_client.lists.map(&:attrs)
end

get '/api/lists/:user_id' do
  jsonp  twitter_client.lists(params[:user_id]).map(&:attrs)
end

get '/api/followers/list' do
  jsonp  twitter_client.followers.map(&:attrs)
end

get'/api/lists/:list_id/members/owned/:list_owner' do
  jsonp  twitter_client.list_members(params[:list_owner].to_s ,params[:list_id].to_s.to_i).map(&:attrs)
end

get '/api/is/user/:user_id/in/list/:list_id' do
  jsonp  twitter_client.list_member?(params[:list_id].to_s.to_i, params[:user_id])

end

get '/api/twitter/add/user/:user_id/in/list/:list_id/' do
  jsonp  twitter_client.add_list_member(params[:list_id].to_s.to_i, params[:user_id]).attrs
end

get '/api/twitter/remove/user/:user_id/in/list/:list_id' do
  jsonp  twitter_client.remove_list_member(params[:list_id].to_s.to_i, params[:user_id]).attrs
end

post '/api/users/lookup' do
  jsonp  twitter_client.users(params[:users]).map(&:attrs)
end

get '/api/users/lookup' do
  jsonp  twitter_client.users('heyellieday, SproutHomework').map(&:attrs)
end

get '/api/users/lookup/:user_id' do
  jsonp  twitter_client.users(params[:user_id]).map(&:attrs)
end