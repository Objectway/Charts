Pod::Spec.new do |s|
  s.name = "Charts"
  s.version = "3.3.4"
  s.summary = "Charts is a powerful & easy to use chart library for iOS, tvOS and OSX (and Android)"
  s.homepage = "https://github.com/danielgindi/Charts"
  s.license = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.authors = "Daniel Cohen Gindi", "Philipp Jahoda"
  s.ios.deployment_target = "11.0"
  s.source = { :git => "https://github.com/Objectway/Charts.git", :tag => "v#{s.version}" }
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
    ss.source_files  = "Source/Charts/**/*.swift"
  end

  s.subspec "Realm" do |ss|
    ss.source_files  = "Source/ChartsRealm/**/*.swift"
    ss.dependency "Charts/Core"
    ss.dependency "RealmSwift", "~> 2.1.1"
  end
end
