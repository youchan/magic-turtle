class MainView
  include Hyalite::Component

  state :modal, false

  def post
    post = Post.new(image: @turtle.image_data, code: @turtle.code)
    post.save
    $window.location = "/list"
  end

  def on_mounted(turtle, remote)
    @turtle = turtle
  end

  def render
    modal = state[:modal]

    div do
      div(ref: "modal", class: "modal#{modal ? "" : " hidden"}") do
        div(class: "modal-content") do
          i(class: "close fas fa-times", onClick: -> { set_state(modal: nil) })
          p(nil, "プログラムを投稿します。")
          p(nil, "OKを押してもまだ公開はされません。一覧から公開してください。")
          p(class: "ok-button") {button({onClick: -> { post }}, "OK")}
        end
      end

      Kame::Remocon::Opal::AppView.el({on_mounted: -> (*args) { on_mounted(*args) }})
      Hyalite.create_element(:p, {class: "post-button"}, button({onClick: -> { set_state(modal: true) }, name: "post"}, "プログラムを投稿する"))
    end
  end
end
