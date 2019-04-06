require 'hyalite'
require 'menilite'

require "kame_remocon"

Hyalite.render(Hyalite.create_element(Kame::Remocon::Opal::AppView), $document['.content'])
