@interface Calculator : NSObject

+ (NSDecimalNumber *)sinclairForLiftTotal:(NSDecimalNumber *)liftTotalKg
                               bodyweight:(NSDecimalNumber *)bodyweightKg
                                   isMale:(BOOL)isMale
                                      age:(int)age;
@end