//
//  Bling_HomeAppDelegate.h
//  Bling Home
//
//  Created by Y WT on 11-4-21.
//  Copyright 2011 TJU. All rights reserved.
//

#import <UIKit/UIKit.h>
@class indexViewController;

@interface Bling_HomeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	indexViewController *indexView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet indexViewController *indexView;
@end

