#import "NumberHelpers.h"

@implementation NumberHelpers

+ (NSDecimalNumber *)nanOrNil:(NSDecimalNumber *)number to:(NSDecimalNumber *)to {
    return number == nil || [number isEqual:[NSDecimalNumber notANumber]] ? to : number;
}

@end