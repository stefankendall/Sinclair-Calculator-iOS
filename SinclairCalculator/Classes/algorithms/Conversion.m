#import "Conversion.h"

@implementation Conversion

+ (NSDecimalNumber *) lbsToKg: (NSDecimalNumber *)lbs {
    return [lbs decimalNumberByDividingBy:N(2.20462262)];
}

@end