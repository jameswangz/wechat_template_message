module WechatTemplateMessage

  @debug_mode = true
  @server = "https://api.weixin.qq.com"

  class<< self
    attr_accessor :logger, :debug_mode
    attr_reader :server
  end
  
  require 'wechat_template_message/template'
  require 'wechat_template_message/sender'

end
