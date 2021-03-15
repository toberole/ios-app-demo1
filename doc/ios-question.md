什么是SpriteKit和SceneKit
SpriteKit和SceneKit是苹果公司提供的分别用于开发2D游戏和3D游戏的框架。目前苹果公司提供的游戏引擎有3个：用于2D游戏开发的SpriteKit框架、用于3D游戏开发的SceneKit框架和底层的游戏图形库Metal。

Foundation对象与Core Foundation对象有什么区别
Foundation对象是Objective-C对象，使用Objective-C语言实现；而Core Foundation对象是C对象，使用C语言实现。两者之间可以通过__bridge、__bridge_transfer、__bridge_retained等关键字转换（桥接）。
Foundation对象和Core Foundation对象更重要的区别是ARC下的内存管理问题。在非ARC下两者都需要开发者手动管理内存，没有区别。但在ARC下，系统只会自动管理Foundation对象的释放，而不支持对Core Foundation对象的管理。因此，在ARC下两者进行转换后，必须要确定转换后的对象是由开发者手动管理，还是由ARC系统继续管理，否则可能导致内存泄漏问题。
在ARC下，NSString对象和CFStringRef对象在相互转换时，需要选择使用__bridge、__bridge_transfer和__bridge_retained来确定对象的管理权转移问题，三者的作用语义分别如下：
①__bridge关键词最常用，它的含义是不改变对象的管理权所有者，本来由ARC管理的Foundation对象，转换成CoreFoundation对象后依然由ARC管理；本来由开发者手动管理的Core Foundation对象转换成Foundation对象后继续由开发者手动管理。


如果消息在传递的过程中，接受者无法响应收到的消息，那么会触发消息转发机制。
消息转发主要就针对实例方法，类方法由于无法在运行时动态添加实现等事实并不能转发给其他类。
消息转发的三道防线：
按照先后顺序3道防线依次为：
(1)动态补加方法的实现
+ (BOOL)resolveInstanceMethod:(SEL)sel;
+ (BOOL)resolveClassMethod:(SEL)sel;
(2)直接返回消息转发到的对象[将消息发给另外一个对象去处理]
-(id)forwardingtargetSe;ector:(SEL)selector;
(3)手动生成方法签名并转发给另外一个对象。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
- (void)forwardInvocation:(NSInvocation *)anInvocation;
































































































































































