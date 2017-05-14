Pod::Spec.new do |s|

s.name         = "EasyNet"
s.version      = "1.0.0"
s.summary      = "The package of useful tools, include categories and classes"
s.homepage = 'https://github.com/wangjufan/EasyNet'
s.license      = "MIT"
s.authors      = { 'wangjufan' => 'wangjufan@126.com'}
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/wangjufan/EasyNet.git", :tag => s.version }
s.source_files = 'EasyImage/*.{h,m}'
s.requires_arc = true

end
