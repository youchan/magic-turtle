require 'hyalite'
require 'menilite'
require_relative 'models/account'
require_relative 'models/post'
require_relative 'views/post_list'

Hyalite.render(Hyalite.create_element(PostList), $document[".post-list"])

