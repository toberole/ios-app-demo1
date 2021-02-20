#import "MultiThreadingViewController.h"

@interface MultiThreadingViewController ()

@property(nonatomic,strong)UIButton*btn1;

@property(nonatomic,strong)UIButton*btn2;

@property(nonatomic,strong)UIButton*btn3;

@property(nonatomic,strong)UIButton*btn4;

@end

@implementation MultiThreadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn1 = [self.view viewWithTag:1];
    [self.btn1 addTarget:self action:@selector(btn1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn2 = [self.view viewWithTag:2];
    [self.btn2 addTarget:self action:@selector(btn2_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [self.view viewWithTag:3];
    [self.btn3 addTarget:self action:@selector(btn3_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn4 = [self.view viewWithTag:4];
    [self.btn4 addTarget:self action:@selector(btn4_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton*btn = [self.view viewWithTag:5];
    [btn addTarget:self action:@selector(btn5_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:6];
    [btn addTarget:self action:@selector(btn6_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:7];
    [btn addTarget:self action:@selector(btn7_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:8];
    [btn addTarget:self action:@selector(btn8_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btn1_clicked{
    NSLog(@"btn1_clicked ......");
    // 是否开启了多线程
    BOOL isMultiThreaded = [NSThread isMultiThreaded];
    NSLog(@"是否开启了多线程: %d",isMultiThreaded);
    
    // 是否是主线程
    BOOL isMainThread = [NSThread isMainThread];
    NSLog(@"是否是主线程: %d",isMainThread);
    
    // 获取主线程
    NSThread *mainThread = [NSThread mainThread];
    
    // 线程睡眠 1 秒
    [NSThread sleepForTimeInterval:1];
    // 线程睡眠到指定时间
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    // 退出线程
    // [NSThread exit];
    
    // 创建线程
    // initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument
    NSThread*newThread = [[NSThread alloc]initWithTarget:self selector:@selector(new_thread_run:) object:@"thread1 ......"];
    // 设置线程优先级threadPriority(0~1.0)，即将被抛弃，将使用qualityOfService代替
    newThread.threadPriority = 1.0;
    newThread.qualityOfService = NSQualityOfServiceUserInteractive;
    // 启动线程
    [newThread start];
    
    //
    [NSThread detachNewThreadSelector:@selector(new_thread_run:) toTarget:self withObject:@"thread2 ......"];
    [NSThread detachNewThreadWithBlock:^{
        [self new_thread_run:@"thread3 ......"];
    }];
    
    /** NSObejct基类隐式创建线程的一些静态工具方法 **/
    [self performSelector:@selector(new_thread_run:) withObject:nil  afterDelay:1];
    
    /** NSObejct基类隐式创建线程的一些静态工具方法 **/
    /* 1 在当前线程上执行方法，延迟2s */
    [self performSelector:@selector(run) withObject:nil afterDelay:2.0];
    /* 2 在指定线程上执行方法，不等待当前线程 */
    [self performSelector:@selector(run) onThread:newThread withObject:nil waitUntilDone:NO];
    /* 3 后台异步执行函数 */
    [self performSelectorInBackground:@selector(run) withObject:nil];
    /* 4 在主线程上执行函数 */
    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone:NO];
    
}



-(void)new_thread_run:(id)obj{
    NSLog(@"new_thread_run obj: %@ ......",obj);
}

-(void)btn2_clicked{
    NSLog(@"btn2_clicked ......");
    /* 1. 提交异步任务 */
    NSLog(@"开始提交异步任务:");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* 耗时任务... */
        [NSThread sleepForTimeInterval:10];
        NSLog(@"异步任务执行完毕 ......");
    });
    NSLog(@"异步任务提交成功！");
        
    /* 2. 提交同步任务 */
    NSLog(@"开始提交同步任务:");
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        /* 耗时任务... */
        [NSThread sleepForTimeInterval:10];
        NSLog(@"同步任务执行完毕 ......");
    });
    NSLog(@"同步任务提交成功！");
}

-(void)btn3_clicked{
    NSLog(@"btn3_clicked ......");
    /* 创建一个并发队列 */
    dispatch_queue_t concurrent_queue = dispatch_queue_create("demo.gcd.concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    /* 创建一个串行队列 */
    dispatch_queue_t serial_queue = dispatch_queue_create("demo.gcd.serial_queue", DISPATCH_QUEUE_SERIAL);
    
    // 获取主队列（在主线程上执行）
    dispatch_queue_t main_queue = dispatch_get_main_queue();
    
    // 获取不同优先级的全局队列(优先级从高到低)
    dispatch_queue_t queue_high = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t queue_default = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t queue_low = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_queue_t queue_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    // dispatch_once_t 这个函数控制指定代码只会被执行一次，常用来实现单例模式
    
    // dispatch_after 通过该函数可以让要提交的任务在从提交开始后的指定时间后执行，也就是定时延迟执行提交的任务
    // 定义延迟时间:3s
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        // 要执行的任务...
        NSLog(@"dispatch_after ......");
    });
}

-(void)btn4_clicked{
    NSLog(@"btn4_clicked ......");
    // dispatch_group_t
    // 组调度可以实现等待一组操作都完成后执行后续操作，典型的例子是大图片的下载，例如可以将大图片分成几块同时下载，等各部分都下载完后再后续将图片拼接起来，提高下载的效率。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{ /*操作1 */ });
    dispatch_group_async(group, queue, ^{ /*操作2 */ });
    dispatch_group_async(group, queue, ^{ /*操作3 */ });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            // 后续操作...
        
    });
    
    // 切换主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI 操作
        NSLog(@"UI操作 ......");
    });
}
/**
 NSOperation
 NSOperation是基于GCD的一个抽象基类，将线程封装成要执行的操作，不需要管理线程的生命周期和同步，但比GCD可控性更强，例如可以加入操作依赖（addDependency）、设置操作队列最大可并发执行的操作个数（setMaxConcurrentOperationCount）、取消操作（cancel）等。NSOperation作为抽象基类不具备封装我们的操作的功能，需要使用两个它的实体子类：NSBlockOperation和NSInvocationOperation，或者继承NSOperation自定义子类。

 NSBlockOperation和NSInvocationOperation用法的主要区别是：前者执行指定的方法，后者执行代码块，相对来说后者更加灵活易用。NSOperation操作配置完成后便可调用start函数在当前线程执行，如果要异步执行避免阻塞当前线程则可以加入NSOperationQueue中异步执行。
 */
-(void)btn5_clicked{
    NSLog(@"btn5_clicked ......");
    
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(new_thread_run:) object:@"NSInvocationOperation ......"];
    [invocationOperation start];
    
    NSBlockOperation*blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation ......");
    }];
    // NSBlockOperation可以后续继续添加block执行块，操作启动后会在不同线程并发的执行这些 block：
    [blockOperation addExecutionBlock:^{
        NSLog(@"blockOperation 1 ......");
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"blockOperation 2 ......");
    }];
    
    [blockOperation start];
    
    /* 获取主队列(主线程) */
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    /* 创建a、b、c操作 */
    NSOperation *c = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"OperationC");
    }];
    NSOperation *a = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"OperationA");
    }];
    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"OperationB");
    }];
    /* 添加操作依赖，c依赖于a和b，这样c一定会在a和b完成后才执行，即顺序为：A、B、C */
    [c addDependency:a];
    [c addDependency:b];
    /* 添加操作a、b、c到操作队列queue(特意将c在a和b之前添加) */
    [queue addOperation:c];
    [queue addOperation:a];
    [queue addOperation:b];
    
}

-(void)btn6_clicked{
    NSLog(@"btn6_clicked ......");
    
}

-(void)btn7_clicked{
    NSLog(@"btn7_clicked ......");
    
}

-(void)btn8_clicked{
    NSLog(@"btn8_clicked ......");
    
}


@end
