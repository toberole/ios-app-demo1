#import "NBStatusBarDemoViewController.h"

@interface NBStatusBarDemoViewController ()

@end

@implementation NBStatusBarDemoViewController

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton*btn = [[UIButton alloc]init];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    NSLog(@"NBStatusBarDemoViewController#viewDidLoad ......");
    // [self testThread];
}

-(void)testThread{
    BOOL b = [NSThread isMainThread];
    NSLog(@"isMainThread: %d",b);
    NSThread *currentThread = [NSThread currentThread];
    NSLog(@"currentThread: %@",currentThread);
    NSThread *mainThread = [NSThread mainThread];
    NSLog(@"mainThread: %@",mainThread);
    
    [NSThread sleepForTimeInterval:10];
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSince1970:1000]];
    
    // [NSThread exit];
    NSThread *t = [[NSThread alloc]init];
}

@end
