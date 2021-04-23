#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"table_bar" owner:self options:nil];
    
    NSLog(@"views count: %lu",[arr count]);
    
    UIView*v0 =arr[0];
    CGRect r = CGRectMake(0, 100, 100, 100);
    v0.frame = r;
    [self.view addSubview:arr[0]];
    
    // [self test];
}

-(void)test{
    dispatch_queue_t q0 =  dispatch_queue_create("hello", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t q1 = dispatch_queue_create("hello1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t q2 = dispatch_get_main_queue();
    
    dispatch_queue_t q3 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    
    NSArray<__kindof UIWindow *> *windows = [UIApplication sharedApplication].windows;
    
    NSThread *th;
}


@end
