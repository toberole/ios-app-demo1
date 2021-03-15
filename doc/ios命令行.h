#ifndef README_h
#define README_h
/**
 使用stroyboard：
 1、新建stroyboard
 2、往stroyboard添加ViewController
 
 动态库包含其所依赖的静态库
 
 静态库不包含其依赖的静态库
 静态库不包含其所依赖的动态库
 
 nm 查看动态库符号表 ，T / t表示该符号出现在文本部分。如果为大写T，则符号为全局（外部）
 
 添加类似android中的asset文件：
 1 新建文件夹 然后在Finder中将文件夹后缀改为.bundle
 2 直接从外部拖一个文件夹到项目中[文件夹颜色会变成淡蓝色]
 
 shift + cmd + 2 导出应用数据
 
 // 支持外部访问iphone 存储卡，下载iFunBox
 Application supports iTunes file sharing YES
 
 
 手动安装xcode 与appstore安装有区别：
 sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
 
 // 命令打包 armv7 armv7s arm64 arm64e
 xcodebuild -target tts-lib -configuration Debug -sdk iphoneos -arch armv7 -arch arm64 -arch armv7s -arch arm64e
 
 // 命令打包 i386 x86_64
 xcodebuild -target tts-lib -configuration Debug -sdk iphonesimulator -arch i386 -arch x86_64
 
 查看架构信息
 lipo -info XXX.a
 移除架构
 lipo XXX.a -remove arm64 -output XXX.a
 分离架构
 lipo XXX.a -thin arm64 -output XXX.a
 
 */

#endif /* README_h */
