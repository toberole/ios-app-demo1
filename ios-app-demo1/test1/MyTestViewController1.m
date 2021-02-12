#import "MyTestViewController1.h"

@interface MyTestViewController1 ()

@property(nonatomic,strong)UIButton*test1;

@property(nonatomic,strong)UIButton*test2;

@property(nonatomic,strong)UIButton*test3;

@property(nonatomic,strong)UIButton*test4;

@property(nonatomic,strong)UIView*v;

@property(nonatomic,assign)BOOL swi;

@end

@implementation MyTestViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.test1 = [self.view viewWithTag:1];
    [self.test1 addTarget:self action:@selector(test1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.test2 = [self.view viewWithTag:2];
    [self.test2 addTarget:self action:@selector(test2_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.test3 = [self.view viewWithTag:3];
    [self.test3 addTarget:self action:@selector(test3_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.test4 = [self.view viewWithTag:4];
    [self.test4 addTarget:self action:@selector(test4_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)test1_clicked{
    NSLog(@"test1_clicked ......");
    
    CGRect r = [UIScreen mainScreen].bounds;
    NSString*s = NSStringFromCGRect(r);
    NSLog(@"UIScreen: %@",s);
    
    CGFloat x = r.origin.x;
    CGFloat y = r.origin.y;
    CGFloat h = r.size.height;
    CGFloat w = r.size.width;
    NSLog(@"x: %f,y: %f,h: %f,w: %f",x,y,h,w);
    
    CGFloat v_h = 200;
    self.v = [[UIView alloc]init];
    [self.v setBackgroundColor:[UIColor blueColor]];
    self.v.frame = CGRectMake(0, h, w, v_h);
    [self.view addSubview:self.v];
    [UIView animateWithDuration:2 animations:^{
        self.v.frame = CGRectMake(0, h - v_h, w, v_h);
    } completion:^(BOOL finished) {
        NSLog(@"test1_clicked finished: %d",finished);
    }];
}

-(void)test2_clicked{
    CGRect r = [UIScreen mainScreen].bounds;
    NSString*s = NSStringFromCGRect(r);
    NSLog(@"UIScreen: %@",s);
    
    CGFloat x = r.origin.x;
    CGFloat y = r.origin.y;
    CGFloat h = r.size.height;
    CGFloat w = r.size.width;
    NSLog(@"x = %f,y = %f,h = %f,w = %f");
    
    [UIView animateWithDuration:2 animations:^{
        self.v.frame = CGRectMake(0, h,w, 200);
    }completion:^(BOOL finished) {
        NSLog(@"test2_clicked finished ......");
    }];
}
- (IBAction)test_btn_c:(UIButton *)sender forEvent:(UIEvent *)event {
}

-(void)test3_clicked{
    NSLog(@"test3_clicked ......");
    
    // app尺寸，去掉状态栏
    CGRect r = [UIScreen mainScreen ].applicationFrame;
    NSLog(@"app尺寸，去掉状态栏: %@",NSStringFromCGRect(r));
    
    // 屏幕尺寸
    CGRect rx = [UIScreen mainScreen ].bounds;
    NSLog(@"屏幕尺寸: %@",NSStringFromCGRect(rx));
    
    
    // 状态栏尺寸
    CGRect rect; rect = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"状态栏尺寸: %@",NSStringFromCGRect(rect));
}

-(void)test4_clicked{
    NSLog(@"test4_clicked ......");
}

@end
