//
//  firstViewController.m
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import "firstViewController.h"
#import "secondViewController.h"
#import <UIKit/UIButton.h>

@implementation firstViewController
@synthesize viewSecond;
@synthesize slideUpView;


-(IBAction)addMenu{
	
	if (!slideUpViewShowing){
		int m=1;                           //一个临时变量，用来控制按钮的tag
		CGRect frame=CGRectMake(2, 50, 318, 360);//用常量来表示“修改”
		slideUpView = [[UIView alloc] initWithFrame:frame];
		[slideUpView setBackgroundColor:[UIColor blackColor]];
		//[slideUpView setOpaque:NO];
		[slideUpView setAlpha:0.75];
		[[self view] addSubview:slideUpView];
		for (int i =0; i <3; i ++){
			for (int j=0; j<3; j++) {
				UIButton* cardButton = [[UIButton alloc] initWithFrame:CGRectMake(85* i+10 , 93* j+50, 80, 88)];  //从上到下，再从左到右          
				cardButton.backgroundColor = [UIColor redColor];
				cardButton.tag=m;
				m++;              //临时变量改变，增加用来控制按钮的tag值
				[UIButton buttonWithType:UIButtonTypeRoundedRect];
				[cardButton setBackgroundImage:nil forState:UIControlStateNormal];
				[cardButton addTarget:self 
							   action:@selector(calculate:)
					 forControlEvents:UIControlEventTouchDown]; 
				
				[slideUpView addSubview:cardButton];
				[cardButton release];
			}
		}
		slideUpViewShowing=!slideUpViewShowing;
		
	}
	else{
		[slideUpView removeFromSuperview];
		slideUpViewShowing=!slideUpViewShowing;
	}
	
	
}

	
-(IBAction)calculate:(id)sender {
	[slideUpView removeFromSuperview];
	slideUpViewShowing=!slideUpViewShowing;//可能有问题
	int button_tag = [sender tag];
	NSLog(@"wode按钮的序列%d", button_tag);
	secondViewController *secondTemp=[[secondViewController alloc]initWithNibName:@"secondViewController" bundle:nil onPage:button_tag];//方法重点
		

	[self.view insertSubview:secondTemp.view atIndex:2];//问题所在
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
	[slideUpView release];
    [super dealloc];
}


@end
