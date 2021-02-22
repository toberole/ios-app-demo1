#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define NB_TAG "NBLOGMSG"

#define NB_separator "*************************************"

#define NBLog(fmt, ...) if([NBLogUtil is_debug]){NSLog((@"%s\n" "[TAG:%s]\n" "[fileName:%s]\n" "[funcName:%s]\n" "[line:%d]\n" fmt), NB_separator,NB_TAG,__FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);}

@interface NBLogUtil : NSObject

+(BOOL)is_debug;

+(void)enableDebug:(BOOL)b;

+(void)redirectNSLogToDucumentFile;

+(void)resetNSLog;

@end

NS_ASSUME_NONNULL_END
