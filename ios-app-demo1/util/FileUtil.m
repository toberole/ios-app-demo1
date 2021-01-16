#import "FileUtil.h"
#include <stdio.h>

@implementation FileUtil

+(void)readDataFromFile:(NSString*)path bufLen:(long)buflen block:(void(^)(long len,NSData*data))callback{
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    
    NSInteger count = 0;
    NSInteger dataLength = buflen;
    NSData *data = nil;
    
    while (YES) {
        [fileHandle seekToFileOffset:count*dataLength];
        data = [fileHandle readDataOfLength:dataLength];
        
        if (!data||[data length] <= 0) {
            break;
        }
        
        callback([data length],data);
        
        count++;
    }
    
    [fileHandle closeFile];
    
    callback(0,nil);
}

/*
 * ===  FUNCTION  ==================================================
 *         Name:  readDataToBuffer:fromPath:
 *  Description:  从指定 path 的文件读取内容到 buffer
 * =================================================================
 */
+(void)readDataToBuffer:(char *)buffer fromPath:(NSString *)path
{
    FILE *p_r= fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "r");  //打开文件
    if (NULL == p_r)
    {
        NSLog(@"Open file error to read data !");
        return ;
    }
    
    fseek(p_r, 0, SEEK_END);                //定位到文件末尾
    NSInteger dataLength = ftell(p_r);       //获取文件长度
    fseek(p_r, 0, SEEK_SET);                //定位到文件起始位置
    fread(buffer, dataLength, 1, p_r);     //读取文件到指定的缓冲区
    fclose(p_r);                           //关闭文件
}

/*
 * ===  FUNCTION  ==================================================
 *         Name:  writeData:toPath:
 *  Description:  把数据写到指定的文件中
 * =================================================================
 */
+(void)writeDataToEnd:(NSData *)data toPath:(NSString *)path
{
    FILE *p_w= fopen([path cStringUsingEncoding:NSUTF8StringEncoding], "ab");  //已追加二进制方式打开文件
    if (NULL == p_w)
    {
        NSLog(@"Open file error to write data!");
        return ;
    }
    fseek(p_w, 0, SEEK_END);                                // 移到文件末尾
    fwrite((void *)[data bytes], data.length, 1, p_w);       // 写入数据
    data = nil;
    fclose(p_w);                                           //关闭文件
}

+ (NSString *)cachePathForFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:fileName];
}

+ (NSString *)documentsPathForFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    return [documentsPath stringByAppendingPathComponent:fileName];
}

+ (BOOL)fileExists:(NSString *)fileFullName {
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fileFullName];
}

+ (BOOL)removeFile:(NSString *)fileFullName {
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fileFullName] && [file_manager removeItemAtPath:fileFullName error:nil];
}

+ (void)copyFile:(NSString *)fromFile toFile:(NSString *)toFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    if ([fileManager fileExistsAtPath:fromFile] == YES) {
        [fileManager copyItemAtPath:fromFile toPath:toFile error:&error];
    }
}

+ (void)createDirectory:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:filePath];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (void)createFileAtPath:(NSString *)fileName data:(NSData *)data {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:fileName contents:data attributes:nil];
}

+ (BOOL)appendToFile:(NSString *)path data:(NSData *)data{
    if (data == nil) return NO;
    
    NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path];
    if (fh == nil)
        return [data writeToFile:path atomically:YES];
    
    [fh truncateFileAtOffset:[fh seekToEndOfFile]];
    [fh writeData:data];
    [fh closeFile];
    return YES;
}
@end
