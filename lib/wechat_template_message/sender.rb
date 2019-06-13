require 'net/http'
require 'json'
require 'wechat_template_message/result'

class WechatTemplateMessage::Sender

  def self.template_send access_token, openid, template_id, url, miniprogram_data, data
    uri = URI.parse("#{WechatTemplateMessage.server}/cgi-bin/message/template/send?access_token=#{access_token}")
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    res = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      req.body =  {
          "touser": openid,
          "template_id": template_id,
          "url": url,
          "miniprogram": miniprogram_data,
          "data": data
      }.to_json.to_s

      if WechatTemplateMessage.debug_mode && WechatTemplateMessage.logger
        WechatTemplateMessage.logger.debug "Sending wechat template message to uri #{uri} with body #{req.body}..."
      end

      http.request req
    end


    if WechatTemplateMessage.debug_mode && WechatTemplateMessage.logger
      WechatTemplateMessage.logger.debug "Get template message response status: #{res.code}, body: #{res.body}"
    end
    json = JSON.parse res.body
    successful = res.is_a?(Net::HTTPSuccess) && json['errcode'] == 0
    WechatTemplateMessage::Result.new(successful, json)
  end

end
