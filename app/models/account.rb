unless RUBY_ENGINE == 'opal'
  require 'bcrypt'
end

class Account < Menilite::Model
  field :name, :string, unique: true, presence: true
  field :uid, :string, unique: true, presence: true
  field :password, :string, client: false

  action :signup, save: true do
    self
    #ApplicationController.reset_password(self)
  end

  unless RUBY_ENGINE == 'opal'
    def auth(password)
      BCrypt::Password.new(self.password) == password
    end

    def change_password(password)
      self.password = BCrypt::Password.create(password)
      self.save
    end
  end
end

