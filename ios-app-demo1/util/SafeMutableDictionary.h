#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SafeMutableDictionary : NSObject

- (void)removeObjectForKey:(id)aKey;

- (void)setObject:(id)anObject forKey:(id)aKey;

- (nullable id)objectForKey:(id)aKey;

- (NSArray *)allKeys;

- (NSArray *)allValues;

@end

NS_ASSUME_NONNULL_END
