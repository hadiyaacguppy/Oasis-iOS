# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Base-Project' do
  # Pods for Base-Project
  use_frameworks!
  pod 'R.swift'
  pod 'CZPicker'
  pod 'OneSignal'
  pod 'SDWebImage', '~> 5.0'
  pod 'SwiftLocation'
  pod "RxGesture"


end


target 'OneSignalNotificationServiceExtension' do
  use_frameworks!
    pod 'OneSignal', '>= 2.6.2', '< 3.0'
end



target 'Base-ProjectTests' do
  use_frameworks!

end

target 'AnalyticsManager' do
  use_frameworks!
  pod 'Firebase/Core'
end



post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      end
  end
end
