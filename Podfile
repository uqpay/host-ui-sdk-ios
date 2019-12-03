source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!

workspace 'UQPayHostUIDemo.xcworkspace'

abstract_target 'abstract_pod' do
  target 'UQPayHostUIDemo' do
    project 'UQPayHostUIDemo'
    pod 'WHToast', '~>0.0.2'
    pod 'AFNetworking', '~>3.2'
    pod "uqpay-hostui", :path => "./"
  end

  target 'UQPayHostUI' do
    use_frameworks!
    pod 'WHToast', '~>0.0.2'
    pod 'JSONModel', '~>1.8'
    pod 'AFNetworking', '~>3.2'
  end
end
