#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property int age;

@property NSString*name;

@property NSDictionary*dictionary;

@property NSMutableDictionary*mutableDictionary;

-(instancetype)initWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
