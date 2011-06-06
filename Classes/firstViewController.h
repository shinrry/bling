#import <UIKit/UIKit.h>
@class secondViewController;

@interface firstViewController : UIViewController {
	secondViewController *viewSecond;
}

@property(retain,nonatomic)secondViewController *viewSecond;

-(IBAction)calculate:(id)sender;

@end
