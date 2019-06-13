# -*- coding: UTF-8 -*-                           
                                                  
require 'spec_helper'                             
require 'yaml'
require 'logger'                                  

describe WechatTemplateMessage do            
  
  subject(:logger) { Logger.new STDOUT  }
  subject(:configuration) { YAML.load_file('./spec/fixtures/configuration.yml') }
  subject(:access_token) { configuration['access_token']  }
  subject(:openid) { configuration['openid']  }
  subject(:template_id) { configuration['template_id']  }


  before do
    WechatTemplateMessage.debug_mode = true                     
    WechatTemplateMessage.logger = logger
  end

  context 'templates' do

    it 'should get error response when access token is invalid' do
      result = WechatTemplateMessage::Template.all 'invalid access token'
      expect(result.successful).to be false
    end

    it 'should get all templates successfully' do
      result = WechatTemplateMessage::Template.all access_token
      expect(result.successful).to be true
      logger.debug "all templates #{result.body}"
      expect(WechatTemplateMessage::Template.find(access_token, 'unexisting template id').successful).to be false
      result.body.each do |element|
        template_id = element["template_id"]
        template_result = WechatTemplateMessage::Template.find access_token, template_id
        expect(template_result.successful).to be true
        logger.debug "template #{template_result.inspect}"
      end
    end

  end

  context 'messages' do

    it 'should get error response when access token is invalid' do
      url = nil
      miniprogram_data = nil
      data = nil
      result = WechatTemplateMessage::Sender.template_send 'invalid access token', openid, template_id, url, miniprogram_data, data
      expect(result.successful).to be false
      logger.debug "result #{result.inspect}"
    end

    it 'should send template message successfuly' do
      url = nil
      miniprogram_data = nil
      data = {
          first: {
              value: '您有一张车票 L2019002234324 距乘车时间小于 30 分钟， 线路: 横琴号 十号线',
              color: '#173177'
          },
          keyword1: {
              value: '2019-04-09 18:10',
              color: '#173177'
          },
          keyword2: {
              value: '横琴创意谷',
              color: '#173177'
          },
          keyword3: {
              value: '西江月',
              color: '#173177'
          },
          keyword4: {
              value: '粤C66666',
              color: '#173177'
          },
          remark: {
              value: '请提前到乘车站点候车以免耽误您的出行',
              color: '#173177'
          }
      }
      result = WechatTemplateMessage::Sender.template_send access_token, openid, template_id, url, miniprogram_data, data
      expect(result.successful).to be true
      logger.debug "result #{result.inspect}"
    end

  end

end
