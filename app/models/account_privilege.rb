class AccountPrivilege < Menilite::Privilege
  def key
    :account_privilege
  end

  def initialize(account)
    @account = account
  end

  def filter
    { account_id: @account.id }
  end

  def fields
    { account_id: @account.id }
  end
end

