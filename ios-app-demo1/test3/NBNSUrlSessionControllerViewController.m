#import "NBNSUrlSessionControllerViewController.h"

@interface NBNSUrlSessionControllerViewController ()
@property(nonatomic,strong)UIButton*btn_test1;
@end

@implementation NBNSUrlSessionControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btn_test1 = [self.view viewWithTag:1];
    [self.btn_test1 addTarget:self action:@selector(btn_test1_clicked) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)btn_test1_clicked{
    NSLog(@"btn_test1_clicked ......");
    /**
    在WWDC2013中，Apple的团队对NSURLConnection进行了重构，并推出了NSURLSession作为替代。NSURLSession将NSURLConnection替换为NSURLSession和NSURLSessionConfiguration，
    以及3个NSURLSessionTask的子类：
        NSURLSessionDataTask
        NSURLSessionUploadTask
        NSURLSessionDownloadTask

     NSURLSession的使用有如下几步:
         第一步：创建NSURLSession对象
         第二步：使用NSURLSession对象创建Task
         第三步：启动任务
     
     
     */
    dispatch_queue_t q = dispatch_queue_create("test_q", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(q, ^{
        // 第一步 创建NSURLSession对象
        // 第一种方式 直接创建
        NSURLSession*session = [NSURLSession sharedSession];
        // 第二种方式 配置后创建
//        NSURLSessionConfiguration *defaultSessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession*session1 = [NSURLSession sessionWithConfiguration:defaultSessionConfiguration];
        // 第三种方式 设置+代理
        /**
         关于NSURLSession的配置有三种类型：

         //默认的配置会将缓存存储在磁盘上
         +(NSURLSessionConfiguration*)defaultSessionConfiguration;

         //瞬时会话模式不会创建持久性存储的缓存
         +(NSURLSessionConfiguration*)ephemeralSessionConfiguration;

         //后台会话模式允许程序在后台进行上传下载工作
         +(NSURLSessionConfiguration*)backgroundSessionConfigurationWithIdentifier:(NSString*)identifier
         */
//        NSURLSession *session2=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc]init]];

        // 第二步 使用NSURLSession对象创建Task
        //（1）NSURLSessionDataTask
        // 通过request对象或url创建
        // NSURLRequest*request = [[NSURLRequest alloc]init];
        NSURL*url = [NSURL URLWithString:@"https://www.baidu.com/"];
        
        NSMutableURLRequest*request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        // 设置header
        [request setValue:@"Accept-Charset" forHTTPHeaderField:@"utf-8"];
        
        NSURLSessionDataTask*task = [session dataTaskWithRequest:request];
        task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"data: %@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            
            
        }];
        
        [task resume];
    });
}

- (void)uploadTask{
    //配置会话属性
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建session对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    //创建mRequest请求
    NSString *urlString = @"https://api.weibo.com/2/statuses/update.json";
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSMutableURLRequest *mRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    //参数转换及设置方法体
    NSString *bodyString = [NSString stringWithFormat:@"access_token=2.00zMf9ND9ip3KCc14c03c2900L6tAc&status=%@",@"hello"];
    NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];

    [mRequest setHTTPMethod:@"POST"];
    [mRequest setHTTPBody:data];

    //创建uploadTask
    NSURLSessionTask *uploadTask = [session uploadTaskWithRequest:mRequest fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (!error) {

            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSLog(@"dictionary = %@",dictionary);
        }
    }];
    [uploadTask resume];
}


- (void)downloadTask {
    //设置会话属性
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //创建session对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    //创建下载任务downloadTask
    //文件默认下载到tmp文件夹，当下载完成时没有任何的处理会被删掉，所以在下载完成时把文件转移到另一个文件夹中
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://c.hiphotos.baidu.com/image/pic/item/023b5bb5c9ea15ce9c017233b1003af33a87b219.jpg"] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //拿到cashesPath路径(Library/cashes)
        NSString *cashesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        //建议使用的名字和服务器的一样
        NSString *fileName = response.suggestedFilename;
        NSString *filePath = [cashesPath stringByAppendingPathComponent:fileName];
        //移动文件，需要用到NSFileManager
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager moveItemAtPath:location.path toPath:filePath error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{

            NSData *data = [NSData dataWithContentsOfFile:filePath];
//            self.imgView.image = [UIImage imageWithData:data];
        });
    }];
    //启动任务
    [downloadTask resume];
    NSLog(@"下载");
}


//使用代理实现断点续传
- (void)downloadTask2{

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session =[NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    //创建下载任务
//    _downTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://b.zol-img.com.cn/desk/bizhi/image/7/2560x1600/145135666476.jpg"]];
//    //开启任务
   // [_downTask resume];

   // self.sessionDownload = session;

}

#pragma mark --NSURLSessionDownloadDelegate--
//数据下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];//objectAtIndex:0
    NSString *filePath = [cachePath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    //location 代表源地址
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager moveItemAtPath:location.path toPath:filePath error:nil];

}

/**
 *  每当下载完一部分数据就会走方法(不是必须要实现的方法)
 *
 *  @param session                   任务对象
 *  @param downloadTask              下载任务
 *  @param bytesWritten              本次写到文件里面的数据
 *  @param totalBytesWritten         已经写入到文件的数据
 *  @param totalBytesExpectedToWrite 文件总长度
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{

//    self.progressView.progress = (CGFloat)totalBytesWritten/totalBytesExpectedToWrite;
    //NSLog(@"%.2f",self.progressView.progress);
}


- (void)buttonAction:(UIButton *)sender {

}








@end
