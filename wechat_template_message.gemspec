$:.push File.expand_path("../lib", __FILE__)

require 'wechat_template_message/version'

Gem::Specification.new do |s|
  s.name        = 'wechat_template_message'
  s.version     = WechatTemplateMessage::VERSION
  s.date        = '2019-06-11'
  s.summary     = "微信模板消息 Ruby SDK"
  s.description = "微信模板消息 Ruby SDK, 非官方"
  s.authors     = ["James Wang"]
  s.email       = 'james.wang.z81@gmail.com'
  s.files       = %w(README.md LICENSE.md ) + Dir.glob('lib/**/*.rb')
  s.test_files  = Dir.glob('spec/*_spec.rb')
  s.homepage    = 'https://github.com/jameswangz/wechat_template_message'
  s.license     = 'MIT'

  s.add_development_dependency "rspec"

end
