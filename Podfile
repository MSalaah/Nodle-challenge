# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'NodleChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NodleChallenge
  pod 'Moya', '~> 15.0'

  target 'NodleChallengeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'NodleChallengeUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
