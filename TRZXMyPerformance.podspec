
Pod::Spec.new do |s|

  s.name         = "TRZXMyPerformance"
  s.version      = "0.0.1"
  s.summary      = "TRZXMyPerformance 我的业绩组件"

  s.homepage     = "https://github.com/TRZXDev/TRZXMyPerformance.git"
 
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Rhino" => "502244672@qq.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/TRZXDev/TRZXMyPerformance.git", :tag => s.version.to_s }

  s.source_files = "TRZXMyPerformance/TRZXMyPerformance/*.{h,m}"
  s.resources    = "TRZXMyPerformance/TRZXMyPerformance/*.{xib,png}"  

  s.dependency 'TRZXNetwork'  
  s.dependency 'TRZXKit'
  s.dependency 'MJExtension'
  s.dependency 'CTMediator'
  s.dependency 'MJRefresh'
  s.dependency 'SDWebImage'
  s.dependency 'TRZXDIYRefresh'

  s.requires_arc = true

end