//
//  BTATableVCTableViewController.m
//  BellyTest
//
//  Created by Jonathan Fox on 6/17/14.
//  Copyright (c) 2014 Jon Fox. All rights reserved.
//

#import "BTATableViewController.h"
#import "BTATableViewCell.h"
#import "BTAFourSquareRequest.h"
#import "BTAMapViewController.h"
#import "BTAData.h"

#import <CoreLocation/CoreLocation.h>

@interface BTATableViewController () <CLLocationManagerDelegate>

@end

@implementation BTATableViewController
{
    CLLocationManager * lmanager;
    CLLocation * currentLocation;
    NSArray * venueProfilesCopy;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        lmanager = [[CLLocationManager alloc]init];
        lmanager.delegate = self;
        
        [lmanager startUpdatingLocation];
    }
    
   
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel * navTitle = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 100, 20)];
    navTitle.text = @"Locations";
    navTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    navTitle.textColor = [UIColor whiteColor];
    navTitle.textAlignment = 1;
    self.navigationItem.titleView = navTitle;
    
    self.tableView.rowHeight = 83;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:UIApplicationWillEnterForegroundNotification object:[UIApplication sharedApplication]];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)refreshTableView
{
    [self.tableView reloadData];
    NSLog(@"refreshTableView");

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.venueProfiles = [@[]mutableCopy];
    
    currentLocation = [locations firstObject];
    
    NSArray * venues = [BTAFourSquareRequest getVenuesWithLat:currentLocation.coordinate.latitude andLong:currentLocation.coordinate.longitude];
    
    for (NSDictionary * venue in venues) {
    
        NSDictionary * venueInfo = venue[@"venue"];
        
        NSDictionary * icon = venueInfo[@"categories"][0][@"icon"][@"prefix"];
        NSDictionary * nameInfo = venueInfo[@"name"];
        NSDictionary * distance = venueInfo[@"location"][@"distance"];
        NSDictionary * status = venueInfo[@"hours"][@"isOpen"];
        NSDictionary * category = venueInfo[@"categories"][0][@"shortName"];
        
        [self.venueProfiles addObject:@{
                @"icon": icon,
                @"name":nameInfo,
                @"distance":distance,
                @"status":status,
                @"category":category
            }];
    }
    [self.tableView reloadData];
    [lmanager stopUpdatingLocation];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
    [self.venueProfiles sortUsingDescriptors:@[sort]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return [self.venueProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[BTATableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    cell.index = self.venueProfiles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [BTAData mainData].selectedCell = (int)indexPath.row;

    BTAMapViewController * mapVC = [[BTAMapViewController alloc]init];
    [self.navigationController pushViewController:mapVC animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
