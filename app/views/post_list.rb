require "time"

class PostList
  include Hyalite::Component

  state :posts, []
  state :current_post, nil
  state :modal, nil

  def component_did_mount
    Post.fetch! do |posts|
      set_state(posts: posts)
    end
  end

  def delete_post(post)
    post.delete! do
      state[:posts].delete(post)
      set_state(posts: state[:posts], modal: nil)
    end
  end

  def publish_post(post)
    name = refs["input-name"].value.chomp
    return if name.empty?

    post.name = name
    post.open = true
    post.save do
      set_state(modal: nil)
    end
  end

  def private_post(post)
    post.open = false
    post.save do
      set_state(modal: nil)
    end
  end

  def desc(label, value, params=nil)
    p(class: "desc") do
      span({class: "label"}, label)
      span(params, value)
    end
  end

  def render
    posts = @state[:posts]
    modal = @state[:modal]
    current_post = @state[:current_post]

    div do
      div(ref: "modal", class: "modal#{modal ? "" : " hidden"}") do
        div(class: "modal-content") do
          i(class: "close fas fa-times", onClick: -> { set_state(modal: nil) })
          case modal
          when :delete
            p(nil, "削除します。")
            p(class: "ok-button") {button({onClick: -> { delete_post(current_post) }}, "OK")}
          when :publish
            p(nil, "名前をつけて公開します。")
            label({for: "input-name"}, "名前")
            input(name: "input-name", ref: "input-name", type: :text, value: current_post.name)
            p(class: "ok-button") {button({onClick: -> { publish_post(current_post) }}, "OK")}
          when :private
            p(nil, "非公開にします。")
            p(class: "ok-button") {button({onClick: -> { private_post(current_post) }}, "OK")}
          end
        end
      end

      ul do
        posts.each do |post|
          li do
            div(class: "post-info") do
              img(class: "thumbnail", src: "data:image/png;base64,#{post.image}", style: {"background-color": :black}, width: 100, height: 100)
              div(class: "info-box") do
                p(class: "delete-button") do
                  button(onClick: -> { set_state(modal: :delete, current_post: post) }) { i(class:"far fa-trash-alt") }
                end
                desc("名前", *(post.name || ["未設定", {style: {color: "#aaaaaa"}}]))
                desc("状態", post.open ? "公開" : "非公開")
                desc("作成日時", Time.parse(post.created_at).strftime("%Y/%m/%d %H:%M:%S"))
                if post.open
                  p(class: "private-button") { button({onClick: -> { set_state(modal: :private, current_post: post) }}, "非公開にする") }
                else
                  p(class: "publish-button") { button({onClick: -> { set_state(modal: :publish, current_post: post) }}, "公開する") }
                end
              end
            end
          end
        end
      end
    end
  end
end
