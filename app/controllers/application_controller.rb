class ApplicationController < Menilite::Controller
  before_action(exclude: ["ApplicationController#login", "Account#signup"]) do
    raise "Authorization failure" unless Session.auth(session[:session_id])
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
      #settings.sockets.values.flatten.each {|ws| ws.send("login: #{account.name} is logged in.")}
      account.to_h
    else
      raise "Login failed"
    end
  end

  action :my_account do
    session = Session.fetch(filter: {session_id: self.session[:session_id]}, includes: :account).first
    session && session.account
  end
end
