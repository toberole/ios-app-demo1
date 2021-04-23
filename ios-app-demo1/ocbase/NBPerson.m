#import "NBPerson.h"

@implementation NBPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    return YES;
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    return YES;
//}

+ (void)load{
    NSLog(@"NBPerson load ......");
}

//+ (void)initialize
//{
//    if (self == [<#ClassName#> class]) {
//        <#statements#>
//    }
//}

@end


/**
 类的初始化
 
 Objective-C 是建立在 Runtime 基础上的语言，类也不例外。OC 中类是初始化也是动态的。在 OC 中绝大部分类都继承自 NSObject，它有两个非常特殊的类方法 load 和 initilize，用于类的初始化
 
 +load
 +load 方法是当类或分类被添加到 Objective-C runtime 时被调用的，实现这个方法可以让我们在类加载的时候执行一些类相关的行为。子类的 +load 方法会在它的所有父类的 +load 方法之后执行，而分类的 +load 方法会在它的主类的 +load 方法之后执行。但是不同的类之间的 +load 方法的调用顺序是不确定的。

 load 方法不会被类自动继承, 每一个类中的 load 方法都不需要像 viewDidLoad 方法一样调用父类的方法。子类、父类和分类中的 +load 方法的实现是被区别对待的。也就是说如果子类没有实现 +load 方法，那么当它被加载时 runtime 是不会去调用父类的 +load 方法的1。同理，当一个类和它的分类都实现了 +load 方法时，两个方法都会被调用。因此，我们常常可以利用这个特性做一些“邪恶”的事情，比如说方法混淆（Method Swizzling）。FDTemplateLayoutCell 中就使用了这个方法，见这里。

 +initialize
 +initialize 方法是在类或它的子类收到第一条消息之前被调用的，这里所指的消息包括实例方法和类方法的调用。也就是说 +initialize 方法是以懒加载的方式被调用的，如果程序一直没有给某个类或它的子类发送消息，那么这个类的 +initialize 方法是永远不会被调用的。

 +initialize 方法的调用与普通方法的调用是一样的，走的都是发送消息的流程。换言之，如果子类没有实现 +initialize 方法，那么继承自父类的实现会被调用；如果一个类的分类实现了 +initialize 方法，那么就会对这个类中的实现造成覆盖。
 
 
 */
