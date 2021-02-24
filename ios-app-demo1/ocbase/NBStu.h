#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBStu : NSObject

@property(nonatomic,strong)NSString*test_name;

+(instancetype)initWithName:(NSString*)name;

-(void)sysHello;

@end

NS_ASSUME_NONNULL_END
