//
//  ViewController.m
//  WhereAmI
//
//  Created by LiuRivers on 16/8/14.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Place.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) CLLocation *previousPoint;

@property (assign, nonatomic) CLLocationDistance totalMovementDistance;

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *horizontalAccuracyLabel;

@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;

@property (weak, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;

@property (weak, nonatomic) IBOutlet UILabel *distanceTraveledLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager startUpdatingLocation];
            self.mapView.showsUserLocation = YES;
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager stopUpdatingLocation];
            self.mapView.showsUserLocation = NO;
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSString *errorType = error.code == kCLErrorDenied ? @"Access Denied" : [NSString stringWithFormat:@"Error %ld", error.code];
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Location Manager Error" message:errorType preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertCtrl addAction:okAction];
    
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    self.latitudeLabel.text = latitudeString;
    
    NSString *longtitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    self.longitudeLabel.text = longtitudeString;
    
    NSString *horizontalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    self.horizontalAccuracyLabel.text = horizontalAccuracyString;
    
    NSString *altitudeString = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    self.altitudeLabel.text = altitudeString;
    
    NSString *verticalAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];
    self.verticalAccuracyLabel.text = verticalAccuracyString;
    
    if (newLocation.verticalAccuracy < 0 || newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    if (newLocation.horizontalAccuracy > 100 || newLocation.verticalAccuracy > 50) {
        return;
    }
    
    if (self.previousPoint == nil) {
        self.totalMovementDistance = 0;
        
        Place *start = [[Place alloc]init];
        start.coordinate = newLocation.coordinate;
        start.title = @"Start Point";
        start.subtitle = @"This is where we started!";
        [self.mapView addAnnotation:start];
        
        MKCoordinateRegion region;
        region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [self.mapView setRegion:region animated:YES];
    } else {
        self.totalMovementDistance += [newLocation distanceFromLocation:self.previousPoint];
    }
    self.previousPoint = newLocation;
    
    NSString *distanceString = [NSString stringWithFormat:@"%gm", self.totalMovementDistance];
    self.distanceTraveledLabel.text = distanceString;
}
@end
