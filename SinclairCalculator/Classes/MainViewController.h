@interface MainViewController : UIViewController <UITextFieldDelegate> {}
@property (strong, nonatomic) IBOutlet UILabel *sinclairValue;
@property (strong, nonatomic) IBOutlet UITextField *liftTotal;
@property (strong, nonatomic) IBOutlet UITextField *bodyweight;
@property (strong, nonatomic) IBOutlet UITextField *age;
@property (strong, nonatomic) IBOutlet UISegmentedControl *sex;
@property (strong, nonatomic) IBOutlet UISegmentedControl *lbsOrKg;

@end