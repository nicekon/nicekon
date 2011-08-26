//
//  MainViewController.h
//  NaviCorePlotTest
//
//  Created by  주실 장 on 11. 8. 21..
//  Copyright 2011 (주)아이씨비에스. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BarChartViewController;

@interface MainViewController : UIViewController {
}

- (IBAction)showBarChart:(id)sender;
- (IBAction)showLineChart:(id)sender;
- (IBAction)showPieChart:(id)sender;
- (IBAction)showMyChart:(id)sender;

@end
