xcodebuild
xcodebuild类似GNU里的make，它是一套完整的编译工具，其包括在命令行工具包（Command Line Tools）中。苹果做了很多简化编译的操作，使得开发者不需要像使用make一样编写makefile，仅需根据实际情况指定workspace、project、target、scheme（这几项概念要分清分别指什么东西）即可完成工程的编译。使用man xcodebuild可以查看xcodebuild所支持的功能以及使用说明。

其主要有以下功能：

1、build：构建（编译），生成build目录，将构建过程中的文件存放在这个目录下。

2、clean：清除build目录下的文件

3、test：测试某个scheme，scheme必须指定

4、archive：执行archive，导出ipa包

5、analyze：执行analyze操作


xcrun
xcrun 是 Command Line Tools中的一员。它的作用类似RubyGem里的bundle，用于控制执行环境。

xcrun会根据当前的Xcode版本环境执行命令，该版本是通过xcode-select设置的，如果系统中安装了多个版本的Xcode，推荐使用xcrun。

xcrun的使用是直接在其后增加命令，比如：xcrun xcodebuild，xcrun altool。当然xcodebuild和altool也是可以单独运行的，只不过对于多Xcode的环境他们的执行环境究竟使用的哪个版本无法保证。

launchd
launchd是一套统一的开源服务管理框架，它用于启动、停止以及管理后台程序、应用程序、进程和脚本。其由苹果公司的Dave Zarzycki编写，在OS X Tiger系统中首次引入并获得Apache授权许可证。

launchd是macOS第一个启动的进程，它的pid为1，整个系统的其他进程都是由它创建的。

当launchd启动后，它会扫描/System/Library/LaunchDaemons和/Library/LaunchDaemons里的plist文件，并加载他们。

当你输入密码，登录系统之后，launchd会扫描/System/Library/LaunchAgents和/Library/LaunchAgents、~/Library/LaunchAgents里的plist文件，并加载。

这些plist文件代表启动任务，也叫Job，它里面配置了启动任务启动形式的描述信息。

