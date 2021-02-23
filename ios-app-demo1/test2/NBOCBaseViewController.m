#import "NBOCBaseViewController.h"
#import "NBStu.h"
#import "NBLogUtil.h"
#import "NBMYUIViewViewController.h"

/**
 NSDate 相关：
 No.1 通过[NSDate date]获取是零时区的时间
 No.2 NSDate(零时区) <-> timeStamp
 No.3 系统认为NSDate应该是0时区的，NSString是东八区的
 No.4 dateFormat转换，公式NSDate（0时区）<-> NSString（东八区）
 No.5 项目中为什么总会出现8*60*60这样的东西？因为他们不知道前两个公式
 No.6 如何尽量少使用8*60*60还能解决项目的问题？ 凡是用到了NSDate，全部使用0时区的，因为至少转换成时间戳的时候，绝对正确（NSDate是为了内部比较，还有就是转成时间戳，上传数据，目的不是用来显示到屏幕上），通过No.4的公式，直接通过dateFormat转化成北京时间字符串，截取使用即可（NSString才是用来显示的，比较就让NSDate去做好了）这样基本就看不到8小时了**
 No.7 (接No.6)有一种例外，就是通过datePicker，然后获取的应该是NSDate类型的对象，应该是北京当前的时间（东八区），如果要上传服务器的话，我们要传递的是时间戳，必须转成东八区的，所以要减去8小时才行！

 */

@interface NBOCBaseViewController ()

@property dispatch_source_t timer;

@end

@implementation NBOCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    [self test2];
    [self test3];
    
    UIButton*btn = [self.view viewWithTag:1];
    [btn addTarget:self action:@selector(btn_clicked1) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:2];
    [btn addTarget:self action:@selector(btn_clicked2) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:3];
    [btn addTarget:self action:@selector(btn_clicked3) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:4];
    [btn addTarget:self action:@selector(btn_clicked4) forControlEvents:UIControlEventTouchUpInside];
    
    btn = [self.view viewWithTag:5];
    [btn addTarget:self action:@selector(btn_clicked5) forControlEvents:UIControlEventTouchUpInside];
}

/**
 1.[NSDate date]获取的数据为什么少了8小时？
 是因为他获取的是零时区的时间，显示的是格林尼治的时间: 年-月-日 时：分：秒：+时区，我们在东八区，所以会有8小时的问题，系统是没有毛病的
 2.第二个打印，和第三个打印有什么异同点？
 2.1 相同点：都是获取的正确的北京时间，没有8小时的问题（因为系统认为NSDate是0时区的，转换成字符串应该是当前时区的，所以没问题）
 2.2 相同点：都是NSDate -> NSString,而且转成字符串的文字格式多样，主要依赖DateFormat，但是可以随意确定DateFormat格式，都能输出。（但是NSString -> NSDate不可以随便的转换，必须要看NSString是什么格式的，然后再去写dateFormat，否则无效）

 */
-(void)test1{
     // 1.打印当前时间
     NSDate *date = [NSDate date];
     NSLog(@"当前时间%@",date);

     // 2.打印出2011-11-12 23：10：34这种格式
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
     NSString *dateStr = [dateFormatter stringFromDate:date];
     NSLog(@"字符串表示1:%@",dateStr);
     
     // 3.打印出2013年12月22日 12时34分56秒这个格式
     NSDateFormatter *dateFormaterA = [[NSDateFormatter alloc]init];
     [dateFormaterA setDateFormat:@"yyyy年MM年dd日 HH时mm分ss秒"];
     NSString *dateStrA = [dateFormaterA stringFromDate:date];
     NSLog(@"%@",dateStrA);
}



/**
 1.dateWithTimeIntervalSinceNow方法是当前时间开始，加上时间戳，然后的时间，因为通过[NSDate date]方法获取少了8小时，所以现在给加上去，获取的是NSDate类型的北京时间（注意，如果是获取NSString类型的，直接通过dateFormate就能转化好，不需要考虑8小时问题！！！）
 2.[tomorrowDate timeIntervalSinceDate:yesterdayDate]方法是获取两个NSDate类型的时间差值的

 */
