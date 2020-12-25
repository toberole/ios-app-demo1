#import "FileViewController.h"

@interface FileViewController ()

@property (nonatomic,strong)UIButton*btn_test1;

@property (nonatomic,strong)UIButton*btn_test2;

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_test1 = [self.view viewWithTag:1];
    [self.btn_test1 addTarget:self action:@selector(btn_test1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.btn_test2 = [self.view viewWithTag:2];
    [self.btn_test2 addTarget:self action:@selector(btn_test2_clicked) forControlEvents:UIControlEventTouchUpInside];
}

/**
 1. 什么是沙盒
 沙盒：iOS应用程序只能在系统为该程序创建的文件系统中读取文件，不可以区其他地方访问，此区域被称为沙盒。一般情况下，所有非代码文件都要保存在此，例如：图像，图标，声音，影像，属性列表，文本文件等。
 2. 沙盒的特点
 每个应用程序都有自己独立的沙盒。
 应用程序无法访问其他应用程序的沙盒。
 应用程序请求的数据都要通过权限检测，假如不符合条件的话，不会放行。
 3. 沙盒里面的文件夹
 1. DOcuments:苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录。
 2. Library/Preferences: 存储程序的默认设置或者其他状态信息。
 3. Library/Caches: 存放缓存文件，iTunes不会备份此目录，次目录下的文件不会在应用退出后删除。
 4. tmp: 提供一个即时创建临时文件的地方。
 */
-(void)btn_test1_clicked{
    //获取沙盒的路径(用户根目录)
    NSString *homeDir = NSHomeDirectory();
    NSLog(@"homeDir: %@",homeDir);
    //获取临时文件路径（tmp）
    NSString *tempDir = NSTemporaryDirectory();
    NSLog(@"tempDir: %@", tempDir);
    //获取Documents路径方式一
    NSString *documentsDir = [homeDir stringByAppendingString:@"/Documents"];
    NSLog(@"documentsDir: %@", documentsDir);
    //获取Documents路径的方式二
    NSString *documentsDir2 = [homeDir stringByAppendingPathComponent:@"Documents"];
    NSLog(@"documentsDir2: %@",documentsDir2);
    //获取Documents路径的方式三(IOS环境一下一般只有一个元素)
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", array[0]);
}

-(void)btn_test2_clicked{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 访问【沙盒的document】目录下的问题件，该目录下支持手动增加、修改、删除文件及目录
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/test.txt"];
    
    NSLog(@"filePath: %@",filePath);
    
    // 如果不存在
    if(![fileManager fileExistsAtPath:filePath])  {
        NSLog(@"文件不存在......");
    }else{
        NSLog(@"文件存在......");
    }
}

@end
