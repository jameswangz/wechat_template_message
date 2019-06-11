$:.unshift(File.join(File.dirname(__FILE__),'..','lib'))

require 'rubygems'
require 'bundler'
require 'wechat_template_message'

# Bundler.require(:default, :development)

def fixture_path(name)
  File.join(File.dirname(__FILE__), 'fixtures', name.to_s)
end
