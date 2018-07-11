#
# Be sure to run `pod lib lint StarLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'StarLib'
  s.version          = '0.1.0'
  s.summary          = 'A short description of StarLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是我的私人类库
                       DESC

  s.homepage         = 'https://github.com/iStarEternal/StarLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iStarEternal' => '576681253@qq.com' }
  s.source           = { :git => 'https://github.com/iStarEternal/StarLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.prefix_header_contents = '#import "StarLibDefine.h"'
  s.source_files = 'StarLib/Classes/**/*'
  #s.public_header_files = 'StarLib/Classes/StarLib.h'

  # s.resource_bundles = {
  #   'StarLib' => ['StarLib/Assets/*.png']
  # }

  
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'JSONModel'
  s.dependency 'YYText'
  s.dependency 'MJRefresh'
  s.dependency 'NJKWebViewProgress'
  s.dependency 'HMSegmentedControl'
  s.dependency 'Masonry'

end
