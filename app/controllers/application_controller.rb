unless RUBY_ENGINE == "opal"
  require "uri"
end

class ApplicationController < Menilite::Controller
  before_action(exclude: %w(ApplicationController#login ApplicationController#reset_password Account#signup Post#public_posts ResetPasswordRequest#set_password)) do
    login = Session.auth(session[:session_id])
    if login
      Menilite::PrivilegeService.current.privileges << AccountPrivilege.new(login.account)
    else
      raise Menilite::Unauthorized.new
    end
  end

  action :login do |username, password|
    account = Account.fetch(filter: {uid: username}).first

    if account && account.auth(password)
      login =  Session.fetch(filter:{account_id: account.id, login: true}).first
      if login
        if login.session_id == session[:session_id]
          login.update!(expire_at: Time.now + 5 * 60)
          return account.to_h
        else
          login.update!(login: false)
        end
      end

      login = Session.new(account_id: account.id, session_id: session[:session_id], login_at: Time.now, expire_at: Time.now + 5 * 60)
      login.save
      account.to_h
    else
      raise "Login failed"
    end
  end

  action :reset_password do |account_id|
    account = Account.fetch(filter: {id: account_id}).first
    raise "Can't get account for id: #{account_id}" unless account

    req = ResetPasswordRequest.create(account_id: account.id)

    url = URI.parse(request.url)
    url.path = "/set_password/#{req.id}"

    SendMail.send_to(account, url)
    nil
  end

  action :my_account do
    session = Session.fetch(filter: {session_id: self.session[:session_id]}, includes: :account).first
    session && session.account
  end
end
