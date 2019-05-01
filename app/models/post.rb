class Post < Menilite::Model
  field :account, :reference, class: Account
  field :code, :string
  field :image, :string

  permit :account_privilege
end
