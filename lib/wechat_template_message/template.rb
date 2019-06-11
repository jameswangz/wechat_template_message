require 'net/http'
require 'json'
require 'wechat_template_message/result'

class WechatTemplateMessage::Template

  def self.all access_token
    res = get_templates access_token
    json = JSON.parse(res.body)
    successful = res.is_a?(Net::HTTPSuccess) && json['template_list'] != nil
    WechatTemplateMessage::Result.new(successful, json['template_list'])
  end

  def self.find access_token, template_id
    all_template = all access_token
    WechatTemplateMessage::Result.new(false, { error_message: "Unable to find template by id #{template_id}" }) unless all_template.successful
    template = all_template.body.find { |t| t['template_id'] == template_id }
    return WechatTemplateMessage::Result.new(template != nil, template)
  end

  private

  def self.get_templates(access_token)
    uri = URI.parse("#{WechatTemplateMessage.server}/cgi-bin/template/get_all_private_template?access_token=#{access_token}")
    if WechatTemplateMessage.debug_mode && WechatTemplateMessage.logger
      WechatTemplateMessage.logger.debug "Requesting uri #{uri}..."
    end
    res = Net::HTTP.get_response(uri)
    if WechatTemplateMessage.debug_mode && WechatTemplateMessage.logger
      WechatTemplateMessage.logger.debug "Get Templates response status: #{res.code}, body: #{res.body}"
    end
    res
  end

end
