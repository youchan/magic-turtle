require_relative '../models/account'

class SetPasswordForm
  include Hyalite::Component

  state :modal, false
  state :error, nil

  def initialize
    @state = { error: false }
  end

  def on_click
    password = @refs["password"].value
    re_enter = @refs["re-enter"].value

    if password == re_enter
      puts $window.location.href
      id = $window.location.href.split("/").last
      ResetPasswordRequest.set_password(id, password) do |state, res|
        case state
        when :success
          set_state(modal: true)
        when :failure
          set_state(error: "不明なエラーが発生しました。")
        end
      end
    else
      set_state(error: "パスワードが一致していません。")
    end
  end

  def render
    modal = state[:modal]
    error = state[:error]

    div(class: "set-password-form") do
      h3(nil, "パスワード設定")

      div({class: "notification is-danger #{error ? "" : "hidden"}"}, error)

      div(ref: "modal", class: "modal#{modal ? " show" : ""}") do
        div(class: "modal-content") do
          p(nil, "パスワードを設定しました。")
          button({class: "button is-primary", onClick: -> { $window.location = "/login" }}, "ログインページへ")
        end
      end

      p(class: "control has-icon") do
        input(class: "input", ref: "password", type: "password", placeholder: "Password")
        span(class: "icon is-small is-right") { i(class: "fas fa-key") }
      end
      p(class: "control has-icon") do
        input(class: "input", ref: "re-enter", type: "password", placeholder: "Re-enter password")
        span(class: "icon is-small is-right") { i(class: "fas fa-redo-alt") }
      end
      p(class: "control") do
        button({class: "button is-primary", onClick: -> { on_click } }, "パスワードを設定する")
      end
    end
  end
end
