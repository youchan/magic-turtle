require "sinatra"
require "pony"
require "goatmail"
require "opal"
require "sinatra/activerecord"

if development?
  require "sinatra/reloader"
end

require_relative "send_mail"

class Server < Sinatra::Base
  include OpalWebpackLoader::ViewHelper

  configure do
    enable :sessions
    set :protection, except: :json_csrf
    set :root, File.dirname(__FILE__)

    if ENV['RACK_ENV'] == 'protection'
      Pony.options = {
        :via => :smtp,
        :via_options => {
          :address => 'smtp.sendgrid.net',
          :port => '587',
          :domain => ENV['DOMAIN_NAME'],
          :user_name => ENV['SENDGRID_USERNAME'],
          :password => ENV['SENDGRID_PASSWORD'],
          :authentication => :plain,
          :enable_starttls_auto => true
        }
      }
    else
      if ENV['RACK_ENV'] == 'development'
        Goatmail.location = File.join("#{root}/tmp/goatmail")
        Pony.options = { via: Goatmail::DeliveryMethod }
      end
    end
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

