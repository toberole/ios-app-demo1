#import "NBLayoutConstraintViewController.h"
#import "Student.h"
#import "Student+NBTestCategory.h"
@interface NBLayoutConstraintViewController ()
@property(nonatomic,strong)UIView*redView;
@end

/**
 
 NSLayoutConstraint
 + (id)constraintWithItem:attribute:relatedBy:toItem: attribute:multiplier:constant:

 参数说明：
     WithItem:要约束的对象
     attribute:对象的布局属性
     relatedBy:布局关系
     toItem:参照对象
     attribute:参照对象的布局属性
     multiplier:乘数
     constant:常数

 自动布局的核心公式
 Object1.property1 =（object2.property2 * multiplier）+ constant value

 
 */
@implementation NBLayoutConstraintViewController

-(void)test1{
    Student*stu = [[Student alloc]init];
    [stu sysStuName];
    
    struct timespec ts;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.redView = [self.view viewWithTag:1];
    
    // 利用NSLayoutConstraint代码添加约束:
    //首先禁止autoresizing
//    self.redView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:redView];
    
    // 2.约束蓝色
    // 2.1.高度
//    NSLayoutConstraint *blueHeight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40];
//    [blueView addConstraint:blueHeight];
    // 2.2.左边间距
//    CGFloat margin = 20;
//    NSLayoutConstraint *blueLeft = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
//    [self.view addConstraint:blueLeft];
    // 2.3.顶部间距
//    NSLayoutConstraint *blueTop = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
//    [self.view addConstraint:blueTop];
    // 2.4.右边间距
//    NSLayoutConstraint *blueRight = [NSLayoutConstraint constraintWithItem:blueView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
//    [self.view addConstraint:blueRight];
    
    // 3.约束红色
    // 3.1.让红色右边 == 蓝色右边
//    NSLayoutConstraint *redRight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];
//    [self.view addConstraint:redRight];
//
    // 3.2.让红色高度 == 蓝色高度
//    NSLayoutConstraint *redHeight = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
//    [self.view addConstraint:redHeight];
//
    // 3.3.让红色顶部 == 蓝色底部 + 间距
//    NSLayoutConstraint *redTop = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:margin];
//    [self.view addConstraint:redTop];
    
    // 3.4.让红色宽度 == 蓝色宽度 * 0.5
//    NSLayoutConstraint *redWidth = [NSLayoutConstraint constraintWithItem:redView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blueView attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0.0];
//    [self.view addConstraint:redWidth];
 
}

@end
