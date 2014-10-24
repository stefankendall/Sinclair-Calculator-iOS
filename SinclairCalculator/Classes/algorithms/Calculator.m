#import "Calculator.h"

@implementation Calculator

+ (NSDecimalNumber *)sinclairForLiftTotal:(NSDecimalNumber *)liftTotalKg bodyweight:(NSDecimalNumber *)bodyweightKg isMale:(BOOL)isMale {
    NSDecimalNumber *b = isMale ? N(174.393) : N(148.026);
    NSDecimalNumber *x = bodyweightKg;
    double XasDouble = log10([[x decimalNumberByDividingBy:b] doubleValue]);
    NSDecimalNumber *X = [NSDecimalNumber decimalNumberWithDecimal:[@(XasDouble) decimalValue]];
    NSDecimalNumber *A = isMale ? N(0.794358141) : N(0.897260740);

    double sinclairCoefficientDouble = [x compare:b] == NSOrderedDescending ? 1 :
            pow(10, [[[A decimalNumberByMultiplyingBy:X] decimalNumberByMultiplyingBy:X] doubleValue]);

    NSDecimalNumber *sinclairCoefficient = [NSDecimalNumber decimalNumberWithDecimal:[@(sinclairCoefficientDouble) decimalValue]];
    return [liftTotalKg decimalNumberByMultiplyingBy:sinclairCoefficient];
}

+ (NSDecimalNumber *)sinclairForLiftTotal:(NSDecimalNumber *)liftTotalKg bodyweight:(NSDecimalNumber *)bodyweightKg isMale:(BOOL)isMale
                                      age:(int)age {
    NSDecimalNumber *sinclair = [self sinclairForLiftTotal:liftTotalKg bodyweight:bodyweightKg isMale:isMale];
    return [sinclair decimalNumberByMultiplyingBy:[self maloneMeltzerCorrectionForAge:age]];
}

+ (NSDecimalNumber *)maloneMeltzerCorrectionForAge:(int)age {
    if (age <= 30) {
        return N(1);
    }

    if (age > 90) {
        age = 90;
    }

    NSDictionary *corrections = @{
            @30:N(1.000),
            @31:N(1.014),
            @32:N(1.028),
            @33:N(1.043),
            @34:N(1.058),
            @35:N(1.072),
            @36:N(1.087),
            @37:N(1.100),
            @38:N(1.113),
            @39:N(1.125),
            @40:N(1.136),
            @41:N(1.147),
            @42:N(1.158),
            @43:N(1.170),
            @44:N(1.183),
            @45:N(1.195),
            @46:N(1.207),
            @47:N(1.217),
            @48:N(1.226),
            @49:N(1.234),
            @50:N(1.243),
            @51:N(1.255),
            @52:N(1.271),
            @53:N(1.293),
            @54:N(1.319),
            @55:N(1.350),
            @56:N(1.384),
            @57:N(1.417),
            @58:N(1.449),
            @59:N(1.480),
            @60:N(1.509),
            @61:N(1.536),
            @62:N(1.561),
            @63:N(1.584),
            @64:N(1.608),
            @65:N(1.636),
            @66:N(1.671),
            @67:N(1.719),
            @68:N(1.782),
            @69:N(1.856),
            @70:N(1.933),
            @71:N(2.002),
            @72:N(2.053),
            @73:N(2.087),
            @74:N(2.113),
            @75:N(2.142),
            @76:N(2.184),
            @77:N(2.251),
            @78:N(2.358),
            @79:N(2.500),
            @80:N(2.669),
            @81:N(2.849),
            @82:N(3.018),
            @83:N(3.166),
            @84:N(3.288),
            @85:N(3.386),
            @86:N(3.458),
            @87:N(3.508),
            @88:N(3.540),
            @89:N(3.559),
            @90:N(3.571)
    };

    return corrections[@(age)];
}

@end