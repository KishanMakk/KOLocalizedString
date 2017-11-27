Pod::Spec.new do |s|
  s.name = 'KOLocalizedString'
  s.version = '0.0.1'
  s.license = 'MIT'
  s.summary = 'Alternative NSLocalized​String in Swift'
  s.homepage = 'https://github.com/SethSky/KOLocalizedString'
  s.social_media_url = ''
  s.authors = { 'Oleksandr Khymych' => 'seth@khymych.com' }
  s.source = { :git => 'https://github.com/SethSky/KOLocalizedString.git', :branch => "master", :tag => s.version }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/*.swift'
end