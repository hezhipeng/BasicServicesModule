Pod::Spec.new do |s|

  s.name         = "BasicServicesModule"
  s.version      = "0.5.9"
  s.summary      = "Basic Services Module"
  s.homepage     = "https://github.com/hezhipeng"
  s.license      = "MIT"

  s.author             = { "Frank" => "hezhipeng1990@gmail.com" }
  s.social_media_url   = "https://www.weibo.com/2192654453"

  s.platform     = :ios, "9.0"
  s.source       = { :git =>  "https://github.com/hezhipeng/BasicServicesModule.git", :tag => s.version }
  s.swift_version = "4.1"
  s.source_files  = "BasicServicesModule/*.h"

  # s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "BasicServicesModule/Core"
  end

  s.subspec "TabBarController" do |ss|
    ss.source_files  = "BasicServicesModule/TabBarController/"
	ss.dependency "RxSwift"
 	ss.dependency "RxCocoa"
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
    ss.dependency "FHUD"
  end
  
  s.dependency "RxSwift"
  s.dependency "RxCocoa"
  s.dependency "SnapKit"
  s.dependency "CryptoSwift",       '~> 0.8.3'
  s.dependency "SwiftyAttributes"
  s.dependency "SwifterSwift"
  s.dependency "AppFolder"

end
