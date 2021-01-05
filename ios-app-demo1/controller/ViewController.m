#import "ViewController.h"
#import "FileViewController.h"
#import "NetViewController.h"
#import "NavigationControllerDemo.h"
#import "TestWrapper.h"
#include <dlfcn.h>

@interface ViewController ()

@property (nonatomic,strong)UIButton*btn_file_op;

@property (nonatomic,strong)UIButton*btn_net;

@property (nonatomic,strong)UIButton*btn_NavigationControllerDemo;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_file_op = [self.view viewWithTag:1];
    [self.btn_file_op addTarget:self action:@selector(btn_file_op_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_net = [self.view viewWithTag:2];
    [self.btn_net addTarget:self action:@selector(btn_net_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_NavigationControllerDemo = [self.view viewWithTag:3];
    [self.btn_NavigationControllerDemo addTarget:self action:@selector(btn_NavigationControllerDemo_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self test];
    
}

-(void)test{
    //NSLog(@"framePaths is %@",[NSBundle allFrameworks]);
    
    TestWrapper * p = [[TestWrapper alloc]init];
    [p test1];
    [p test2];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *resourcePath =  [bundle resourcePath];
    NSString *bundlePath = [bundle bundlePath];
    NSLog(@"resourcePath: %@\nbundlePath: %@",resourcePath,bundlePath);
    
    
    NSString* dlPath = [NSString stringWithFormat: @"%@/libios_lib.a", resourcePath];
    
    BOOL b = [[NSFileManager defaultManager] fileExistsAtPath:dlPath];
    if (b) {
        NSLog(@"libios_lib fileExist ......");
    }
    
    const char* cdlpath = [dlPath UTF8String];
    void* hModule = dlopen(cdlpath, RTLD_LAZY);
    if (hModule) {
        NSLog(@"dlopen succ ......");
    }else{
        NSLog(@"dlopen fail ......");
    }
    
    NSString *homeDir = NSHomeDirectory();
    NSString *documentsDir2 = [homeDir stringByAppendingPathComponent:@"Documents/files"];
    NSString* dlPath1 = [NSString stringWithFormat: @"%@/ios_lib", documentsDir2];
    hModule = dlopen([dlPath1 UTF8String], RTLD_LAZY);
    if (hModule) {
        NSLog(@"dlopen succ ......");
    }else{
        NSLog(@"dlopen fail ......");
    }
    
    // 加载动态库
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ios_lib" ofType:@"" inDirectory:@"files"];
    b = [[NSFileManager defaultManager]fileExistsAtPath:filePath];
    if (b) {
        NSLog(@"ios_lib.so fileExist ......");
    }
    hModule = dlopen([filePath UTF8String], RTLD_LAZY);
    if (hModule) {
        NSLog(@"加载动态库 dlopen ios_lib succ ......");
        int(*func)(void);
        func = (int(*)(void))dlsym(hModule, "demo3_test1");
        int n = func();
        NSLog(@"加载动态库 dlopen demo3_test1 %d ......",n);
    }else{
        char*err = dlerror();
        NSLog(@"加载动态库 dlopen ios_lib fail errorMsg: %s......",err);
    }
}

-(void)btn_file_op_clicked{
    NSLog(@"btn_file_op_clicked ......");
    
    FileViewController *fileViewController = [[FileViewController alloc]init];
    [self.navigationController pushViewController:fileViewController animated:YES];
}

-(void)btn_net_clicked{
    NetViewController *n = [[NetViewController alloc]init];
    [self.navigationController pushViewController:n animated:YES];
}

/**
 UINavigationController是一个容器视图控制器，其内部展示着多个UIViewController的内容。UINavigationController的View由三个部分组成，最上面的UINavigationBar，最下面默认隐藏的toolbar，以及中间部分的UIViewController的View。
 
 UINavigationController的堆栈管理
 UINavigationController通过其管理的一个UIViewController堆栈来决定中间的View显示什么。中间的View显示的是UIViewController堆栈顶部的UIViewController的View。
 
 UINavigationController拥有viewControllers，navigationBar，toolBar这些属性。其中viewControllers是一个数组，在这个数组中以堆栈的形式存放着多个UIViewController。堆栈是先进后出的原则。UINavigationController的中间的View显示的是位于堆栈顶部的UIViewController的View。
 
 位于堆栈最底部的UIViewController我们称之为rootViewController(根视图控制器),一个UINavigationController的UIViewController堆栈中至少有一个视图控制器，也可以说一定存在根视图控制器。我们可以创建一个UIViewController，然后使用系统提供的方法让这个UIViewController进栈，也可以使用系统提供的方法让UIViewController堆栈中的视图控制器出栈。
 
 
 
 */
-(void)btn_NavigationControllerDemo_clicked{
    NSLog(@"btn_NavigationControllerDemo_clicked ......");
    // UINavigationController的创建
    //创建一个视图控制器
    NavigationControllerDemo *VC = [[NavigationControllerDemo alloc] init];
    //把上面创建的视图控制器作为根视图控制器创建一个UINavigationController
    //这样UINavigationController的UIViewController堆栈中已经有了一个视图控制器即VC,这时候UINavigationController的中间那部分的View显示的是VC的View。
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
    
    //设置bar的style
    //    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//这种设置是白底黑字
    //    self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //这种设置是黑底白字
    
    // 设置是否隐藏
    //    self.navigationController.navigationBar.hidden = YES;
    //    // 设置背景颜色
    //    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    //    // 设置字体颜色
    //    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //    // 设置标题字体属性
    //    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:30], NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    // 进入这个UINavigationController的页面时可以：
    [self presentViewController:navigationController animated:YES completion:^{
        NSLog(@"presentViewController completion ......");
    }];
    
    // pop到根视图控制器
    // [self.navigationController popToRootViewControllerAnimated:YES];
    
    /**
     UINavigationController负责创建UINavigationBar。而UINavigationBar的内容则是由处于UIViewController堆栈顶部的UIViewController的navigationItem这个属性来管理的。
     
     //设置bar的style
     self.navigationController.navigationBar.barStyle = UIBarStyleDefault;//这种设置是白底黑字
     self.navigationController.navigationBar.barStyle = UIBarStyleBlack; //这种设置是黑底白字
     
     UINavigationBar是UINavigationController的属性，我们在设置了UINavigationBar的外观后，其将作用于全部的UIViewController。navigationItem是UIViewController的属性，它是配置这个UIViewController上面的UINavigationBar的内容的。UINavigationBar中有一个堆栈，这个堆栈是一个UINavigationItem堆栈，当把一个UIViewController push进栈的时候，它的navigationItem也会被push进UINavigationBar的堆栈。所以UINavigationBar的这个堆栈和这个UIViewController堆栈是一一对应的。
     
     https://www.jianshu.com/p/f2598a8a816d
     */
    
    
}

@end
