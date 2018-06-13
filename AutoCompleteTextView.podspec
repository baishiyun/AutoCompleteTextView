Pod::Spec.new do |s|
  s.name         = "AutoCompleteTextView" 
  s.version      = "1.0.0"     
  s.license      = "MIT"       
  s.summary      = "AutoCompleteTextView 是一个实时刷选控件，根据输入框中的文本信息进行筛选，View的部分都已经封装好，业务部分自己实现。都以以Block的形式回掉，简单实用！现在已经支持CocoaPods管理，如果对你有所帮助，请Star和Fork。"

  s.homepage     = "https://github.com/baishiyun/AutoCompleteTextView" # 你的主页
  s.source       = { :git => "https://github.com/baishiyun/AutoCompleteTextView.git", :tag => "#{s.version}" }
  s.source_files = "AutoCompleteTextView/*.{h,m}"
  s.requires_arc = true 
  s.platform     = :ios, "7.0" 
  s.frameworks   = "UIKit", "Foundation"
  s.author             = { "白仕云" => "baishiyun@163.com" } 
  s.social_media_url   = "https://github.com/baishiyun" 

end