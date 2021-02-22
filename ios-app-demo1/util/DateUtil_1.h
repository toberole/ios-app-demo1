#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtil_1 : NSObject
/**
 *  将0时区的时间转成0时区的时间戳(10位数)
 */
+ (NSString *)transformToTimestampWithDate:(NSDate *)date;

/**
 *  将0时区的时间戳(10位数)转成0时区的时间
 */
+ (NSDate *)transformToDateWithTimestamp:(NSString *)timestamp;

/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithTimestamp:(NSString *)timestamp;

/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（“2012-12-12 12：12”）,带有只有时分的
 */
+ (NSString *)transformToHourMiniteFormatWithTimestamp:(NSString *)timestamp;

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的时间戳(10位数)
 */
+ (NSString *)transformToTimestampWithString:(NSString *)string;

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的NSDate
 */
+ (NSDate *)transformToDateWithString:(NSString *)string;

/**
 *  将0时区的NSDate转成 8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
