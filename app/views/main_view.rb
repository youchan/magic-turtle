class MainView
  include Hyalite::Component

  def post
    post = Post.new(image: @turtle.image_data, code: @turtle.code)
    post.save
  end

  def on_mounted(turtle, remote)
    @turtle = turtle
  end

  def render
    div do
      Kame::Remocon::Opal::AppView.el({on_mounted: -> (*args) { on_mounted(*args) }})
      Hyalite.create_element(:p, {class: "post-button"}, button({onClick: -> { post }, name: "post"}, "プログラムを投稿する"))
    end
  end
end
