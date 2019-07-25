require 'hyalite'
require 'menilite'

require "kame_remocon"
require_relative "models/account"
require_relative "models/post"
require_relative "views/main_view"

Hyalite.render(Hyalite.create_element(MainView), $document[".turtle-graphics"])
