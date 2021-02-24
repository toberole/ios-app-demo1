#import "MyWeakProxy.h"

/**
 什么是NSProxy：
     NSProxy是一个抽象的基类，是根类，与NSObject类似
     NSProxy和NSObject都实现了<NSObject>协议
     提供了消息转发的通用接口
 
 如何使用NSProxy来转发消息?
 1.我先设置一个类 WeakProxy, 继承自 NSProxy
 2.为 WeakProxy 设置一个 NSObject 属性
 3.自定义一个转换方法,相当于给 NSObject 属性赋值
 4.然后通过这个属性获得调用方法的方法签名
    methodSignatureForSelector:
    methodSignatureForSelector:方法，返回的是一个NSMethodSignature类型，来描述给定selector的参数和返回值类型。返回nil，表示proxy不能识别指定的selector。所有的NSObject也响应此消息。
 5.为调用设置目标
    forwardInvocation:
    forwardInvocation:方法将消息转发到对应的对象上
 */

@interface MyWeakProxy ()

@property (weak,nonatomic,readonly)id target;

@end

@implementation MyWeakProxy

- (instancetype)initWithTarget:(id)target{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target{
    return [[self alloc] initWithTarget:target];
}

// 重写- (NSMethodSignature*)methodSignatureForSelector:(SEL)see方法获得方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    return [self.target methodSignatureForSelector:aSelector];
}

// 重写- (void)forwardInvocation:(NSInvocation *)invocation方法改变调用对象,让消息实际上发给真正的实现这个方法的类
- (void)forwardInvocation:(NSInvocation *)invocation{
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]/* 判断target是否有该方法 */) {
        NSString *selectorName = NSStringFromSelector(invocation.selector);
                
        NSLog(@"Before calling \"%@\".", selectorName);
        
        [invocation invokeWithTarget:self.target];
        
        NSLog(@"After calling \"%@\".", selectorName);
    }
}

@end
