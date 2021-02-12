#import "UIDemo1ViewController.h"

@interface UIDemo1ViewController ()

@property (nonatomic,strong)UITextView*tv1;

@property (nonatomic,strong)UITextView*tv2;

@property (nonatomic,strong)UILabel*res;

@property (nonatomic,strong)UIButton*add;

@end

@implementation UIDemo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIDemo1ViewController";
    
    NSLog(@"UIDemo1ViewController ......");
    
    self.tv1 = [self.view viewWithTag:1];
    self.tv2 = [self.view viewWithTag:2];
    self.res = [self.view viewWithTag:3];
    self.add = [self.view viewWithTag:4];
    
    [self.add addTarget:self action:@selector(btn_add_clicked) forControlEvents:UIControlEventTouchUpInside];
}


-(void)btn_add_clicked{
    int a = [[self.tv1 text] intValue];
    NSLog(@"a: %d",a);
}

@end
