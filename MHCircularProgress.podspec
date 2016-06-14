Pod::Spec.new do |s|

  s.name         = "MHCircularProgress"
  s.version      = "1.0.0"
  s.summary      = "A good circular progress indicator made by CoderMikeHe"
  s.homepage     = "https://github.com/CoderMikeHe/MHCircularProgress"
  s.license      = "MIT"
  s.authors      = {"CoderMikeHe" => "491273090@qq.com"}
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/CoderMikeHe/MHCircularProgress.git", :tag => s.version }
  s.source_files  = "MHCircularProgress", "MHCircularProgress/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc = true

end
