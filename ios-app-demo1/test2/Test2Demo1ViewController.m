#import "Test2Demo1ViewController.h"

@interface Test2Demo1ViewController ()

@property(nonatomic,strong)UITextField*tv1;

@property(nonatomic,strong)UITextField*tv2;

@property(nonatomic,strong)UILabel*res;

@property(nonatomic,strong)UIButton*add;

@end

@implementation Test2Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitle];
    
    self.tv1 = [self.view viewWithTag:1];
    self.tv2 = [self.view viewWithTag:2];
    
    self.res = [self.view viewWithTag:3];
    self.add = [self.view viewWithTag:4];
    
    [self.add addTarget:self action:@selector(add_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)add_clicked{
    [self.tv1.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\r\n "]];
    
    int a = [self.tv1.text intValue];
    int b = [self.tv2.text intValue];
    
    int c = a+b;
    self.res.text = [[NSString alloc]initWithFormat:@"%d",c];
    
    // 关闭键盘 方法1 调起键盘的View 辞去FirstResponder，resignFirstResponder
//    [self.tv1 resignFirstResponder];
//    [self.tv2 resignFirstResponder];
    
    // 关闭键盘 方法二 view停止编辑 由该view及其子view调出的键盘都会被关闭
    [self.view endEditing:YES];
}

-(void)initTitle{
    self.title = @"Test2Demo1ViewController";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"Hello" style:UIBarButtonItemStylePlain target:self action:@selector(test_leftBarButtonItem)];
    self.navigationItem.leftBarButtonItem = item;
}

-(void)test_leftBarButtonItem{
    NSLog(@"test_leftBarButtonItem ......");
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"dismissViewControllerAnimated  completion ......");
    }];
}

@end
