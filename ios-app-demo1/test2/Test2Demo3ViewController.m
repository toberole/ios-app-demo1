#import "Test2Demo3ViewController.h"

@interface Test2Demo3ViewController ()

@end
/**

 梁飞宇
 iOS UIView与UIViewController的关系
 一.   Controller 和 View 的定义
 UIViewController: 视图控制器。 ( 从名字我可以知道它是一个控制器并且是控制视图的 ).

 UIView : 视图。( 用来展示界面 ).

 理解：简单的说就是UIViewController就是一个相框 ,而UIView 就相当于相片,相框可以随时随地的 拿走这个相片而换另外一张相片,或者在这张相片上加一个新的相片.从而我们就可以知道相片是不能操作相框的.视图控制器管理视图的生命周期.

 二.   Controller和View的生命周期
 这里我先说说Controller自带的view,它作为Controller的属性,view生命周期是在Controller的生命周期里面的. 简单点,说话的方式简单点 , 这样Controller 就不能在view释放前释放.
 
 
 */
@implementation Test2Demo3ViewController
/**
 每次访问UIViewController的view(比如controller.view、self.view)而且view为nil，loadView方法就会被调用.
 
 loadView方法是用来负责创建UIViewController的view.
 
 默认实现的方式:
 1> 它会先去查找是否使用xib文件来创建Controller ,如果是,通过加载xib文件来创建UIViewController的View
    a、如果在初始化UIViewController 指定了XIB文件名,就会根据传入的XIB文件加载对应的xib文件
    b、如果没有明显地传入XIB文件名,就会加载跟UIViewController 同名的XIB文件
2>    如果没有找到相关联的xib文件,就会创建一个空白的UIView,然后赋值个UIViewController的view
 
 */
- (void)loadView{
    [super loadView];
    NSLog(@"Test2Demo3ViewController#loadView ......");
    /**
     如果想通过代码来创建UIViewController的view，就要重写loadView方法，并且不需要调用[super loadView]
     不需要调用[super loadView]，调用了也不会出错，只是造成了一些不必要的开销。
     */
//    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test2Demo3ViewController#viewDidLoad ......");
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    self.navigationController.navigationBar.topItem.title = @"The Title";
//
    // self.title = @"a The Title a";
    
    UIView *test_view = [[UIView alloc]init];
    test_view.frame = CGRectMake(0, 44, 100, 100);
    [test_view setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:test_view];
    
    
}

/**
 这个一般在view被添加到superview之前，切换动画之前调用。在这里可以进行一些显示前的处理。比如键盘弹出，一些特殊的过程动画（比如状态条和navigationbar颜色）
 */
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"Test2Demo3ViewController#viewWillAppear ......");
}

/**
 一般用于显示后，在切换动画后，如果有需要的操作，可以在这里加入相关代码
 */
- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"Test2Demo3ViewController#viewDidAppear ......");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"Test2Demo3ViewController#viewWillDisappear ......");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"Test2Demo3ViewController#viewDidDisappear ......");
}

/**
 iOS设备的内存是极其有限的，如果应用程序占用的内存过多的话，系统就会对应用程序发出内存警告。UIViewController就会收到didReceiveMemoryWarning消息。didReceiveMemoryWarning方法的默认实现是：如果当前UIViewController的view不在应用程序的视图层次结构(View Hierarchy)中，即view的superview为nil的时候，就会将view释放，并且调用viewDidUnload方法
 */
- (void)viewWillUnload{
    NSLog(@"Test2Demo3ViewController#viewWillUnload ......");
}

- (void)viewDidUnload{
    NSLog(@"Test2Demo3ViewController#viewDidUnload ......");
}

- (void)didReceiveMemoryWarning{
    NSLog(@"Test2Demo3ViewController#didReceiveMemoryWarning ......");
}

- (void)dealloc
{
   NSLog(@"Test2Demo3ViewController#dealloc ......");
}

@end

/**
 loadView、viewDidLoad及viewDidUnload的关系
 1.第一次访问UIViewController的view时，view为nil，然后就会调用loadView方法创建view

 2.view创建完毕后会调用viewDidLoad方法进行界面元素的初始化

 3.当内存警告时，系统可能会释放UIViewController的view，将view赋值为nil，并且调用viewDidUnload方法

 4.当再次访问UIViewController的view时，view已经在3中被赋值为nil，所以又会调用loadView方法重新创建view

 5.view被重新创建完毕后，还是会调用viewDidLoad方法进行界面元素的初始化
 */
