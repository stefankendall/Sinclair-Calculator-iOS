#import "MainViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIToolbar* keyboardToolbar = [UIToolbar new];
    [keyboardToolbar sizeToFit];

    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                 target:self action:@selector(doneClicked:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    self.bodyweight.inputAccessoryView = keyboardToolbar;
    self.age.inputAccessoryView = keyboardToolbar;
    self.liftTotal.inputAccessoryView = keyboardToolbar;
}

- (void)doneClicked:(id)doneClicked {
    [self.bodyweight resignFirstResponder];
    [self.age resignFirstResponder];
    [self.liftTotal resignFirstResponder];
}

@end