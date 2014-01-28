Pod::Spec.new do |s|
  s.name     = 'DateClay'
  s.version  = '1.0.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'NSDateを切ったりつないだりするためのライブラリ'
  s.homepage = 'https://github.com/akuraru/DateClay'
  s.ios.deployment_target = '6.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.author   = { 'Akuraru IP' => 'akuraru@gmail.com' }
  s.source   = {
    :git => 'https://github.com/akuraru/DateClay.git',
    :tag => s.version.to_s
  }
  s.platform = :ios
  s.requires_arc = true

  s.subspec 'Core' do |a|
    a.source_files  = 'lib/*.{h,m}'
  end
end