#import "MainViewController.h"
#import "Conversion.h"
#import "Calculator.h"
#import "NumberHelpers.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIToolbar *keyboardToolbar = [UIToolbar new];
    [keyboardToolbar sizeToFit];

    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                   target:self action:@selector(doneClicked:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.bodyweight.inputAccessoryView = keyboardToolbar;
    self.age.inputAccessoryView = keyboardToolbar;
    self.liftTotal.inputAccessoryView = keyboardToolbar;

    [self.bodyweight setDelegate:self];
    [self.age setDelegate:self];
    [self.liftTotal setDelegate:self];
    [self.sex addTarget:self action:@selector(updateSinclairValue) forControlEvents:UIControlEventValueChanged];
    [self.lbsOrKg addTarget:self action:@selector(updateSinclairValue) forControlEvents:UIControlEventValueChanged];

    [self loadValues];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self updateSinclairValue];
}

- (void)doneClicked:(id)doneClicked {
    [self.bodyweight resignFirstResponder];
    [self.age resignFirstResponder];
    [self.liftTotal resignFirstResponder];
}

- (void)updateSinclairValue {
    [self storeValues];

    NSDecimalNumber *bodyweight = [NSDecimalNumber decimalNumberWithString:[self.bodyweight text]];
    bodyweight = [NumberHelpers nanOrNil:bodyweight to:N(0)];

    NSDecimalNumber *liftTotal = [NSDecimalNumber decimalNumberWithString:[self.liftTotal text]];
    liftTotal = [NumberHelpers nanOrNil:liftTotal to:N(0)];

    int age = [[self.age text] integerValue];
    age = age <= 0 ? 30 : age;

    BOOL isMale = [self.sex selectedSegmentIndex] == 0;
    BOOL isLbs = [self.lbsOrKg selectedSegmentIndex] == 0;

    if (isLbs) {
        liftTotal = [Conversion lbsToKg:liftTotal];
        bodyweight = [Conversion lbsToKg:bodyweight];
    }

    NSDecimalNumber *sinclair = [Calculator sinclairForLiftTotal:liftTotal bodyweight:bodyweight isMale:isMale age:age];
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumFractionDigits:3];
    [nf setMaximumFractionDigits:3];
    [nf setMinimumIntegerDigits:1];
    [self.sinclairValue setText:[nf stringFromNumber:sinclair]];
}

- (void)storeValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![[self.age text] isEqualToString:@""]) {
        int age = [[self.age text] integerValue];
        [defaults setInteger:age forKey:@"age"];
    }
    BOOL isMale = [self.sex selectedSegmentIndex] == 0;
    [defaults setBool:isMale forKey:@"isMale"];

    BOOL isLbs = [self.lbsOrKg selectedSegmentIndex] == 0;
    [defaults setBool:isLbs forKey:@"lbs"];

    if (![[self.bodyweight text] isEqualToString:@""]) {
        [defaults setObject:[self.bodyweight text] forKey:@"bodyweight"];
    }
    [defaults synchronize];
}

- (void)loadValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"age"]) {
        int age = [defaults integerForKey:@"age"];
        [self.age setText:[NSString stringWithFormat:@"%d", age]];
    }

    if ([defaults objectForKey:@"isMale"]) {
        [self.sex setSelectedSegmentIndex:[defaults boolForKey:@"isMale"] ? 0 : 1];
    }

    if ([defaults objectForKey:@"lbs"]) {
        [self.lbsOrKg setSelectedSegmentIndex:[defaults boolForKey:@"lbs"] ? 0 : 1];
    }

    if ([defaults objectForKey:@"bodyweight"]) {
        [self.bodyweight setText:[defaults objectForKey:@"bodyweight"]];
    }
}

@end