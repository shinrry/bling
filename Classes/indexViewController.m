
#import "indexViewController.h"
#import "firstViewController.h"
	//#import"secondViewController.h"


@implementation indexViewController
@synthesize firstView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	firstViewController *firstTemp=[[firstViewController alloc]initWithNibName:@"firstViewController2" bundle:nil];
	self.firstView=firstTemp;
	[self.view insertSubview:firstTemp.view atIndex:0];
	[firstTemp release];
    [super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.firstView=nil;
		//self.secondView=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[firstView release];
		//[secondView release];
    [super dealloc];
}


@end
