//
//  BallView.h
//  Balls
//
//  Created by LiuRivers on 16/8/15.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface BallView : UIView

@property (assign, nonatomic) CMAcceleration acceleration;

- (void)update;

@end
