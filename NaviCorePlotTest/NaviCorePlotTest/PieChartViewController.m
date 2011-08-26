//
//  PieChartViewController.m
//  NaviCorePlotTest
//
//  Created by  주실 장 on 11. 8. 21..
//  Copyright 2011 (주)아이씨비에스. All rights reserved.
//

#import "PieChartViewController.h"


@implementation PieChartViewController

@synthesize dataForChart, timer, bef;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [dataForChart release];
    [timer release];
    [bef release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // pie에서 차지하는 비율 설정
    NSMutableArray *contentArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithDouble:20.0], [NSNumber numberWithDouble:30.0], [NSNumber numberWithDouble:60.0], nil];
    self.dataForChart = contentArray;
    
    [self timerFired];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CGFloat margin = pieChart.plotAreaFrame.borderLineStyle.lineWidth + 5.0;
    
    CPTPieChart *piePlot = (CPTPieChart *)[pieChart plotWithIdentifier:@"Pie Chart 1"];
    CGRect plotBounds = pieChart.plotAreaFrame.bounds;
    CGFloat newRadius = MIN(plotBounds.size.width, plotBounds.size.height) / 2.0 - margin;
    
    CGFloat y = 0.0;
    
    if ( plotBounds.size.width > plotBounds.size.height ) {
        y = 0.5; 
    }
    else {
        y = (newRadius + margin) / plotBounds.size.height;
    }
    CGPoint newAnchor = CGPointMake(0.5, y);
    
    // Animate the change
    [CATransaction begin];
    {
        [CATransaction setAnimationDuration:1.0];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"pieRadius"];
        animation.toValue = [NSNumber numberWithDouble:newRadius];
        animation.fillMode = kCAFillModeForwards;
        animation.delegate = self;
        [piePlot addAnimation:animation forKey:@"pieRadius"];
        
        animation = [CABasicAnimation animationWithKeyPath:@"centerAnchor"];
        animation.toValue = [NSValue valueWithBytes:&newAnchor objCType:@encode(CGPoint)];
        animation.fillMode = kCAFillModeForwards;
        animation.delegate = self;
        [piePlot addAnimation:animation forKey:@"centerAnchor"];
    }
    [CATransaction commit];
}

-(void)timerFired
{   
    [pieChart release];
    
    // Create pieChart from theme
    pieChart = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTDarkGradientTheme];
    [pieChart applyTheme:theme];
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self.view;
    hostingView.hostedGraph = pieChart;
    
    pieChart.paddingLeft = 20.0;
    pieChart.paddingTop = 20.0;
    pieChart.paddingRight = 20.0;
    pieChart.paddingBottom = 20.0;
    
    pieChart.axisSet = nil;
    
    CPTMutableTextStyle *whiteText = [CPTMutableTextStyle textStyle];
    whiteText.color = [CPTColor whiteColor];
    
    pieChart.titleTextStyle = whiteText;
    pieChart.title = @"Graph Title";
    
    // Add pie chart
    CPTPieChart *piePlot = [[CPTPieChart alloc] init];
    piePlot.dataSource = self;
    piePlot.pieRadius = 131.0; // 반지름
    piePlot.identifier = @"Pie Chart 1";
    piePlot.startAngle = M_PI_4;
    piePlot.sliceDirection = CPTPieDirectionCounterClockwise;
    piePlot.centerAnchor = CGPointMake(0.5, 0.38);
    piePlot.borderLineStyle = [CPTLineStyle lineStyle];
    piePlot.delegate = self;
    [pieChart addPlot:piePlot];
    [piePlot release];
}

#pragma mark Plot Data Source Methods

// 갯수
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return [self.dataForChart count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    if ( index >= [self.dataForChart count] ) return nil;
    
    if ( fieldEnum == CPTPieChartFieldSliceWidth ) {
        return [self.dataForChart objectAtIndex:index];
    }
    else {
        return [NSNumber numberWithInt:index];
    }
}

-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index 
{
    CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%lu", index]];
    CPTMutableTextStyle *textStyle = [label.textStyle mutableCopy];
    textStyle.color = [CPTColor lightGrayColor];
    label.textStyle = textStyle;
    [textStyle release];
    return [label autorelease];
}

-(CGFloat)radialOffsetForPieChart:(CPTPieChart *)piePlot recordIndex:(NSUInteger)index
{
    CGFloat offset = 0.0;
    
    if ( index == 0 ) {
        offset = piePlot.pieRadius / 8.0;
    }
    
    return offset;
}

/*-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index; 
 {
 return nil;
 }*/

#pragma mark -
#pragma mark Delegate Methods

// 선택된 부분의 index를 알려줌
-(void)pieChart:(CPTPieChart *)plot sliceWasSelectedAtRecordIndex:(NSUInteger)index
{
    pieChart.title = [NSString stringWithFormat:@"Selected index: %lu", index];
}

-(void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    CPTPieChart *piePlot = (CPTPieChart *)[pieChart plotWithIdentifier:@"Pie Chart 1"];
    CABasicAnimation *basicAnimation = (CABasicAnimation *)theAnimation;
    
    [piePlot removeAnimationForKey:basicAnimation.keyPath];
    [piePlot setValue:basicAnimation.toValue forKey:basicAnimation.keyPath];
    //[piePlot repositionAllLabelAnnotations];
}


- (IBAction)goBef:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
