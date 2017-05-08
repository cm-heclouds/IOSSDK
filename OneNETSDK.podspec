#
#  Be sure to run `pod spec lint OneNETSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "OneNETSDK"
  s.version      = "2.0.0"
  s.summary      = "OneNet API."
  s.homepage     = "http://open.iot.10086.cn/doc/art246.html#68"
  s.license      = "MIT"
  s.author    	 = "IOT"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/cm-heclouds/IOSSDK.git", :tag => "2.0.0" }
  s.source_files  = "OneNETSDK/**/*.{h,m}"
end
