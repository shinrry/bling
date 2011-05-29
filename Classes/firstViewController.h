//
//  firstViewController.h
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class secondViewController;

@interface firstViewController : UIViewController {
	secondViewController *viewSecond;
	UIView     *slideUpView;
	BOOL slideUpViewShowing;

}
@property(retain,nonatomic)secondViewController *viewSecond;
@property(nonatomic, retain)  UIView *slideUpView;
-(IBAction)calculate:(id)sender;
-(IBAction)addMenu;



@end
