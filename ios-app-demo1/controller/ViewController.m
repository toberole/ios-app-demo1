#include <dlfcn.h>

#import "ViewController.h"
#import "FileViewController.h"
#import "NetViewController.h"
#import "NavigationControllerDemo.h"
#import "TestWrapper.h"
#include "cpp_demo1.hpp"
#import "AudioQueuePlay.h"
#import "FileUtil.h"
#import "DateUtil.h"
#import "OpenGLController.h"
#import "LifeCycleViewController.h"
#import "Test1ViewController.h"
#import "Test2ViewController.h"
#import "TestScrollViewViewController.h"
#import "GCDDemoViewController.h"
#import "UIDemo1ViewController.h"
#import "UIDemo2ViewController.h"
#import "MyTestViewController.h"
#import "MyTestViewController1.h"
#import "RegViewController.h"
#import "Test2Demo1ViewController.h"
#import "Test2Demo3ViewController.h"
#import "NBTransformDemo5ViewController.h"
#import "NBStatusBarDemoViewController.h"
#import "MultiThreadingViewController.h"
#import "NBOCBaseViewController.h"
#import "NBUIviewCALayerViewController.h"
#import "NBPerson.h"
#import "ObjC_Msg_Send.h"
#import "NBCPPViewController.h"
#import "ContainerViewController.h"
#import "NBNSUrlSessionControllerViewController.h"

// https://www.jianshu.com/p/f2598a8a816d

@interface ViewController ()

@property (nonatomic,strong)UIButton*btn_file_op;

@property (nonatomic,strong)UIButton*btn_net;

@property (nonatomic,strong)UIButton*btn_NavigationControllerDemo;

@property (nonatomic,strong)UIButton*btn_pcm;

@property (nonatomic,strong)UIButton*btn_opengl;

@property (nonatomic,strong)UIButton*btn_life;

@property (nonatomic,strong)AudioQueuePlay*audioQueuePlay;

@property (nonatomic,strong)NSConditionLock * conditionLock;

@property (nonatomic,strong)NSCondition*cond;

@property (atomic,assign)int count;

@property(nonatomic,strong)NSArray*arr;

@end

@implementation ViewController

