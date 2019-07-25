require_relative '../models/account'

class SignupForm
  include Hyalite::Component

  state :modal, false
  state :error, nil

  def initialize
    @state = { error: false }
  end

  def on_click
    email = @refs['email'].value
    username = @refs['username'].value

    model = Account.new(name: username, uid: email)
    model.signup do |status, res|
      case status
      when :success
        ApplicationController.reset_password(model.id)
        set_state(modal: true)
      when :validation_error
        set_state(error: res.message
            .gsub(/name/, "名前")
            .gsub(/uid/, "メールアドレス")
            .gsub(/already exist/, "はすでに登録されています。")
            .gsub(/must not be empty/, "が入力されていません。"))
      when :failure
        set_state(error: "不明なエラーが発生しました。")
      end
    end
  end

  def notification
  end

  def render
    modal = state[:modal]
    error = state[:error]

    div(class: "signup-form") do
      h3(nil, "アカウントの登録")

      div({class: "notification is-danger #{error ? "" : "hidden"}"}, error)

      div(ref: "modal", class: "modal#{modal ? " show" : ""}") do
        div(class: "modal-content") do
          p(nil, "アカウントを登録しました。")
          p(nil, "登録したメールアドレスにパスワード登録のURLが送られます。パスワードを登録してからログインしてください。")
        end
      end

      p(class: "control has-icon") do
        input(class: "input", ref: "username", type: "text", placeholder: "Username")
        span(class: "icon is-small is-right") { i(class: "fas fa-user") }
      end
      p(class: "control has-icon") do
        input(class: "input", ref: "email", type: "text", placeholder: "Email address")
        span(class: "icon is-small is-right") { i(class: "far fa-envelope") }
      end
      p(class: "control") do
        button({class: "button is-primary", onClick: -> { on_click } }, "登録する")
      end
    end
  end
end

