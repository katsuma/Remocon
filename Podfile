platform :ios, "9.0"
use_frameworks!
target "Remocon" do
  pod 'SwiftSocket', git: 'https://github.com/swiftsocket/SwiftSocket.git'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.3'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
  end
end
