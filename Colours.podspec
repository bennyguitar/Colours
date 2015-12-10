Pod::Spec.new do |s|
  s.name         = 'Colours'
  s.version      = '5.11.0'
  s.summary      = '100s of beautiful, predefined Colors and Color methods. Works for iOS/OSX.'
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
  
  s.subspec 'ObjC' do |ss|
    ss.source_files = '*.{h,m}'
  	ss.public_header_files = '*.h'
  	ss.ios.deployment_target = '5.0'
  	ss.osx.deployment_target = '10.7'
  end

  s.subspec 'Swift' do |ss|
    ss.source_files = '*.swift'
  	ss.ios.deployment_target = '8.0'
  	ss.osx.deployment_target = '10.9'
  end

end
