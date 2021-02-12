#import "GCDDemoViewController.h"
#import "SGUIView+Toast.h"

@interface GCDDemoViewController ()

@property(nonatomic,strong)UIButton*btn1;
@property(nonatomic,strong)UIButton*btn2;
@property(nonatomic,strong)UIButton*btn3;
@property(nonatomic,strong)UIButton*btn4;
@property(nonatomic,strong)UISegmentedControl*segmentedControl;
@end

@implementation GCDDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btn1 = [self.view viewWithTag:1];
    self.btn2 = [self.view viewWithTag:2];
    self.btn3 = [self.view viewWithTag:3];
    self.btn4 = [self.view viewWithTag:4];
    
    [self.btn1 addTarget:self action:@selector(btn1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn2 addTarget:self action:@selector(btn2_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn3 addTarget:self action:@selector(btn3_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.segmentedControl = [self.view viewWithTag:5];
    [self.segmentedControl addTarget:self action:@selector(segmentedControl_op) forControlEvents:UIControlEventValueChanged];
}

// dispatch_get_main_queue
-(void)btn1_clicked{
    dispatch_queue_t main_q =  dispatch_get_main_queue();
    
    dispatch_async(main_q, ^{
        NSLog(@"test1 ......");
        
        [NSThread sleepForTimeInterval:0.06];
        
        [self.view makeToast:@"test1"];
    });
    
    dispatch_async(main_q, ^{
        NSLog(@"test2 ......");
        [self.view makeToast:@"test2"];
    });
    
    dispatch_async(main_q, ^{
        NSLog(@"test3 ......");
        [self.view makeToast:@"test3"];
    });
}

// dispatch_get_global_queue
-(void)btn2_clicked{
    dispatch_queue_t g_q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(g_q, ^{
        NSLog(@"dispatch_sync 1 ......");
    });
    dispatch_sync(g_q, ^{
        NSLog(@"dispatch_sync 2 ......");
    });
    dispatch_sync(g_q, ^{
        NSLog(@"dispatch_sync 3 ......");
    });
    
    dispatch_async(g_q, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async 1 @@@@@@");
    });
    dispatch_async(g_q, ^{
        NSLog(@"dispatch_async 2 @@@@@@");
    });
    dispatch_async(g_q, ^{
        NSLog(@"dispatch_async 3 @@@@@@");
    });
}

-(void)btn3_clicked{
    dispatch_queue_t q = dispatch_queue_create("q", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(q, ^{
        NSLog(@"dispatch_sync 1 ......");
    });
    dispatch_sync(q, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_sync 2 ......");
    });
    dispatch_sync(q, ^{
        NSLog(@"dispatch_sync 3 ......");
    });
    
    dispatch_async(q, ^{
        NSLog(@"dispatch_async 1 @@@@@@");
    });
    dispatch_async(q, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async 2 @@@@@@");
    });
    dispatch_async(q, ^{
        NSLog(@"dispatch_async 3 @@@@@@");
    });
    
    
}

-(void)segmentedControl_op{
    NSInteger i = [self.segmentedControl selectedSegmentIndex];
    NSLog(@"i = %ld",(long)i);
}

@end
