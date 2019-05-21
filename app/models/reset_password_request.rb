class ResetPasswordRequest < Menilite::Model
  field :account, :reference, class: Account
  field :status, :string, default: "requested"
  field :created_at, :time
  field :updated_at, :time

  permit :account_privilege

  action :set_password, class: true do |id, password|
    req = ResetPasswordRequest.find(id)
    raise "ResetPasswordRequest is not found for #{id}" unless req
    req.account.change_password(password)
    "ok"
  end
end
