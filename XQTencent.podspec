Pod::Spec.new do |s|
    
    s.name         = "XQTencent"      #SDK名称
    s.version      = "0.1"#版本号
    s.homepage     = "https://github.com/SyKingW/XQTencent"  #工程主页地址
    s.summary      = "定时器"  #项目的简单描述
    s.license     = "MIT"  #协议类型
    s.author       = { "王兴乾" => "1034439685@qq.com" } #作者及联系方式
    
    s.ios.deployment_target  = "10.0" #平台及版本
    
    s.source       = { :git => "https://github.com/SyKingW/XQTimer", :tag => "#{s.version}"}   #工程地址及版本号
    
    s.requires_arc = true   #是否必须arc

#静态库
s.static_framework  =  true

    s.source_files = 'SDK/**/*.{h,m}'    
    s.public_header_files = 'SDK/**/*.{h}'
    
    s.dependency 'TencentOpenApiSDK'


end

