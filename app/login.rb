require 'opal'
require "hyalite"
require "menilite"
require_relative "models/account"
require_relative "models/reset_password_request"
require_relative "models/session"
require_relative "controllers/application_controller.rb"
require_relative "views/login_form"

Hyalite.render(Hyalite.create_element(LoginForm), $document[".content"])

