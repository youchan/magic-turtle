require 'sinatra'
require 'opal'
require 'sinatra/activerecord'

if development?
  require 'sinatra/reloader'
end

require_relative "send_mail"

class Server < Sinatra::Base
  include OpalWebpackLoader::ViewHelper

  configure do
    enable :sessions
    set :protection, except: :json_csrf
  end

  get "/" do
    if @session = Session.auth(self.session[:session_id])
      haml :index
    else
      redirect to('/login')
    end
  end

  get "/kame" do
    haml :index
  end

  get "/login" do
    haml :login
  end

  get "/signup" do
    haml :signup
  end

  get "/set_password/:requeset_id" do
    haml :set_password
  end

  get "/list" do
    if @session = Session.auth(self.session[:session_id])
      haml :list
    else
      redirect to('/login')
    end
  end

  get "/public-list" do
    haml :public_list
  end

  get "/favicon.ico" do
  end
end

