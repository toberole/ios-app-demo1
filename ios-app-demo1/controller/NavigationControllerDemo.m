#import "NavigationControllerDemo.h"

@interface NavigationControllerDemo ()

@end

@implementation NavigationControllerDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"NavigationControllerDemo viewDidLoad .......");
    
    // 设置标题栏
    self.navigationItem.title = @"NavigationControllerDemo";
//    self.navigationItem.backBarButtonItem = [[UINavigationItem alloc]initWithTitle:@"ABC"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:nil action:nil];

}



- (void)dealloc
{
    NSLog(@"NavigationControllerDemo dealloc .......");
}

@end
