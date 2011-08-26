//
//  MainViewController.m
//  NaviCorePlotTest
//
//  Created by  주실 장 on 11. 8. 21..
//  Copyright 2011 (주)아이씨비에스. All rights reserved.
//

#import "MainViewController.h"
#import "BarChartViewController.h"
#import "LineChartViewController.h"
#import "PieChartViewController.h"
#import "MyChart.h"

@implementation MainViewController

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
    self.navigationItem.title=@"Main";
    UIBarButtonItem *backBtn=[[UIBarButtonItem alloc]initWithTitle:@"Main으로" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem=backBtn;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showBarChart:(id)sender {
    BarChartViewController *bar = [[BarChartViewController alloc]initWithNibName:@"BarChartViewController" bundle:nil];
    [self.navigationController pushViewController:bar animated:YES];
}

- (IBAction)showLineChart:(id)sender {
    LineChartViewController *line = [[LineChartViewController alloc]initWithNibName:@"LineChartViewController" bundle:nil];
    [self.navigationController pushViewController:line animated:YES];
}

- (IBAction)showPieChart:(id)sender {
    PieChartViewController *pie = [[PieChartViewController alloc]initWithNibName:@"PieChartViewController" bundle:nil];
    [self.navigationController pushViewController:pie animated:YES];
}

- (IBAction)showMyChart:(id)sender {
    MyChart *chart = [[MyChart alloc]initWithNibName:@"MyChart" bundle:nil];
    [self.navigationController pushViewController:chart animated:YES];

}
@end
