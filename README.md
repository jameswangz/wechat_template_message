YunPian SMS Ruby SDK
=========

[微信模板消息](https://mp.weixin.qq.com/wiki?action=doc&id=mp1433751277&t=0.8055365082030199) Ruby SDK, 支持以下功能:

* 获取账号所属所有模板
* 模板发送消息

Table of Contents
-----------------
* [Installation](#installation)
* [Quick Start](#quick-start)
* [License](#license)
* [Contact](#contact)


Installation
------------

You may get the latest stable version from [Rubygems]:

    $ gem install wechat_template_message

For bundler:

    gem 'wechat_template_message'


Quick Start
-----------

~~~ ruby
require 'rubygems'
require 'wechat_template_message'

# 获取短信模板
result = WechatTemplateMessage::Template.all
if result.successful
  result.body.each do |element|
    template_id = element["tpl_id"]
    template = WechatTemplateMessage::Template.find(template_id).body
  end  
else
  # raise error
end

# 模板单条发送短信
WechatTemplateMessage.api_key = api_key
template_id = 'xxxxxx'
mobile_no = configuration['single_mobile_no']
# 【智能通勤】车辆变更提醒: 尊敬的乘客您好, 您所乘坐的#keyword1#由于#keyword2#, 车牌号变更为#keyword3#, 变更日期范围为#keyword4#, 请提前到乘车站点候车以免耽误您的行程，谢谢。
params = {
  keyword1: '横琴号十号线',
  keyword2: '车辆定期维修',
  keyword3: '粤C66666',
  keyword4: '2019-05-20 至 2019-05-22'
}
result = WechatTemplateMessage::Sender.template_single_send(template_id, mobile_no, params)
~~~


License
-------

The wechat_template_message ruby gem is licensed under the terms of the MIT license.
See the file LICENSE for details.

Contact
-------

* Author:    James Wang
* Email:     james.wang.z81@gmail.com

