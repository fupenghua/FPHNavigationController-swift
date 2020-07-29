#
# Be sure to run `pod lib lint FPHNavigationController-swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FPHNavigationController-swift'
  s.version          = '1.0.0'
  s.summary          = 'swift版本自定义导航'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  隐藏系统navigationBar，然后在每个controller添加一个navigationBar，内部适配了左按钮的左边距
                       DESC

  s.homepage         = 'https://github.com/fupenghua/FPHNavigationController-swift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fupenghua' => '390908980@qq.com' }
  s.source           = { :git => 'https://github.com/fupenghua/FPHNavigationController-swift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'FPHNavigationController-swift/*.'

end
