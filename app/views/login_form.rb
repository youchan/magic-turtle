class LoginForm
  include Hyalite::Component
  include Hyalite::Component::ShortHand

  def initialize
    @state = { error: false }
  end

  def on_keypress(event)
    if event.code == 13
      submit
    end
  end

  def submit
    email = @refs[:email].value
    password = @refs[:password].value

    ApplicationController.login(email, password) do |status, result|
      case status
      when :success
        $window.location.href = "/"
      when :error
        puts "error"
      end
    end
  end

  def render
    div({class: 'login-form'},
      h3({}, "ログイン"),
      p({class: 'control has-icon'},
        input({class: 'input', ref: 'email', type: 'text', placeholder: 'Email address', onKeyPress: self.method(:on_keypress)}),
        span({class: "icon is-small is-right"}, i({class: 'fa fa-envelope'}))
      ),
      p({class: 'control has-icon'},
        input({class: 'input', ref: 'password', type: 'password', placeholder: 'Password', onKeyPress: self.method(:on_keypress)}),
        span({class: "icon is-small is-right"}, i({class: 'fa fa-lock'}))
      ),
      p({class: 'has-text-right'}, a({href: '/signup'}, '> アカウントの登録')),
      p({class: 'control'},
        button({class: 'button is-primary', onClick: self.method(:submit) }, "ログインする")
      )
    )
  end
end

