//
//  ViewController.m
//  MotionMonitor
//
//  Created by LiuRivers on 16/8/15.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gyroscopeLabel;

@property (weak, nonatomic) IBOutlet UILabel *accelerometerLabel;

@property (weak, nonatomic) IBOutlet UILabel *attitudeLabel;

@property (retain, nonatomic) CMMotionManager *motionManager;

@property (retain, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc]init];
    self.queue = [[NSOperationQueue alloc]init];
    
    if (self.motionManager.deviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 0.1;
        [self.motionManager startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            CMRotationRate rotationRate = motion.rotationRate;
            CMAcceleration gravity = motion.gravity;
            CMAcceleration userAcc = motion.userAcceleration;
            CMAttitude *attitude = motion.attitude;
            
            NSString *gyroscopeText = [NSString stringWithFormat:@"Rotation Rate:\n------------\nx:%+.2f\ny:%+.2f\nz:%+.2f\n",
                                       rotationRate.x, rotationRate.y, rotationRate.z];
            NSString *acceleratorText = [NSString stringWithFormat:@"Acceleration:\n-----------\nGravity x: %+.2f\t\tUser x: %+2.f\nGravity y: %+.2f\t\tUser y: %+2.f\nGravity z: %+.2f\t\tUser y: %+2.f\n", gravity.x, userAcc.x, gravity.y, userAcc.y, gravity.z, userAcc.z];
            NSString *attitudeText = [NSString stringWithFormat:@"Attitude:\n-----------\nRoll: %+.2f\nPitch: %+.2f\nYaw: %+.2f\n", attitude.roll, attitude.pitch, attitude.yaw];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.gyroscopeLabel.text = gyroscopeText;
                self.accelerometerLabel.text = acceleratorText;
                self.attitudeLabel.text = attitudeText;
            });
        }];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
