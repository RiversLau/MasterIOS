//
//  Place.h
//  WhereAmI
//
//  Created by LiuRivers on 16/8/14.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Place : NSObject <MKAnnotation>

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *subtitle;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

@end
