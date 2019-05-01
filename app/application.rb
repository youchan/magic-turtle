require 'hyalite'
require 'menilite'

require "kame_remocon"
require_relative "./views/main_view"
require_relative "./models/account"
require_relative "./models/post"

Hyalite.render(Hyalite.create_element(MainView), $document[".turtle-graphics"])
