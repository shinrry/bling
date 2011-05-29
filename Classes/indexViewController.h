//
//  indexViewController.h
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class firstViewController;
	//@class secondViewController;


@interface indexViewController : UIViewController {
	firstViewController *firstView;
		//secondViewController *secondView;

}
@property (nonatomic,retain)firstViewController *firstView;
	//@property (nonatomic,retain)secondViewController *secondView;



@end
