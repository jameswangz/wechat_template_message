class WechatTemplateMessage::Result

  attr_reader :successful, :body

  def initialize(successful, body)
    @successful = successful
    @body = body
  end

end