//
//  TNTViewController.m
//  Does Location Deferral Work
//
//  Created by Christopher Jones on 3/17/14.
//  Copyright (c) 2014 Christopher Jones. All rights reserved.
//

#import "TNTViewController.h"

@interface TNTViewController ()
@property BOOL deferringUpdates;
@property BOOL wasBackgrounded;
@property CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end

@implementation TNTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        // Configure location manager for deferral
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        
        // Configure for getting updates in the background
        self.locationManager.pausesLocationUpdatesAutomatically = YES;
        
        // Get to grabbing locations
        [self.locationManager startUpdatingLocation];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - conform to CLLocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // Defer location updates for 5 seconds
    if (!self.deferringUpdates) {
        [self.locationManager allowDeferredLocationUpdatesUntilTraveled:CLLocationDistanceMax
                                                                timeout:(double)5];
        self.deferringUpdates = YES;
    }
    
    // Catch if we've been backgrounded
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateBackground) {
        self.wasBackgrounded = YES;
    }
    
    // If I've ever been backgrounded, and got more one location, background location updates work
    if (self.wasBackgrounded) {
        if ([locations count] > 1) {
            NSLog(@"deferral worked!");
            NSLog(@"%lu locations: %@", (unsigned long)[locations count], locations);
            self.status.text = @"YES!";
            self.status.textColor = [UIColor greenColor];
        } else {
            self.status.text = @"NO!";
            self.status.textColor = [UIColor redColor];
        }
    }
}

// Called after deferral is complete
- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    if (error) {
        NSLog(@"Deferring update error: %@", error);
    }
    self.deferringUpdates = NO;
}

@end
