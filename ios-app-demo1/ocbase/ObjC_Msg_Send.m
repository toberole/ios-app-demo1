#import "ObjC_Msg_Send.h"

@implementation ObjC_Msg_Send

void instanceMethod_1(id _self,SEL _cmd_){
    
}
// 转发接应
// 如果没有实现resolveInstanceMethod方法就进行补救或者直接返回了NO，那么进入第二道防线，这里要实现forwardingTargetForSelector方法返回另一个实例对象，让该对象代替原对象去处理这个消息。
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
//    if (aSelector == @(instanceMethod)) {
//        // return [[Test2 alloc]init];// 转发给Test2
//    }
    
    return nil;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    // 转发给Test2
//    SEL sel = [anInvocation selector];
//    Test2 *test1 = [[Test2 alloc]init];
//    [anInvocation invokeWithTarget:test1];
}
@end
