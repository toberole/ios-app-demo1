#import "Test1ViewController.h"

@interface Test1ViewController ()
@property(nonatomic,strong)UIButton*btn;
@property(nonatomic,strong)UITextField*textFiled;
@property(nonatomic,strong)UITextView*textView;
@end

@implementation Test1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.title = @"abc";
    self.title = @"efg";
    
    // [self setMyNavigationItem];
    
    self.textFiled = [self.view viewWithTag:2];
    [self.textFiled setDelegate:self];
    // textFiled 默认调起键盘输入
    if ([self.textFiled canBecomeFirstResponder])
    {
        [self.textFiled becomeFirstResponder];
    }
    
    self.textView = [self.view viewWithTag:3];
    [self.textView setDelegate:self];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (![self.textView isExclusiveTouch]) {
        [self.textView resignFirstResponder];
    }
}

-(void)test1{
    NSLog(@"test ......%@",self.navigationController);
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)test2{
    NSLog(@"test ......%@",self.navigationController);
    Test1ViewController *v = [[Test1ViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}
//test2#btn_clicked
//pushViewController 对应 popViewControllerAnimated
-(void)btn_clicked{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setMyNavigationItem{
    self.btn = [self.view viewWithTag:1];
    [self.btn addTarget:self action:@selector(btn_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(test1)];
    [item setWidth:100.0f];
    //    [item setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal barMetrics:nil];
    self.navigationItem.leftBarButtonItem = item;
    
    //    自定义leftBarButtonItem#customView
    //    UIView*customView = [[UIView alloc]initWithFrame:CGRectMake(0,0, 30, 30)];
    //    UIColor *testColor1= [UIColor colorWithRed:255.0/255.0 green:0.0 blue:0.0 alpha:1];
    //    [customView setBackgroundColor:testColor1];
    //    self.navigationItem.leftBarButtonItem.customView = customView;
    //    self.navigationItem.leftBarButtonItem.customView.hidden = NO;
    
    
    item = [[UIBarButtonItem alloc]initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(test2)];
    [item setWidth:100.0f];
    self.navigationItem.rightBarButtonItem = item;
    
}

@end
