//
//  MyChart.h
//  NaviCorePlotTest
//
//  Created by Kwon Oh Nam on 11. 8. 26..
//  Copyright 2011년 (주)아이씨비에스. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface MyChart : UIViewController <CPTPieChartDataSource, CPTPieChartDelegate>
{
    CPTXYGraph *pieChart;
    NSMutableArray *dataForChart;
    NSTimer *timer;
    UIBarButtonItem *bef;
}

@property (nonatomic, retain) UIBarButtonItem *bef;
@property(readwrite, retain, nonatomic) NSMutableArray *dataForChart;
@property(readwrite, retain, nonatomic) NSTimer *timer;

-(void)timerFired;
- (IBAction)goBef:(id)sender;


@end
