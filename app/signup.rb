require 'hyalite'
require 'menilite'
require_relative 'controllers/application_controller'
require_relative 'views/signup_form'

Hyalite.render(Hyalite.create_element(SignupForm), $document[".content"])
