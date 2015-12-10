#
#  Be sure to run `pod spec lint TTCategory.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# 名称 使用的时候pod search [name]
s.name = "MeMeZhiBoSDK"
# 代码库的版本
s.version = "1.0.0"
# 简介
s.summary = "么么视频直播"
# 主页
s.homepage = "http://blog.csdn.net/wangzhi8910"
# 许可证书类型，要和仓库的LICENSE 的类型一致
s.license = "MIT"
# 作者名称 和 邮箱
s.author = { "wangzhi" => "wangzhi8910@126.com" }
# 作者主页
s.social_media_url ="http://blog.csdn.net/wangzhi8910"
# 代码库最低支持的版本
s.platform = :ios, "7.0"
# 代码的Clone 地址 和 tag 版本
s.source = { :git => "https://github.com/wangzhi1027/MeMeZhiBoSDK.git", :tag => "1.0.0" }
# 如果使用pod 需要导入哪些资源
s.source_files = '**/*.h'
# 框架是否使用的ARC/Users/apple/Desktop/TTCategory/TT_category/CALayer+Transition.m
s.requires_arc = true

#s.frameworks = 'Foundation', 'QuartzCore', 'UIKit'
end
