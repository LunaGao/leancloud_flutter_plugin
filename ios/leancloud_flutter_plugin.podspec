#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'leancloud_flutter_plugin'
  s.version          = '0.0.1'
  s.summary          = 'LeanCloud flutter plugin by Luna Gao'
  s.description      = <<-DESC
LeanCloud flutter plugin by Luna Gao
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'

  s.ios.deployment_target = '8.0'

  s.dependency 'AVOSCloud', '~> 11.4.9'
end

