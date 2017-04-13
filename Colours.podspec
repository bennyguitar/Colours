Pod::Spec.new do |s|
  s.name         = 'Colours'
  s.version      = '5.13.0'
  s.summary      = '100s of beautiful, predefined Colors and Color methods. Works for iOS/OSX/tvOS.'
  s.author = {
    'Ben Gordon' => 'brgordon@ua.edu'
  }
  s.source = {
    :git => 'https://github.com/bennyguitar/Colours.git',
    :tag => s.version
  }
  s.homepage    = 'https://github.com/bennyguitar'
  s.license     = 'LICENSE'
  s.default_subspec = 'ObjC'
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.tvos.deployment_target = '9.0'

  s.subspec 'ObjC' do |ss|
    ss.source_files = '*.{h,m}'
  	ss.public_header_files = '*.h'
  end

  s.subspec 'Swift' do |ss|
  	ss.ios.deployment_target = '8.0'
    ss.tvos.deployment_target = '9.0'
  	ss.osx.deployment_target = '10.9'
    ss.source_files = '*.swift'
  end

end
