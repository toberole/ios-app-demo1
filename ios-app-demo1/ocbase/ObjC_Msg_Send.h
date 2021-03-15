#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
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
 */
@interface ObjC_Msg_Send : NSObject
// 声明一个方法 不实现 触发消息转发
-(void)instanceMethod;
@end

NS_ASSUME_NONNULL_END
