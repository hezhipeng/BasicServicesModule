Pod::Spec.new do |s|

  s.name         = "BasicServicesModule"
  s.version      = "0.1"
  s.summary      = "ECEJ Basic Services Module"
  s.homepage     = "http://10.4.96.22/ios"
  s.license      = "MIT"

  s.author             = { "Frank" => "hezhipeng1990@gmail.com" }
  s.social_media_url   = "https://www.weibo.com/2192654453"

  s.platform     = :ios, "9.0"
  s.source       = { :git =>  "http://10.4.96.22/Components/BasicServicesModule.git", :tag => s.version }
  s.swift_version = "4.1"
  s.source_files  = "BasicServicesModule/"

  # s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "BasicServicesModule/Core"
  end

  s.subspec "Network" do |ss|
    ss.source_files  = "BasicServicesModule/Network/"
    ss.dependency "Moya/RxSwift"
  end

  s.subspec "Navigation" do |ss|
    ss.source_files = "BasicServicesModule/Navigation/"
    ss.resources = ['BasicServicesModule/Resource/BasicServices.bundle']
    ss.dependency "BasicServicesModule/Core"
  end

  s.subspec "Indicator" do |ss|
    ss.source_files = "BasicServicesModule/Indicator/"
    ss.dependency "PKHUD"
  end
  
  s.dependency "RxSwift"
  s.dependency "RxCocoa"
  s.dependency "SnapKit"
  s.dependency "CryptoSwift",       '~> 0.8.3'
  s.dependency "SwiftyAttributes"
  s.dependency "SwifterSwift"
  s.dependency "AppFolder"

end
