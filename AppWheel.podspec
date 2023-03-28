#
#  Be sure to run `pod spec lint SaaS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "AppWheel"
  spec.version      = "2.1.2.0"
  spec.summary      = "A short description of AppWheel."

  spec.description  = 'An in-app purchase module for iOS project'

  spec.homepage     = "https://github.com/Pixocial/testSaaS-iOS/blob/master/README.md"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }

  spec.author       = { "Pixocial" => "app@miraclevision.sg" }

  spec.source       = { :git => "https://github.com/Pixocial/testSaaS-iOS.git", :tag => "#{spec.version}" }

  # 系统动态库(多个)
  spec.ios.frameworks = 'UIKit','StoreKit','Security'
  spec.osx.frameworks = 'AppKit','StoreKit','Security'
  # iOS限制版本
  spec.ios.deployment_target = '10.0'
  # mac限制版本
  spec.osx.deployment_target = '10.15'


  # spec.resource_bundles = {
  #   'awPurchase' => ['sdk/*.pem']
  # }

  # spec.pod_target_xcconfig = {
  #   'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  # }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
   'GENERATE_INFOPLIST_FILE' => 'YES',
    'VALID_ARCHS' => 'x86_64 armv7 arm64'}
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
   'GENERATE_INFOPLIST_FILE' => 'YES',
    'VALID_ARCHS' => 'x86_64 armv7 arm64' }

# core
  spec.subspec 'core' do |core|
    # 第三方非开源framework(多个)
    core.ios.vendored_frameworks = 'sdk/core/AWCore.framework'
    core.osx.vendored_frameworks = 'sdk/core/AWCore.framework'
  end

# analytics
  spec.subspec 'analytics' do |analytics|
    # 第三方非开源framework(多个)
    analytics.ios.vendored_frameworks = 'sdk/analytics/AWAnalytics.framework'
    analytics.osx.vendored_frameworks = 'sdk/analytics/AWAnalytics.framework'
  end

# 购买的SDK
  spec.subspec 'purchase' do |purchase|
    # 第三方非开源framework(多个)
    purchase.ios.vendored_frameworks = 'sdk/purchaseSDK/PurchaseSDK.framework'
    purchase.osx.vendored_frameworks = 'sdk/purchaseSDK/PurchaseSDK.framework'
    purchase.ios.resources = 'sdk/purchaseSDK/*.bundle'
    purchase.osx.resources = 'sdk/purchaseSDK/*.bundle'
  end

# marvel
  spec.subspec 'marvel' do |marvel|
    # 第三方非开源framework(多个)
    marvel.ios.vendored_frameworks = 'sdk/marvel/AWMarvel.framework'
    marvel.osx.vendored_frameworks = 'sdk/marvel/AWMarvel.framework'
  end
# UI的SDK
  # spec.subspec 'subscribeUI' do |ui|
  #   # 代码
  #   ui.source_files = 'sdk/uiSDK/classes/**/*.{h,m}'
  #   ui.public_header_files = "sdk/uiSDK/classes/**/*.h"
  #   # 资源文件
  #   ui.resources = 'sdk/uiSDK/*.bundle'
  #   # 支付的SDK
  #   ui.dependency 'AppWheel/purchase'
  #   #Masonry布局
  #   ui.dependency 'Masonry'
  #   #AFNetworking布局
  #   ui.dependency 'AFNetworking'
  #   #webImage布局
  #   ui.dependency 'SDWebImage'
    
  #   # ui.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  #   # ui.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }


  # end



end
