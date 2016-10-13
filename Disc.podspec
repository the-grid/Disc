Pod::Spec.new do |s|
  s.name         = "Disc"
  s.version      = "0.6.0"
  s.summary      = "An API client for Grid Passport."
  s.homepage     = "https://github.com/the-grid/Disc"
  s.license     = { :type => "MIT" }
  s.author             = { "Nick Velloff" => "nick.velloff@gmail.com" }
  s.social_media_url   = "https://twitter.com/nickvelloff"
  s.platform     = :ios
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/the-grid/Disc.git", :tag => "#{s.version}" }
  s.source_files  = "Classes", "Disc/**/*.{h,m,Swift}"
  s.requires_arc = true
  s.dependency "Swish", "~> 1.0.0"
  s.dependency "Argo", "~> 4.0.0"
  s.dependency "Ogra", "~> 3.0.0"
end
