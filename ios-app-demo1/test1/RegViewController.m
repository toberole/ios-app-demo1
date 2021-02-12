#import "RegViewController.h"

@interface RegViewController ()

@property(nonatomic,strong)UIButton*btn_login;

@property(nonatomic,strong)UITextField*tv_name;
@property(nonatomic,strong)UITextField*tv_pwd;
@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test_xib];
    
    self.btn_login = [self.view viewWithTag:1];
    [self.btn_login addTarget:self action:@selector(btn_login_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.tv_name = [self.view viewWithTag:2];
    self.tv_pwd = [self.view viewWithTag:3];
}

-(void)btn_login_clicked{
    NSLog(@"btn_login_clicked ......");
    
    NSLog(@"btn_login_clicked name: %@",self.tv_name.text);
    NSLog(@"btn_login_clicked pwd: %@",self.tv_pwd.text);
}

-(void)test_xib{
    NSArray * arr = [[NSBundle mainBundle]loadNibNamed:@"test1" owner:nil options:nil];
    if (arr) {
        NSLog(@"arr count: %lu",(unsigned long)[arr count]);
        unsigned int n = [arr count];
        for (int i = 0; i<n; i++) {
            UIView*v = (UIView*)[arr objectAtIndex:i];
            NSLog(@"subviews count: %lu",(unsigned long)[[v subviews]count]);
        }
    }else{
        NSLog(@"load test1.xib fail ......");
    }
}

@end
