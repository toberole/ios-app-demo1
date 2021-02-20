#import "NBTransformDemo5ViewController.h"
#import "NBPerson.h"

/**
 Transform可以做 平移 旋转 缩放
 */
@interface NBTransformDemo5ViewController ()

@property(nonatomic,strong)UIView*v;

@property(nonatomic,strong)UIButton*btn;

@property(nonatomic,strong)UIButton*btn3;

@property(nonatomic,strong)UIButton*btn4;

@end

@implementation NBTransformDemo5ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.v = [self.view viewWithTag:1];
    self.btn = [self.view viewWithTag:2];
    
    [self.btn addTarget:self action:@selector(btn_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn3 = [self.view viewWithTag:3];
    [self.btn3 addTarget:self action:@selector(btn3_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn4 = [self.view viewWithTag:4];
    [self.btn4 addTarget:self action:@selector(btn4_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    NBPerson*p = [[NBPerson alloc]init];
    NSDictionary *dic = [[NSDictionary alloc]init];
    [dic setValue:@"xiaohong" forKey:@"name"];
    [dic setValue:[[NSNumber alloc]initWithInt:1]  forKey:@"age"];
    [p setValuesForKeysWithDictionary:dic];

//    UIImageView*iv;
//    类似android的帧动画
//    iv.animationImages
    
//    [UIImage imageWithContentsOfFile:@""];
    
    
}

#pragma mark 平移
-(void)btn_clicked{
    NSLog(@"btn_clicked ......");
    CGAffineTransform t = CGAffineTransformMakeTranslation(0, 100);
    [UIView animateWithDuration:2 animations:^{
        self.v.transform = t;
    }];
}

#pragma mark 旋转
-(void)btn3_clicked{
    NSLog(@"btn3_clicked ......");
    CGAffineTransform t = CGAffineTransformMakeRotation(100);
    self.v.transform = t;
}

#pragma mark 缩放
-(void)btn4_clicked{
    NSLog(@"btn4_clicked ......");
//    CGAffineTransform t = CGAffineTransformMakeScale(1.5, 1.5);
//    self.v.transform = t;
    
     CGAffineTransform t = CGAffineTransformScale(self.v.transform, 1.2, 1.2);
    self.v.transform = t;
}
@end
