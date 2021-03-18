#import "NBLogUtil.h"

// STDIN_FILENO    0    /* standard input file descriptor */
// STDOUT_FILENO   1    /* standard output file descriptor */
// STDERR_FILENO   2    /* standard error file descriptor */
/**
 NSLog ----> STDERR_FILENO
 
 printf对应标准输出stdout
 NSLog对应标准错误stderr
 
 */
/**
 int  dup(int fd);
 int dup2(int fd, int fd 2);
 
 dup会返回一个新的描述符，这个描述一定是当前可用文件描述符中的最小值
 
 dup2，可以用fd2指定新描述符的值，如果fd2本身已经打开了，则会先将其关闭。如果fd等于fd2，则返回fd2，并不关闭它。
 */

static int NBLogUtil_fd = STDERR_FILENO;

static BOOL nb_debug = YES;

@implementation NBLogUtil

+(BOOL)is_debug{
    return nb_debug;
}

+ (void)enableDebug:(BOOL)b{
    nb_debug = b;
}

+ (void)redirectNSLogToDocumentFolder
{
    //如果已经连接Xcode调试则不输出到文件
//    if(isatty(STDOUT_FILENO)) {
//        return;
//    }
    
//    UIDevice *device = [UIDevice currentDevice];
//    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
//        return;
//    }
    
    //获取Document目录下的Log文件夹，若没有则新建
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.txt",dateStr];
    
    // freopen 重定向输出输出流，将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}


+ (void)redirectNSLogToDucumentFile{
    //创建文件路径
    NSString *documentpath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    NSString *fileName = [NSString stringWithFormat:@"%@.log",dateStr];
    
    NSString *logFilePath = [documentpath stringByAppendingPathComponent:fileName];
    
    // 删除已经存在文件
    NSLog(@"logFilePath---> %@",logFilePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager removeItemAtPath:logFilePath error:nil];
    
    NBLogUtil_fd = dup(STDERR_FILENO);
    NSLog(@"NBLogUtil_fd---> %d",NBLogUtil_fd);
    
    // 使用标准C的freopen将stderr重定向到我们的文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}

+ (void)resetNSLog{
    if (STDERR_FILENO == NBLogUtil_fd)return;
    
    /**
     要想重定向回去, 需要知道stderr原来的文件路径, 这个在不同平台中是不一样的,在iOS平台,由于沙盒机制, 并不能直接使用沙盒外的文件 对此,freopen将无能为力,要重定向回去,只能使用Unix的方法dup和dup2
     */
    dup2(NBLogUtil_fd, STDERR_FILENO);
    
    NSLog(@"resetNSLog ......");
}

// NSTimer受runloop的影响，由于runloop需要处理很多任务，导致NSTimer的精度降低
// dispatch_source_t 定时任务 精度很高，系统自动触发，系统级别的源
- (dispatch_source_t)_startCapturingWritingToFD:(int)fd  {
    int fildes[2];
    pipe(fildes);  // [0] is read end of pipe while [1] is write end
    dup2(fildes[1], fd);  // Duplicate write end of pipe "onto" fd (this closes fd)
    close(fildes[1]);  // Close original write end of pipe
    fd = fildes[0];  // We can now monitor the read end of the pipe
    char* buffer = malloc(1024);
    NSMutableData* data = [[NSMutableData alloc] init];
    fcntl(fd, F_SETFL, O_NONBLOCK);
    dispatch_source_t source = dispatch_source_create(
                                                      DISPATCH_SOURCE_TYPE_READ, fd, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0));
    dispatch_source_set_cancel_handler(source, ^{
        free(buffer);
    });
    dispatch_source_set_event_handler(source, ^{
        @autoreleasepool {
            
            while (1) {
                ssize_t size = read(fd, buffer, 1024);
                if (size <= 0) {
                    break;
                }
                [data appendBytes:buffer length:size];
                if (size < 1024) {
                    break;
                }
            }
            NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //printf("aString = %s",[aString UTF8String]);
            //NSLog(@"aString = %@",aString);
            // Do something
        }
    });
    dispatch_resume(source);
    return source;
}

@end
