require_relative '../models/account'

class SignupForm
  include Hyalite::Component
  include Hyalite::Component::ShortHand

  def initialize
    @state = { error: false }
  end

  def on_click
    display_name = @refs['display-name'].value
    username = @refs['username'].value
    password = @refs['password'].value

    model = Account.new(name: display_name, uid: username)
    model.signup(password) do |status|
      case status
      when :success
        $window.location.href = '/'
      when :failure
        set_state(error: true)
      end
    end
  end

  def render
    notification = @state[:error] ? div({class: 'notification is-danger '}, "エラーです") : nil

    div({class: 'signup-form'},
      h3({}, "アカウントの登録"),
      notification,
      p({class: 'control has-icon'},
        input({class: 'input', ref: 'display-name', type: 'text', placeholder: 'Display name'}),
        span({class: "icon is-small is-right"}, i({class: 'far fa-smile'}))
      ),
      p({class: 'control has-icon'},
        input({class: 'input', ref: 'username', type: 'text', placeholder: 'Username'}),
        span({class: "icon is-small is-right"}, i({class: 'fas fa-user'}))
      ),
      p({class: 'control has-icon'},
        input({class: 'input', ref: 'password', type: 'password', placeholder: 'Password'}),
        span({class: "icon is-small is-right"}, i({class: 'fas fa-lock'}))
      ),
      p({class: 'control'},
        button({class: 'button is-primary', onClick: self.method(:on_click) }, "登録する")
      )
    )
  end
end

