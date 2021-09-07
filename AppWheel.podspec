#
#  Be sure to run `pod spec lint SaaS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "AppWheel"
  spec.version      = "1.0.5.2"
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
  spec.frameworks = 'UIKit','StoreKit','Security'

  spec.ios.deployment_target = '10.0'

  # 第三方非开源framework(多个)
  spec.vendored_frameworks = 'sdk/purchaseSDK/PurchaseSDK.framework'
  spec.resource_bundles = {
    'AppWheel' => ['sdk/purchaseSDK/*.pem']
  }

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

# 购买的SDK
  # spec.subspec 'purchase' do |purchase|
  #   # 第三方非开源framework(多个)
  #   purchase.vendored_frameworks = 'sdk/purchaseSDK/PurchaseSDK.framework'
  #   purchase.resource_bundles = {
  #     'AppWheel' => ['sdk/purchaseSDK/*.pem']
  #   }
  # end
# UI的SDK

  # spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  # spec.exclude_files = "Classes/Exclude"
end
