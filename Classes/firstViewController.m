#import "firstViewController.h"
#import "secondViewController.h"
#import <UIKit/UIButton.h>

@implementation firstViewController

@synthesize viewSecond;
	
-(IBAction)calculate:(id)sender {
	int button_tag = [sender tag];
	NSLog(@"button tag: %d", button_tag);
	secondViewController *secondTemp=[[secondViewController alloc]initWithNibName:@"secondViewController" bundle:nil onPage:button_tag];
	[self.view insertSubview:secondTemp.view atIndex:2];
	[secondTemp release];
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.viewSecond=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[viewSecond release];
	//[slideUpView release];
    [super dealloc];
}

@end
