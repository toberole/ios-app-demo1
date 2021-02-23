#import "NBMYUIViewViewController.h"
#import "NBView1.h"

@interface NBMYUIViewViewController ()

@property(nonatomic,strong)NBView1*v1;

@end

@implementation NBMYUIViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    CGRect frame = CGRectMake(0, 0, 200, 200);
    self.v1 = [[NBView1 alloc]initWithFrame:frame];
    NSArray*arr = @[@"hello1",@"hello2"];
    [self.v1 setLabelStrs:arr];
    
    [self.view addSubview:self.v1];
}



@end
