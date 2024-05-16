Pod::Spec.new do |s|
  s.name         = "EffectivDeviceiOS"
  s.version      = "1.0"
  s.summary      = "Effectiv Device SDK for iOS."
  s.description  = "Effectiv Device SDK for iOS. Please visit our developer docs for detailed integration usage."
  s.homepage     = "https://effectiv.ai/deviceintel/"
  s.license      = { :type => "Commercial", :file => "#{s.version}/LICENSE" }
  s.author       = { "Abra Innovations, Inc." => "support@effectiv.ai" }
  s.platform     = :ios, "12.0"



  s.source       = { :http => "https://files.effectiv.ai/deviceintel/EffectivDeviceiOS_v1.0.zip" }
  s.static_framework = true
  s.swift_version = "5.0"
  s.ios.deployment_target = "12.0"

  s.vendored_frameworks = "#{s.version}/EffectivDeviceiOS.xcframework"
end