-(void)testbase{
    // 抛出异常
    // [NSException raise:@"Invalid foo value" format:@"foo of %d is invalid", 123];
    
    NBPerson*p = [[NBPerson alloc]init];
    
    @synchronized (nil/* 不会加锁 */ ) {
        NSLog(@"@synchronized (nil) ......");
    }
    
    NSString*test_syn = nil;
    __weak typeof(test_syn) wtest_syn = test_syn;
    __strong typeof(wtest_syn) stest_syn = wtest_syn;
    if (!stest_syn) {
        NSLog(@"stest_syn == nil");
    }
    
    // 语法糖
    NSNumber *n1 = @"1";
    NSNumber*n2 = @1;
    NSArray*arr1 = @[@1,@2];
    NSDictionary*dict1 = @{
        @"name":@"xiaohong"
    };
    // 访问 但不可写
    NSNumber*n3 = arr1[0];
    NSString*str1 = dict1[@"name"];
    
    // 可变数组和可变字典用字面量初始化需要进行multableCopy
    NSMutableArray*arr2 = [@[@"1",@"2"] mutableCopy];
    NSMutableDictionary*dict2 = [@{@"name":@"hello"}mutableCopy];
    
    ///////////////////////////////////////////////////////
    /**
     在ARC下，系统只会自动管理Foundation对象的释放，而不支持对Core Foundation对象的管理
     */
    /**
     ①__bridge关键词最常用，它的含义是不改变对象的管理权所有者，本来由ARC管理的Foundation对象，转换成CoreFoundation对象后依然由ARC管理；本来由开发者手动管理的Core Foundation对象转换成Foundation对象后继续由开发者手动管理。
     
     解决方案：使用__bridge、__bridge_transfer和__bridge_retained来处理对象的管理权限的转移。
     */
    // ARC管理的Foundation对象
    NSString*s1 = @"ARC 管理的Foundation对象";
    // 转换后依然由ARC管理
    CFStringRef cs1 = (__bridge CFStringRef)s1;
    // 用户手动管理的Core Foundation对象
    CFStringRef s2 = CFStringCreateWithCString(NULL, "用户手动管理的Core Foundation对象", kCFStringEncodingUTF8);
    // 转换后 即使在ARC环境下 任然需要用户手动管理
    NSString*s2_1 = (__bridge NSString*)s2;
    
    /**
     ②__bridge_transfer用在将Core Foundation对象转换成Foundation对象时，用于进行内存管理权的移交，即本来需由开发者手动管理释放的Core Foundation对象在转换成Foundation对象后，交由ARC来管理对象的释放，开发者不用再关心对象的释放问题
     */
    // 开发者手动管理的Core Foundation对象
    CFStringRef cs3 = CFStringCreateWithCString(NULL, "开发者手动管理的Core Foundation对象", kCFStringEncodingUTF8);
    // 转换后 由ARC管理对象 不用关系内存泄漏问题
    NSString*s3 = (__bridge_transfer NSString*)cs3;// 第一种转换写法
    NSString*s3_1 = CFBridgingRelease(cs3);// 第二种转换写法
    /**
     __bridge_retained用在将Foundation对象转换成CoreFoundation对象时，进行ARC内存管理权的剥夺，即本来由ARC管理的Foundation对象在转换成Core Foundation对象后，ARC不再继续管理该对象，需要开发者自己进行手动释放该对象，否则会发生内存泄漏。
     */
    // ARC管理的Foundation对象
    NSString*s4 = @"ARC管理的Foundation对象";
    // 转换后ARC不再继续管理，需要用户手动管理
    CFStringRef*s4_1 = (__bridge_retained CFStringRef)s4;// 第一种写法
    CFStringRef s4_2 = (CFStringRef)CFBridgingRetain(s4);// 第二种写法
    ///////////////////////////////////////////////////////
    
}
-(void)testbase1{
    ObjC_Msg_Send*o = [[ObjC_Msg_Send alloc]init];
    [o instanceMethod];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self testbase];
    // [self testbase1];
    
    NSArray*arr = nil;
    
    NSString *test_str = @"今天天气怎么样hello";
    NSLog(@"str: %@,len: %ld",test_str,[test_str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]);
    
    self.arr = @[@"Hello",@"World"];
    
    self.btn_file_op = [self.view viewWithTag:1];
    [self.btn_file_op addTarget:self action:@selector(btn_file_op_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_net = [self.view viewWithTag:2];
    [self.btn_net addTarget:self action:@selector(btn_net_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_NavigationControllerDemo = [self.view viewWithTag:3];
    [self.btn_NavigationControllerDemo addTarget:self action:@selector(btn_NavigationControllerDemo_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_pcm = [self.view viewWithTag:4];
    [self.btn_pcm addTarget:self action:@selector(btn_pcm_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_opengl = [self.view viewWithTag:5];
    [self.btn_opengl addTarget:self action:@selector(btn_opengl_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.btn_life = [self.view viewWithTag:6];
    [self.btn_life addTarget:self action:@selector(btn_life_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*test1 = [self.view viewWithTag:7];
    [test1 addTarget:self action:@selector(btn_test1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*test2 = [self.view viewWithTag:8];
    [test2 addTarget:self action:@selector(btn_test2_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*cppBtn = [self.view viewWithTag:9];
    [cppBtn addTarget:self action:@selector(btn_cpp_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIDevice*device = [UIDevice currentDevice];
    NSLog(@"currentDevice model: %@",[device model]);
    
    // [self test];
    // [self test1];
    // [self test2];
    // [self test3];
    // [self test4];
    //
    // [self test5];
    // [self test6];
    
    // [self test7];
}

-(void)btn_cpp_clicked{
//    NBCPPViewController*v=[[NBCPPViewController alloc]init];
//    UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:v];
//    u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:u_cv animated:YES completion:nil];
   
    ContainerViewController*v=[[ContainerViewController alloc]init];
    UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:v];
    u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:u_cv animated:YES completion:nil];
   
    

}

-(void)btn_test2_clicked{
    int testIndex = 6;
    
    NSLog(@"btn_test2_clicked testIndex: %d",testIndex);
    switch (testIndex) {
        case 6:
        {
            //
            NBUIviewCALayerViewController
            *cv = [[NBUIviewCALayerViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
        }break;
        case 5:
        {
            //
            NBOCBaseViewController
            *cv = [[NBOCBaseViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
        }break;
        
        case 4:
        {
            //
            MultiThreadingViewController
            *cv = [[MultiThreadingViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
        }break;
        case 3:
        {
            NBStatusBarDemoViewController
            *cv = [[NBStatusBarDemoViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
            
            
        }
            break;
        case 2:
        {
            NBTransformDemo5ViewController
            *cv = [[NBTransformDemo5ViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
        }
            break;
        case 0:{
            Test2Demo1ViewController *cv = [[Test2Demo1ViewController alloc]init];
            UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
            u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
            [self presentViewController:u_cv animated:YES completion:nil];
        }
            break;
        case 1:
        {
            Test2Demo3ViewController*v = [[Test2Demo3ViewController alloc]init];
            CGRect viewBounds = [[UIScreen mainScreen] applicationFrame];//不包含状态栏的Rect
            UINavigationController*nv = [[UINavigationController alloc]initWithRootViewController:v];
            nv.modalPresentationStyle = UIModalPresentationFullScreen;
            
            /**
             UINavigationBar是UINavigationController的View的上面的那部分。
             UINavigationController负责创建UINavigationBar。
             */
            //            UINavigationItem*item = [nv.navigationBar.items objectAtIndex:0];
            //            item.title = @"123456";
            
            
            
            [self presentViewController:nv animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    
}

-(void)btn_test1_clicked{
    arc4random_uniform(100);
    int test_index = 8;
    if (test_index==0) {
        MyTestViewController1*ui_vc = [[MyTestViewController1 alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index==1) {
        Test1ViewController*ui_vc = [[Test1ViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index==2){
        Test2ViewController*ui_vc =[[Test2ViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index==3){
        TestScrollViewViewController*ui_vc =[[TestScrollViewViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index == 4){
        GCDDemoViewController*ui_vc =[[GCDDemoViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index == 5){
        UIDemo1ViewController*ui_vc =[[UIDemo1ViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index == 6){
        UIDemo2ViewController*ui_vc =[[UIDemo2ViewController alloc]init];
        UINavigationController *vc = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if (test_index == 7){
        MyTestViewController*ui_vc = [[MyTestViewController alloc]init];
        UINavigationController *n = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        n.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:n animated:YES completion:nil];
        
    }else if (test_index == 8){
        RegViewController*ui_vc = [[RegViewController alloc]init];
        UINavigationController *n = [[UINavigationController alloc]initWithRootViewController:ui_vc];
        n.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:n animated:YES completion:nil];
    }
}

/**
 用法类似java的Object#wait notify
 */
-(void)test7{
    if (!self.cond) {
        self.cond = [[NSCondition alloc]init];
        for (int i = 0; i<50; i++) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self producers];
            });
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                [self consumers];
            });
        }
    }
}

-(void)producers{
    [self.cond lock];
    while (self.count!=0) {
        [self.cond wait];
    }
    
    NSLog(@"producers count: %d",self.count);
    self.count++;
    [self.cond signal];
    [self.cond unlock];
}

-(void)consumers{
    [self.cond lock];
    while (self.count!=1) {
        [self.cond wait];
    }
    
    NSLog(@"consumers count: %d",self.count);
    self.count--;
    [self.cond signal];
    [self.cond unlock];
}

/**
 NSConditionLock
 */
-(void)test6{
    self.conditionLock = [[NSConditionLock alloc]init];
    __block int n = 10;
    
    dispatch_queue_t test_q = dispatch_queue_create("test_q", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(test_q, ^{
        while (n>0) {
            [self.conditionLock lockWhenCondition:1];
            NSLog(@"test6 1...... n: %d",n);
            n--;
            [self.conditionLock unlockWithCondition:0];
        }
    });
    
    dispatch_async(test_q, ^{
        while (n>0) {
            [self.conditionLock lock];
            NSLog(@"test6 2...... n: %d",n);
            [self.conditionLock unlockWithCondition:1];
        }
    });
}

-(void)test5{
    NSString*home = NSHomeDirectory();
    NSString *documentsDir = [home stringByAppendingString:@"/Documents"];
    NSLog(@"documentsDir: %@",documentsDir);
    
    NSString*txt1 = @"你好，世界！";
    NSData *data = [txt1 dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:[NSString stringWithFormat:@"%@/test_1111.txt",documentsDir] atomically:YES];
    txt1 = @"hello world!";
    data = [txt1 dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:[NSString stringWithFormat:@"%@/test_1111.txt",documentsDir] atomically:YES];
    
    [FileUtil appendToFile:[NSString stringWithFormat:@"%@/test_1111.txt",documentsDir] data:data];
    [FileUtil appendToFile:[NSString stringWithFormat:@"%@/test_1111.txt",documentsDir] data:data];
    
    [FileUtil readDataFromFile:[NSString stringWithFormat:@"%@/test_1111.txt",documentsDir] bufLen:2000 block:^(long len,NSData*data){
        if(len>0){
            NSLog(@"data len: %lu",(unsigned long)[data length]);
        }else{
            NSLog(@"read file end ......");
        }
    }];
    
    NSLog(@"date: %@",[DateUtil stringFromDate:[NSDate date]]);
    
}

-(void)btn_opengl_clicked{
    OpenGLController*cv = [[OpenGLController alloc]init];
    [[self navigationController]pushViewController:cv animated:YES];
}

-(void)btn_life_clicked{
    NSLog(@"btn_life_clicked ......");
    
    LifeCycleViewController *v = [[LifeCycleViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:v];
    
    // 进入这个UINavigationController的页面时可以：
    [self presentViewController:navigationController animated:YES completion:^{
        NSLog(@"presentViewController completion ......");
    }];
    
}

-(void)btn_pcm_clicked{
    NSLog(@"btn_pcm_clicked ......");
    if (!self.audioQueuePlay) {
        self.audioQueuePlay = [[AudioQueuePlay alloc]init];
    }
    
    dispatch_queue_t play_pcm_q = dispatch_queue_create("play_pcm_q", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(play_pcm_q, ^{
        // 读文件
        NSBundle*mainBundle = [NSBundle mainBundle];
        // 放在主工程中的自定义bundle
        NSString*test_bundle_path = [mainBundle pathForResource:@"test" ofType:@"bundle"];
        NSLog(@"test_bundle_path: %@",test_bundle_path);
        NSBundle*test_bundle=[NSBundle bundleWithPath:test_bundle_path];
        // 获取自定义bundle中的文件
        NSString*test_a_path = [test_bundle pathForResource:@"test" ofType:@"pcm"];
        NSLog(@"test_pcm_path: %@",test_a_path);
        
        BOOL b = [[NSFileManager defaultManager]fileExistsAtPath:test_a_path];
        if (b) {
            NSLog(@"test_pcm 存在");
        }
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:test_a_path];
        NSInteger count = 0;
        NSInteger dataLength = MIN_SIZE_PER_FRAME;
        NSData *data = nil;
        
        while (YES) {
            [fileHandle seekToFileOffset:count*dataLength];
            data = [fileHandle readDataOfLength:dataLength];
            
            if (!data||[data length] <= 0) {
                break;
            }
            NSUInteger len = [data length];
            if (len<MIN_SIZE_PER_FRAME) {
                data = [[NSData alloc]initWithBytes:data.bytes length:MIN_SIZE_PER_FRAME];
            }
            
            [self.audioQueuePlay playWithData:data];
            
            count++;
        }
        
        [fileHandle closeFile];
        
        Byte void_data[MIN_SIZE_PER_FRAME] = {0};
        data = [[NSData alloc]initWithBytes:void_data length:MIN_SIZE_PER_FRAME];
        [self.audioQueuePlay playWithData:data];
        [self.audioQueuePlay resetPlay];
    });
}

-(void)test4{
    [self getNowTimeTimestamp];
}

-(NSString*)getNowTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // 设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // 设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];
    
    // 单位是秒
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    NSLog(@"timeSp: %@",timeSp);
    
    return timeSp;
}

#pragma mark 直接调用cpp
-(void)test3{
    cpp_demo1_test1();
    cpp_demo1_test2();
}

-(void)test2{
    @synchronized (self) {
        NSLog(@"test2 synchronized ...... 1");
        @synchronized (self) {
            NSLog(@"test2 synchronized ...... 2");
        }
    }
}

-(void)test1{
    NSBundle*mainBundle = [NSBundle mainBundle];
    NSString*resourcePath = [mainBundle resourcePath];
    NSLog(@"resourcePath: %@",resourcePath);
    NSString*bundlePath = [mainBundle bundlePath];
    NSLog(@"bundlePath: %@",bundlePath);
    
    // 放在主工程中的自定义bundle
    NSString*test_bundle_path = [mainBundle pathForResource:@"test" ofType:@"bundle"];
    NSLog(@"test_bundle_path: %@",test_bundle_path);
    NSBundle*test_bundle=[NSBundle bundleWithPath:test_bundle_path];
    // 获取自定义bundle中的文件
    NSString*test_a_path = [test_bundle pathForResource:@"test_a" ofType:@"txt"];
    NSLog(@"test_a_path: %@",test_a_path);
    
    BOOL b = [[NSFileManager defaultManager]fileExistsAtPath:test_a_path];
    if (b) {
        NSLog(@"test_a 存在");
    }
    
    NSString*txt_1_path = [mainBundle pathForResource:@"/files/1" ofType:@"txt"];
    b = [[NSFileManager defaultManager]fileExistsAtPath:txt_1_path];
    if (b) {
        NSLog(@"1.txt fileExists %i",b);
    }
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
//    NetViewController *n = [[NetViewController alloc]init];
//    [self.navigationController pushViewController:n animated:YES];
    NSLog(@"btn_net_clicked ......");
    
 
    
    NBNSUrlSessionControllerViewController*ui_vc = [[NBNSUrlSessionControllerViewController alloc]init];
    UINavigationController *n = [[UINavigationController alloc]initWithRootViewController:ui_vc];
    n.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:n animated:YES completion:nil];
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
