# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
# use_frameworks!

def testing_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Mockingjay',   :git => 'https://github.com/kylef/Mockingjay.git',        :branch => 'master'
  pod 'MockingjayMatchers', :git => 'https://github.com/the-grid/MockingjayMatchers.git',  :branch => 'swift3'
  pod 'URITemplate',  :git => 'https://github.com/kylef/URITemplate.swift.git', :branch => 'master'
end

def default_pods
  pod 'Argo', '>= 4.0.0'
  pod 'Ogra', :git => 'https://github.com/Eke/Ogra.git', :branch => 'master'
  pod 'Runes', '>= 4.0.0'
  pod 'Swish', :git => 'https://github.com/Eke/Swish.git', :branch => 'swift-3.0'
  pod 'Result'
end

target 'Disc-iOS' do
  platform :ios, '9.0'
  use_frameworks!

  default_pods

  target 'Disc-iOSTests' do
    inherit! :search_paths
    #testing_pods
  end

end

target 'Disc-Mac' do
  platform :osx, '10.11'
  use_frameworks!

  default_pods

  target 'Disc-MacTests' do
    inherit! :search_paths
    #testing_pods
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
