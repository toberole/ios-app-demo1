#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property int age;
@property NSString*name;

-(instancetype)initWithDict:(NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
