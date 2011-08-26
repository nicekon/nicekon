//
//  LineChartViewController.h
//  NaviCorePlotTest
//
//  Created by  주실 장 on 11. 8. 21..
//  Copyright 2011 (주)아이씨비에스. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"


@interface LineChartViewController : UIViewController <CPTPlotDataSource> {
    CPTXYGraph *graph;
    NSMutableArray *dataForPlot;
    UIBarButtonItem *bef;
}

@property (nonatomic, retain) UIBarButtonItem *bef;
@property(readwrite, retain, nonatomic) NSMutableArray *dataForPlot;

- (IBAction)goBef:(id)sender;

@end
