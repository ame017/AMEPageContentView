#
#  Be sure to run `pod spec lint AMEPageContentView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "AMEPageContentView"
  s.version      = "1.0.2"
  s.summary      = "A page content view for iOS."
  s.homepage     = "https://github.com/ame017/AMEPageContentView"
  s.screenshots  = "https://github.com/ame017/AMEPageContentView/blob/master/Display/1.gif?raw=true"
  s.license      = "MIT"
  s.author             = { "ame017" => "https://github.com/ame017" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ame017/AMEPageContentView.git", :tag => "#{s.version}" }
  s.source_files  = "AMEPageContentView/AMEPageContentView/*.{h,m}"

end
