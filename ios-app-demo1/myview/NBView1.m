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


@end
