#import <UIKit/UIKit.h>
@class indexViewController;

@interface Bling_HomeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	indexViewController *indexView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet indexViewController *indexView;
@end

