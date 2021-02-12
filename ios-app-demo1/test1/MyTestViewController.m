#import "MyTestViewController.h"
#import "GCDHelper.h"

@interface MyTestViewController ()

@property(nonatomic,strong)UIButton*btn;

@end

@implementation MyTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // %02d 两位显示数据 不足两位使用0补齐
    NSString*s = [[NSString alloc]initWithFormat:@"test %02d",1];
    NSLog(@"s: %@",s);
    
    self.btn = [self.view viewWithTag:1];
    [self.btn addTarget:self action:@selector(btn1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray*arr = @[@"Hello",@"World"];
    NSLog(@"arr len: %lu",(unsigned long)[arr count]);
    
    [[GCDHelper shareInstance] dispatchAsync:^{
        NSLog(@"1 ......");
    } serial:YES];
    
    [[GCDHelper shareInstance] dispatchAsync:^{
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"2 ......");
    } serial:YES];
    
    [[GCDHelper shareInstance] dispatchAsync:^{
        NSLog(@"3 ......");
    } serial:YES];
    
    
}

-(void)btn1_clicked{
    NSLog(@"btn1 clicked self.view %@......",self.view);
    
    UIView*v  = [[UIView alloc]initWithFrame:CGRectMake(0,0, 100, 500)];
    [v setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:v];
    
    [self.btn setBackgroundImage:[UIImage imageNamed:@"test.png"] forState:UIControlStateNormal];
    [self.btn setTitle:@"abc ......" forState:UIControlStateHighlighted];
}

// 动画
-(void)test1{
    [UIView animateWithDuration:1.0 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}

@end
