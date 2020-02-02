require 'bundler/setup'
Bundler.require(:default)

require 'menilite'
require 'sinatra/activerecord'

require_relative 'owl_init'

require_relative 'server'

Dir[File.expand_path('../app/models/', __FILE__) + '/**/*.rb'].each {|file| require(file) }
Dir[File.expand_path('../app/controllers/', __FILE__) + '/**/*.rb'].each {|file| require(file) }

app = Rack::Builder.app do
  server = Server.new(host: 'localhost')

  map '/' do
    run server
  end

  map '/api' do
    router = Menilite::Router.new
    run router.routes(server.settings)
  end
end

run DRb::WebSocket::RackApp.new(app)
