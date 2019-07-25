class LoginForm
  include Hyalite::Component
  include Hyalite::Component::ShortHand

  state :error, nil

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
        if result.has_key?(:error)
          set_state(error: result[:error])
        else
          $window.location.href = "/"
        end
      when :failure
        set_state(error: "不明なエラーが発生しました。")
      end
    end
  end

  def render
    error = state[:error]

    div(class: 'login-form') do
      h3({}, "ログイン")

      div({class: "notification is-danger #{error ? "" : "hidden"}"}, error)

      p(class: 'control has-icon') do
        input(
          class: 'input',
          ref: 'email',
          type: 'text',
          placeholder: 'Email address',
          onKeyPress: -> evt { on_keypress(evt) }
        )
        span(class: "icon is-small is-right") { i(class: 'fa fa-envelope') }
      end
      p(class: 'control has-icon') do
        input(
          class: 'input',
          ref: 'password',
          type: 'password',
          placeholder: 'Password',
          onKeyPress: -> evt { on_keypress(evt) }
        )
        span(class: "icon is-small is-right") { i(class: 'fa fa-lock') }
      end
      p(class: 'has-text-right') { a({href: '/signup'}, '> アカウントの登録') }
      p(class: 'control') do
        button({class: 'button is-primary', onClick: -> evt { submit(evt) } }, "ログインする")
      end
    end
  end
end

