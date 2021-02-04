#import "LifeCycleViewController.h"

@interface LifeCycleViewController ()

@end

@implementation LifeCycleViewController

- (void)loadView{
    NSLog(@"loadView ......");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad ......");
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"viewWillAppear ......");
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear ......");
}

- (void)viewWillLayoutSubviews{
    NSLog(@"viewWillLayoutSubviews ......");
}

- (void)viewDidLayoutSubviews{
    NSLog(@"viewDidLayoutSubviews ......");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear ......");
}

@end
