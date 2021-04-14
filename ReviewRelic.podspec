#
# Be sure to run `pod lib lint ReviewRelic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ReviewRelic'
  s.version          = '0.1.0'
  s.summary          = 'Collect powerful feedback from your native app with Reviewrelic’s flexible and easy-to-install SDK for IOS'
  s.license = { :type => "APACHE", :file => "LICENSE" }
  s.description = 'Create a Seamless Review Experience For your Mobile Apps. Collect powerful feedback from your native app with Reviewrelic’s flexible and easy-to-install SDK for IOS and ANDROID'
  
  s.homepage         = 'https://github.com/reviewrelic-universe/ios-sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'raheelsadiq' => '“raheel.sadiq.08@gmail.com”' }
  s.source           = { :git => 'https://github.com/reviewrelic-universe/ios-sdk.git', :tag => s.version.to_s}

  s.ios.deployment_target = '12.0'

  s.source_files = 'ReviewRelic/Classes/**/*'
  
  s.resources = 'ReviewRelic/**/*.{xcassets}'


end
