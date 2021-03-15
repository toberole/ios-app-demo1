#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NBPerson : NSObject
{
    /* 实例变量 注意在大括号里面*/
    @private
    NSString*test_name;
    
    @public
    NSString*test_age;
    
    @protected
    NSString*test_age1;
}


/* 属性变量 */
@property(nonatomic,strong)NSString*name;

@property(nonatomic,assign)int age;

@end

NS_ASSUME_NONNULL_END
