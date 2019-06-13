微信模板消息 Ruby SDK
=========

[微信模板消息](https://mp.weixin.qq.com/wiki?action=doc&id=mp1433751277&t=0.8055365082030199) Ruby SDK, 支持以下功能:

* 获取账号模板列表
* 发送模板消息

其它 ruby gem 都封装了 access-token 获取的逻辑， 不便于分布式环境使用，此 gem access-token 均需要从参数传入

[Source Code](https://github.com/jameswangz/wechat_template_message)

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

# 获取微信公众号模板列表
result = WechatTemplateMessage::Template.all access_token
if result.successful
  result.body.each do |element|
    template_id = element["template_id"]
    template_title = element["title"]
    template_content = element["content"]
  end  
else
  # raise error
end

# 发送模板消息
url = 'http://xxx.com'
miniprogram_data = {
  appid: "xxxx",
  "pagepath":"index?foo=bar"     
}
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

~~~


License
-------

The wechat_template_message ruby gem is licensed under the terms of the MIT license.
See the file LICENSE for details.

Contact
-------

* Author:    James Wang
* Email:     james.wang.z81@gmail.com

