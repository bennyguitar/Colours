Pod::Spec.new do |s|
  s.name         = 'ColoursSwift'
  s.version      = '5.10.0'
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
  s.source_files = '*.swift'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true
end
