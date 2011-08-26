//
//  NaviCorePlotTestAppDelegate.h
//  NaviCorePlotTest
//
//  Created by  주실 장 on 11. 8. 21..
//  Copyright 2011 (주)아이씨비에스. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviCorePlotTestAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *_navigationController;
}
@property (nonatomic, retain) NSArray *arr;
@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
