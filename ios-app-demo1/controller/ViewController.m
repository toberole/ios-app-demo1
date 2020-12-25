#import "ViewController.h"
#import "FileViewController.h"


@interface ViewController ()

@property (nonatomic,strong)UIButton*btn_file_op;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_file_op = [self.view viewWithTag:1];
    [self.btn_file_op addTarget:self action:@selector(btn_file_op_clicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btn_file_op_clicked{
    NSLog(@"btn_file_op_clicked ......");
    
    FileViewController *fileViewController = [[FileViewController alloc]init];
    [self.navigationController pushViewController:fileViewController animated:YES];
}

@end
