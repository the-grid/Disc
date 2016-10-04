# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

def testing_pods
	#
end

def default_pods
  pod 'SwiftyJSON'
  pod 'Alamofire'
end

target 'Disc-iOS' do
  platform :ios, '9.0'
  use_frameworks!

  default_pods

  target 'Disc-iOSTests' do
    inherit! :search_paths
    testing_pods
  end

end

target 'Disc-Mac' do
  platform :osx, '10.11'
  use_frameworks!

  default_pods

  target 'Disc-MacTests' do
    inherit! :search_paths
    testing_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
