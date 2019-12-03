Pod::Spec.new do |s|

  s.name         = "uqpay-hostui"
  s.version      = "1.0.3"
  s.summary      = "uqpay-hostui :A modern foundation for accepting payments."
  s.description  = <<-DESC
                      uqpay-host-ui is a full-stack payments platform for developers
                      This CocoaPod will help you accept payment in your iOS app.
                      DESC

  s.license        = "MIT"

  s.author         = { "cqwang" => "wangchaoqun@uqpay.com" }

  s.platform       = :ios, "9.0"

  s.requires_arc   = true

  s.homepage       = "https://github.com/uqpaytechnology/host-ui-sdk-ios"
  s.source         = { :git => "https://github.com/uqpaytechnology/host-ui-sdk-ios.git", :tag => s.version }


  s.default_subspecs = %w[HostUI]

  s.subspec "UIKit" do |s|
    s.source_files = "UQPayHostUIKit/**/*.{h,m}"
    s.public_header_files = "UQPayHostUIKit/Public/*.h"
    s.frameworks = "UIKit"
    s.resource_bundles = {
      "UQHostUIResource" => ["UQPayHostUIKit/Localization/*.lproj","UQPayHostUIKit/Images/*.png"]
    }
  end

  s.subspec "HostUI" do |s|
    s.source_files = "UQPayHostUI/**/*.{h,m}"
    s.public_header_files = "UQPayHostUI/Public/*.h"
    s.frameworks = "Foundation","UIKit"
    s.dependency "JSONModel", '~>1.8.0'
    s.dependency "AFNetworking", '~>3.2.1'
    s.dependency "WHToast", '~>0.0.2'
    s.dependency "uqpay-hostui/UIKit"
  end
end
