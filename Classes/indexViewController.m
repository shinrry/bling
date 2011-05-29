    //
//  indexViewController.m
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import "indexViewController.h"
#import"firstViewController.h"
	//#import"secondViewController.h"


@implementation indexViewController
@synthesize firstView;
	//@synthesize secondView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


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
