
Pod::Spec.new do |s|
  s.name             = 'LRPopupMenu'
  s.version          = '1.0.5'
  s.summary          = 'LRPopupMenu.'
  s.homepage         = 'https://github.com/huawtswork/LRPopupMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huawt' => 'ghost263sky@163.com' }
  s.source           = { :git => 'https://github.com/huawtswork/LRPopupMenu.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'LRPopupMenu/Classes/**/*'
  s.frameworks = 'UIKit', 'Foundation'
  s.dependency 'SDWebImage'
  s.dependency 'Masonry'
end
