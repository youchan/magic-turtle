require 'hyalite'
require 'menilite'
require_relative 'models/account'
require_relative 'models/post'
require_relative 'views/public_posts'

Hyalite.render(Hyalite.create_element(PublicPosts), $document[".public-list"])

