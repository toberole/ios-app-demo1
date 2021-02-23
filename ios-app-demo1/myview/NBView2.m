#import "NBView2.h"

/**
 1. 创建一个自定义的view：Cocoa Touch Class
    创建UIView时候 Also create XIB file 的选项是不能被勾选的,与自定义cell不同
 2.创建一个同名的xib： User Interface -> View
 3.设置xib的File`s Owner的Custome Class属性为自定义的view：
 4.然后在自定义的view里面重写你需要初始化的方法：
         NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"xib的名字"owner:self options:nil];
         UIView *backView = [nibView objectAtIndex:0];
         backView.frame = frame;
         [self addSubview:backView];
 */
/**
 系统的调用流程： initWithCoder —> awakeFromNib —> layoutSubviews
 (1).加载XIB后，系统会自动调用 - (id)initWithCoder:(NSCoder *)aDecoder
 方法来初始化控件，其中aDecoder是一个解析器，对XIB进行解析；
 不能在这个方法中给XIB里自定义view的子控件进行初始化，因为initWithCoder:方法是
 ‘处于正在初始化’，有些细节还没有初始化完毕，可能还没给子控件进行连线等，
 但是可以在initWithCoder:方法里对自定义View进行初始化，但不能设置View的Frame值，
 且一般XIB的初始化操作在awakeFromNib里进行

 (2).如过还需要用代码添加子控件，可以通过重写initWithCoder:方法，
 在方法里面用代码添加子控件和初始化，添加的子控件的Frame值也要在layoutSubviews方法里设置。

 (3).当控件从XIB中创建完毕后会调用awakeFromNib方法，XIB的所有的初始化操作应该在这个方法里进行，
 但不能在这个方法中对子控件设置Frame的值

 (4).如果需要重新设置子控件的Frame值，应该在layoutSubviews方法里进行设置，
 因为父控件的Frame只要改变就就会调用该方法

 (5).用XIB封装自定义的View，控件从XIB中创建的过程不会调用init方法和initWithFrame:方法
 (使用方式二方法创建)

 (6).XIB里自定义View必须设置成自动布局，即把View的 ‘Show the File inspector’ 里面的 ‘Use Auto Layout’ 前面的钩去掉；这样设置后才可以在layoutSubviews里重新设置自定义View的子控件Button的Frame值
 */

/**
 常见问题
 ①使用xib关联自定义view中, 方式一的创建方法可能出现修改不了frame的问题
 HotProductView * proView = [[HotProductView alloc]initWithFrame:CGRectMake(x, y, w, h)];
 这样创建自定义view设置frame时发现设置不起作用或者不对, 解决办法是 在-(void)drawRect:(CGRect)rect里面重新设置frame
 ②使用xib关联自定义view中, 方式二的创建方法
 在initWithCoder:里面访问属性，比如self.button，会发现它是nil的，因为此时自定义控件正在初始化，self.button可能还未赋值

 */

@interface NBView2 ()

{
    CGRect myframe;
}

@end

@implementation NBView2


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.frame = myframe;
}


// 方式一 :
// 重写initWithFrame构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    myframe = frame;
    
    if (self) {
    //ARRewardView : 自定义的view名称
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"NBView2" owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
    }
    return self;
}

// 方式二:
// 写一个创建自定义view的类方法
+ (instancetype)initCreatView {
    return [[[NSBundle mainBundle] loadNibNamed:@"NBView2" owner:self options:nil] objectAtIndex:0];
}

@end
