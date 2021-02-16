#import "Test2Demo1ViewController.h"

/**
 frame 能修改位置和大小
 center 能修改位置
 bounds 能修改大小
 */
@interface Test2Demo1ViewController ()

@property(nonatomic,strong)UITextField*tv1;

@property(nonatomic,strong)UITextField*tv2;

@property(nonatomic,strong)UILabel*res;

@property(nonatomic,strong)UIButton*add;

@property(nonatomic,strong)UIButton*btn_move;

@end

@implementation Test2Demo1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.view 是有controller管理的
    
    [self initTitle];
    [self initView];
    [self printViewInfo];
    // self.view.bounds
    
}
-(void)printViewInfo{
    CGFloat origin_x = self.add.frame.origin.x;
    CGFloat origin_y = self.add.frame.origin.y;
    NSLog(@"origin_x: %f,origin_y: %f",origin_x,origin_y);
    CGFloat width = self.add.frame.size.width;
    CGFloat height = self.add.frame.size.height;
    NSLog(@"width: %f,height: %f",width,height);
    
    CGFloat center_x = self.add.center.x;
    CGFloat center_y = self.add.center.y;
    NSLog(@"center_x: %f,center_y: %f",center_x,center_y);
}
-(void)initView{
    NSLog(@"initView ......");
    
    self.tv1 = [self.view viewWithTag:1];
    self.tv2 = [self.view viewWithTag:2];
    
    self.res = [self.view viewWithTag:3];
    self.add = [self.view viewWithTag:4];
    
    [self.add addTarget:self action:@selector(add_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.add setTitle:@"点击了" forState:UIControlStateHighlighted];
    
    self.btn_move = [self.view viewWithTag:5];
    [self.btn_move addTarget:self action:@selector(btn_move_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.add setBackgroundColor:[UIColor blueColor]];
}

-(void)btn_move_clicked{
    NSLog(@"btn_move_clicked ......");
    [UIView animateWithDuration:2 animations:^{
        self.add.frame = CGRectMake(self.btn_move.frame.origin.x, self.btn_move.frame.origin.y + 10, self.btn_move.frame.size.width, self.btn_move.frame.size.height);
    }];
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
    NSLog(@"initTitle ......");
    
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

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappear ......");
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"viewDidDisappear ......");
}

/**
 动画方式一
 */
-(void)test_x{
    
    [UIView beginAnimations:nil context:nil];
    // 动画 TODO
    // ......
    // 动画时间
    [UIView setAnimationDuration:1];
    // 提交动画
    [UIView commitAnimations];
}

/**
 动画方式二
 */
-(void)test_x1{
    [UIView animateWithDuration:1 animations:^{
        // TODO
    }completion:^(BOOL finished) {
        // TODO
    }];
}

- (void)didReceiveMemoryWarning{
    NSLog(@"didReceiveMemoryWarning ......");
}

@end
