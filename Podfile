use_frameworks!

target 'TrianglifySwift_Example' do
  pod 'TrianglifySwift', :path => '.'

  target 'TrianglifySwift_Tests' do
    inherit! :search_paths


  end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
