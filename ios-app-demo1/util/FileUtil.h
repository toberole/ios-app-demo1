#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileUtil : NSObject

+(void)readDataFromFile:(NSString*)path bufLen:(long)buflen block:(void(^)(long len,NSData*data))callback;

+(void)readDataToBuffer:(char *)buffer fromPath:(NSString *)path;

+(void)writeDataToEnd:(NSData *)data toPath:(NSString *)path;

+ (NSString *)cachePathForFileName:(NSString *)fileName;

+ (NSString *)documentsPathForFileName:(NSString *)fileName;

+ (BOOL)fileExists:(NSString *)fileFullName;

+ (BOOL)removeFile:(NSString *)fileFullName;

+ (void)copyFile:(NSString *)fromFile toFile:(NSString *)toFile;

+ (void)createDirectory:(NSString *)filePath;

+ (void)createFileAtPath:(NSString *)fileName data:(NSData *)data;

+ (BOOL)appendToFile:(NSString *)path data:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
