#import "Test2ViewController.h"
#import "Test3ViewController.h"


@interface Test2ViewController ()
@property(nonatomic,strong)UITextView*textView;
@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Test2ViewController#viewDidLoad ......");
    
    self.textView = [self.view viewWithTag:1];
    if ([self.textView isFirstResponder]) {
        NSLog(@"self.textView isFirstResponder");
    }
    
    [self.textView setText:@"Hello World!"];
    
    [self initTitleBar];
}

-(void)initTitleBar{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = @"Hello World!";
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(test_back)];
    navigationItem.leftBarButtonItem = barButtonItem;
    
    barButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStylePlain target:self action:@selector(test_next)];
    navigationItem.rightBarButtonItem = barButtonItem;
}

-(void)test_back{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)test_next{
    // Test3ViewController 中不设置titlebar
    // 默认会继承上一页面的titlebar
    // 会显示默认显示返回
    Test3ViewController *v = [[Test3ViewController alloc]init];
    [self.navigationController pushViewController:v animated:YES];
}




@end
