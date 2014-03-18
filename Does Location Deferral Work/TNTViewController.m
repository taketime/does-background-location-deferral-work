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
@property CLLocationManager *locationManager;
@property NSMutableArray *locations;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end

@implementation TNTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locations = [[NSMutableArray alloc] init];
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        // Configure location manager for deferral
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        
        // Configure for getting updates in the background
        self.locationManager.pausesLocationUpdatesAutomatically = YES;
        self.locationManager.activityType = CLActivityTypeFitness;
        
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
    // Store some locations
    for (CLLocation *loc in locations) {
        [self.locations addObject:loc];
    }
    
    // Defer location updates for 5 seconds
    if (!self.deferringUpdates) {
        [self.locationManager allowDeferredLocationUpdatesUntilTraveled:CLLocationDistanceMax
                                                                timeout:(double)5];
        self.deferringUpdates = YES;
    }
}

// Called after deferral is complete
- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    if (error) {
        NSLog(@"Deferring finished with error: %@", error);
    }
    
    if ([self.locations count] > 1 && !error) {
        NSLog(@"locations %@", self.locations);
        self.status.text = @"YES!";
        self.status.textColor = [UIColor greenColor];
    } else {
        self.status.text = @"NO!";
        self.status.textColor = [UIColor redColor];
    }
    
    // Reset locations cache
    [self.locations removeAllObjects];
    
    self.deferringUpdates = NO;
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"Updates paused");
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"Updates resumed");
}

@end
