#import "NBView1.h"

/**
 1.纯代码的方式创建自定义View
 基本步骤：
     1.重写 - (instancetype)initWithFrame方法，在此方法中创建并添加子控件。
     2.提供一个便利的构造方法，通常为 类方法，快速创建一个实例对象
     3.重写 - (void)layoutSubviews方法，在此方法中设置子控件的frame，一定要调用[super layoutSubviews]
     4.设置属性，在set方法中，给对应的子控件赋值。

 使用纯代码封装创建自定义View的时候需要注意:
 1.一般来说我们的自定义类继承自UIView，首先在initWithFrame:方法中将需要的子控件加入view中。
 注意:这里只是加入到view中，并没有设置各个子控件的尺寸。并且是在initWithFrame方法中而不是init方法

 2.initWithFrame:中添加子控件。
 layoutSubviews中设置子控件frame。
 对外设置数据接口，重写setter方法给子控件设置显示数据。(model)
 在view controller里面使用init/initWithFrame:方法创建自定义类，并且给自定义类的frame赋值。
 对自定义类对外暴露的数据接口进行赋值即可。



 */
@interface NBView1 ()

@property(nonatomic,strong)UILabel*label1;

@property(nonatomic,strong)UILabel*label2;

@end

@implementation NBView1

// 1.重写initWithFrame:方法，创建子控件并添加到自己上面
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 创建Label-1
        self.label1 = [[UILabel alloc]init];
        [self.label1 setBackgroundColor:[UIColor grayColor]];
        [self addSubview:self.label1];
        
        // 创建Label-2
        self.label2 = [[UILabel alloc]init];
        [self.label2 setBackgroundColor:[UIColor greenColor]];
        [self addSubview:self.label2];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"self.frame: %@",NSStringFromCGRect(self.frame));
    CGSize size = self.frame.size;
    self.label1.frame = CGRectMake(0,0,size.width, size.height*0.5);
    
    self.label2.frame = CGRectMake(0,size.height*0.5, size.width, size.height*0.5);
}

- (void)setLabelStrs:(NSArray *)labelStrs{
    if (labelStrs && labelStrs.count == 2) {
        [self.label1 setText:[labelStrs objectAtIndex:0]];
        [self.label2 setText:[labelStrs objectAtIndex:1]];
    }
}

/**
 命中测试
 命中测试（hitTest）主要会用到视图类的hitTest函数和pointInside函数。其中，前者用于递归寻找命中者，后者则是检测当前视图是否被命中，即触摸点坐标是否在视图内部。当触摸事件发生后，系统会将触摸事件以UIEvent的方式加入到UIApplication的事件队列中，UIApplication将事件分发给根部的UIWindow去处理，UIWindow则开始调用hitTest方法进行迭代命中检测。
 
 命中检测具体迭代的过程为：如果触摸点在当前视图内，那么递归对当前视图内部所有的子视图进行命中检测；如果不在当前视图内，那么返回NO停止迭代。这样最终会确定屏幕上最顶部的命中的视图元素，即命中者。
 
 响应者链
 通过命中测试找到命中者后，任务并没有完成，因为最终的命中者不一定是事件的响应者。所谓的响应就是开发中为事件绑定的一个触发函数，事件发生后执行响应函数里的代码.
 
 一个继承自UIResponder的视图要想能响应事件，还需要满足如下一些条件：
 1）必须要有对应的视图控制器，因为按照MVC模式响应函数的逻辑代码要写在控制器内。另外，userInteractionEnabled属性必须设置为YES，否则会忽视事件不响应。
 2）hidden属性必须设置为NO，隐藏的视图不可以响应事件，类似的alpha透明度属性的值不能过低，低于0.01接近透明也会影响响应。
 3）最后要注意保证树形结构的正确性，子节点的frame一定都要在父节点的frame内。
 
 
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

@end
