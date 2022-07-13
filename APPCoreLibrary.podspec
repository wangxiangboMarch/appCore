
Pod::Spec.new do |s|
  s.name    = 'APPCoreLibrary'
  s.version = '1.0.0'
  s.summary = 'An APP base Framework to help me start a project quickly.'

  s.description = <<-DESC 
                      APPCoreLibrary include some tools and frameworks which is required to create an normal APP.
                  * With this，so I can start write a project very quickly.
                  DESC
  
  s.homepage = 'https://github.com/wangxiangboMarch/appCore.git'
  
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.authors            = { "wangxiangbo" => "laoyouhub@icloud.com" }

  s.swift_version = "5.0"
  
  s.ios.deployment_target = "12.0"

  s.source       = { :git => "https://github.com/wangxiangboMarch/appCore.git", :tag => s.version }
  s.source_files  = [
    "Sources/APPCoreLibrary/**/*.swift",
    "Sources/APPCoreLibrary.h"
  ]

  s.resource_bundles = {
    'LocalizationString' => ["Sources/APPCoreLibrary/**/*.strings"],
    'JsonFiles' => ["Sources/APPCoreLibrary/**/*.json"]
  }

  s.dependency 'SnapKit', '~> 5.0.0'

  s.public_header_files = ["Sources/BSKAppCore.h"]
  s.requires_arc = true
  
  s.subspec 'PUMLogConsole' do |sub1|
    sub1.source_files  = [
      "Sources/PUMLogConsole/**/*.swift"
    ]
    sub1.dependency 'APPCoreLibrary/BSKLog'
  end

  s.subspec 'PUMLog' do |sub2|
    sub2.source_files  = [
      "Sources/PUMLog/**/*.swift"
    ]
    sub2.dependency 'APPCoreLibrary/BSKUtils'
  end

  s.subspec 'PUMUtils' do |sub3|
    sub3.source_files  = [
      "Sources/PUMUtils/**/*.swift"
    ]
  end
end
