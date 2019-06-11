# -*- coding: UTF-8 -*-                           
                                                  
require 'spec_helper'                             
require 'yaml'
require 'logger'                                  

describe WechatTemplateMessage do            
  
  subject(:logger) { Logger.new STDOUT  }
  subject(:configuration) { YAML.load_file('./spec/fixtures/configuration.yml') }
  subject(:access_token) { configuration['access_token']  }

  before do
    WechatTemplateMessage.debug_mode = true                     
    WechatTemplateMessage.logger = logger
  end

  context 'templates' do

    it 'should get error response when access token is invalid missing' do
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


  end

end
