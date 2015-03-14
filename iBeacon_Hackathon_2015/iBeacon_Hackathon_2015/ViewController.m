//
//  ViewController.m
//  iBeacon_Hackathon_2015
//
//  Created by Jonathan Fox on 3/6/15.
//  Copyright (c) 2015 Jon Fox. All rights reserved.
//

#import "ViewController.h"
#import <Gimbal/Gimbal.h>

@interface ViewController () <GMBLPlaceManagerDelegate, GMBLCommunicationManagerDelegate, GMBLBeaconManagerDelegate>
@property (nonatomic) GMBLPlaceManager *placeManager;
@property (nonatomic) GMBLCommunicationManager *communicationManager;
@property (nonatomic) GMBLBeaconManager *beaconManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.placeManager = [GMBLPlaceManager new];
    self.placeManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    
    self.communicationManager = [GMBLCommunicationManager new];
    self.communicationManager.delegate = self;
    [GMBLCommunicationManager startReceivingCommunications];
    
    self.beaconManager = [GMBLBeaconManager new];
    self.beaconManager.delegate = self;
    [self.beaconManager startListening];
}

-(void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit{
    NSLog(@"Begin visit");
//    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert!" message:@"You've entered a region" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
//    NSDate *arrivalDate = visit.arrivalDate;
//    GMBLPlace *place = visit.place;
//    NSString *identifier = place.identifier;
//    NSString *name = place.name;
//    GMBLAttributes *attributes = place.attributes;
//    NSLog(@"arrival date: %@\nplace: %@\nidentifier: %@\nname: %@\nattributes: %@", arrivalDate, place, identifier, name, attributes);
}

-(void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit{
    NSLog(@"You've exited the test area");
}

-(NSArray *)communicationManager:(GMBLCommunicationManager *)manager presentLocalNotificationsForCommunications:(NSArray *)communications forVisit:(GMBLVisit *)visit{
    NSLog(@"Communications: %@", communications);
//    NSString * communication = communications[0];
//    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Alert!" message:communication delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
    
    return communications;
}

- (void)beaconManager:(GMBLBeaconManager *)manager didReceiveBeaconSighting:(GMBLBeaconSighting *)sighting{
    NSLog(@"Sighting");
    NSInteger rssi = sighting.RSSI;
//    NSDate *date = sighting.date;
//    GMBLBeacon *beacon = sighting.beacon;
    NSLog(@"RSSI: %ld", (long)rssi);
}

@end
