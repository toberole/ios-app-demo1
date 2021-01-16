#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DateUtil : NSObject

+ (NSDate *)toDate:(NSString *)datetimeString;

+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSDate *)getDateFormString:(NSString *)str;

+ (NSDate *)getDateFormStringWithTimeZone:(NSString *)str;

+ (NSString *)getRelativeDate:(NSDate *)date;

+ (NSString *)getStringFromDate:(NSDate *)date;

+ (NSDate *)getFirstTimeOfYear:(int)year;

+ (NSCalendar *)gregorian;

@end

NS_ASSUME_NONNULL_END
