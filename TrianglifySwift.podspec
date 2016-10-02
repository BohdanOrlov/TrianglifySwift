Pod::Spec.new do |s|
  s.name             = 'TrianglifySwift'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TrianglifySwift.'

  s.description      = <<-DESC
    Algorithmically generated triangle art. This library generates container view full of configurable triangles which are normal UIViews and can be animated.
                       DESC

  s.homepage         = 'https://github.com/BohdanOrlov/TrianglifySwift'
  s.screenshots      = 'https://github.com/BohdanOrlov/TrianglifySwift/screenshots/screenshot.png', 'https://github.com/BohdanOrlov/TrianglifySwift/screencast.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Bohdan Orlov' => 'bohdan.orlov@gmail.com' }
  s.source           = { :git => 'https://github.com/BohdanOrlov/TrianglifySwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bohdan_orlov'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TrianglifySwift/Classes/**/*'
end
