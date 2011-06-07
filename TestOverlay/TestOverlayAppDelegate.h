//
//  TestOverlayAppDelegate.h
//  TestOverlay
//
//  Created by Jeremy Brooks on 5/27/11.
//  Copyright 2011 Jeremy Brooks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestOverlayViewController;

@interface TestOverlayAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TestOverlayViewController *viewController;

@end
