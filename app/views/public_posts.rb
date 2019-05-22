require "time"

class PublicPosts
  include Hyalite::Component

  state :posts, []
  state :current_post, nil
  state :modal, nil

  def component_did_mount
    Post.public_posts do |_, res|
      posts = res.reverse.map{|data| Menilite::Deserializer.deserialize(Post, data, :account)}
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
      ul do
        posts.each do |post|
          li do
            div(class: "post-info") do
              img(class: "thumbnail", src: "data:image/png;base64,#{post.image}", style: {"background-color": :black})
              div(class: "info-box") do
                desc("名前", post.name)
                desc("状態", post.account.name)
                desc("作成日時", Time.parse(post.created_at).strftime("%Y/%m/%d %H:%M:%S"))
              end
            end
          end
        end
      end
    end
  end
end
