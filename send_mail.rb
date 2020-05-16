require 'sendgrid-ruby'

module SendMail
  include SendGrid


  def self.send_to(account, url)
    body = <<~CONTENT
      #{account.name}さま

      魔方陣投稿サイトにアカウント登録ありがとうございます。

      以下のURLからパスワードを設定してアカウントの登録が完了になります。

      #{url}
    CONTENT

=begin
    data = {}
    data["personalizations"] = [
      {
        "to" => [
          { "email" => account.uid },
          { "email" => "youchan01@gmail.com" },
        ],
        "subject" => "魔方陣投稿サイトに登録ありがとうございました！"
      }
    ]
    data["from"] = { "email" => "youchan01@gmail.com" }
    data["content"] = [{
        "type" => "text/plain",
        "value" => body
    }]
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])

    response = sg.client.mail._("send").post(request_body: data)
    puts response.status_code
    puts response.body
=end

    Pony.mail(
      from:         account.uid,
      to:           "youchan01@gmail.com",
      bcc:          "youchan01@gmail.com",
      subject:      "魔方陣投稿サイトに登録ありがとうございました！",
      body:         body
    )
  end
end

