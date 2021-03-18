#import "NBCPPViewController.h"
#import "NBCppBaseDemo.hpp"

@interface NBCPPViewController ()

@end

@implementation NBCPPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton*test1 = [self.view viewWithTag:1];
    [test1 addTarget:self action:@selector(btn_test1_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btn_test1_clicked{
    cppBaseDemo_test1();
}

@end
