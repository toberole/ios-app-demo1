#import "NBLogUtil.h"

// STDIN_FILENO    0    /* standard input file descriptor */
// STDOUT_FILENO   1    /* standard output file descriptor */
// STDERR_FILENO   2    /* standard error file descriptor */

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

@end