- (void)test2{
    
    //1.获取当前时间 零时区的时间
    NSDate *date = [NSDate date];
    NSLog(@"当前零时区时间 %@", date);
    
    //2.获得本地时间 东八区 晚八个小时 以秒计时
    NSDate *date1 = [NSDate dateWithTimeIntervalSinceNow:8 * 60 * 60];
    NSLog(@"今天此时的时间 %@",date1);
    
    //3.昨天此时的时间
    NSDate *yesterdayDate = [NSDate dateWithTimeIntervalSinceNow:(-24 + 8) * 60 * 60];
    NSLog(@"昨天此时的时间 %@",yesterdayDate);
    
    //4.明天此刻
    NSDate *tomorrowDate = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:date1];
    NSLog(@"明天此刻的时间 %@",tomorrowDate);
    
    //5.NSTimeInterval 时间间隔(单位是秒),double 的 typedef
    
    //昨天此时与明天此刻的时间间隔
    NSTimeInterval timeInterval = [tomorrowDate timeIntervalSinceDate:yesterdayDate];
    NSLog(@"昨日和明天此刻的时间(秒) %.0f",timeInterval);
}

-(void)test3{
    NSDate *date = [NSDate date];
    NSTimeInterval timeIn = [date timeIntervalSince1970];
    NSLog(@"1970年1月1日0时0分0秒至今相差 %.0f 秒", timeIn);
}

/**
 向nil发送消息
     在Objective-C中向nil发送消息是完全有效的——只是在运行时不会有任何作用。Cocoa中的几种模式就利用到了这一点。发向nil的消息的返回值也可以是有效的:
     • 如果一个方法返回值是一个对象，那么发送给nil的消息将返回0(nil)。例如：Person * motherInlaw = [ aPerson spouse] mother]; 如果spouse对象为nil，那么发送给nil的消息mother也将返回nil。
     • 如果方法返回值为指针类型，其指针大小为小于或者等于sizeof(void*)，float，double，long double 或者long long的整型标量，发送给nil的消息将返回0。
     • 如果方法返回值为结构体，正如在《Mac OS X ABI 函数调用指南》，发送给nil的消息将返回0。结构体中各个字段的值将都是0。其他的结构体数据类型将不是用0填充的。
     • 如果方法的返回值不是上述提到的几种情况，那么发送给nil的消息的返回值将是未定义的。
     
 */
-(void)btn_clicked1{
    NSLog(@"btn_clicked1 ");
    NBStu*stu = nil;
    [stu sysHello];
    
    NBLog(@"当前程序目录是：%@",@"123");
    NBLog(@"123");
}

-(void)btn_clicked2{
    NSLog(@"btn_clicked2 ");
    
    [NBLogUtil redirectNSLogToDucumentFile];
    NSLog(@"1111111111111");
}

-(void)btn_clicked3{
    NSLog(@"btn_clicked3 ");
    
    [NBLogUtil resetNSLog];
    NSLog(@"222222222222");
}

// 每间隔固定时间执行一次任务
-(void)btn_clicked4{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
 
    // 开始时间
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC);
 
    // 间隔时间
    uint64_t interval = 2.0 * NSEC_PER_SEC;
 
    dispatch_source_set_timer(self.timer, start, interval, 0);
 
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"---- self.timer ---");
    });
 
    // 启动timer
    dispatch_resume(self.timer);
}

-(void)btn_clicked5{
    NBMYUIViewViewController *cv = [[NBMYUIViewViewController alloc]init];
    UINavigationController* u_cv = [[UINavigationController alloc]initWithRootViewController:cv];
    u_cv.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:u_cv animated:YES completion:nil];
}

@end
