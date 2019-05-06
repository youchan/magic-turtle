class Post < Menilite::Model
  field :account, :reference, class: Account
  field :code, :string
  field :image, :string
  field :name, :string
  field :open, :boolean
  field :created_at, :time
  field :updated_at, :time

  permit :account_privilege
end
