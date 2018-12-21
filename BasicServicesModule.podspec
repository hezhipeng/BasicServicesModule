Pod::Spec.new do |s|

  s.name         = "BasicServicesModule"
  s.version      = "0.7.0"
  s.summary      = "Basic Services Module"
  s.homepage     = "https://github.com/hezhipeng"
  s.license      = "MIT"

  s.author             = { "Frank" => "hezhipeng1990@gmail.com" }
  s.social_media_url   = "https://www.weibo.com/2192654453"

  s.platform     = :ios, "9.0"
  s.source       = { :git =>  "https://github.com/hezhipeng/BasicServicesModule.git", :tag => s.version }
  s.swift_version = "4.2"
  s.source_files  = "BasicServicesModule/*.h"

  # s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "BasicServicesModule/Core"
  end

  s.subspec "TabBarController" do |ss|
    ss.source_files  = "BasicServicesModule/TabBarController/"
	  ss.dependency "RxSwift",       '~> 4.3.1'
 	  ss.dependency "RxCocoa",       '~> 4.3.1'
  end

  s.subspec "Network" do |ss|
    ss.source_files  = "BasicServicesModule/Network/"
    ss.dependency "Moya/RxSwift",       '~> 11.0.2'
  end

  s.subspec "Navigation" do |ss|
    ss.source_files = "BasicServicesModule/Navigation/"
    ss.resources = ['BasicServicesModule/Resource/BasicServices.bundle']
    ss.dependency "BasicServicesModule/Core"
  end

  s.subspec "Indicator" do |ss|
    ss.source_files = "BasicServicesModule/Indicator/"
    ss.dependency "FHUD",       '~> 0.5.0'
  end
  
  s.dependency "SwifterSwift",       '~> 4.6.0'

end
