//
//  ViewController.m
//  Balls
//
//  Created by LiuRivers on 16/8/15.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"
#import <CoreMotion/CoreMotion.h>

#define kUpdateInterval (1.0f / 60.0f)

@interface ViewController ()

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.motionManager = [[CMMotionManager alloc]init];
    self.queue = [[NSOperationQueue alloc]init];
    self.motionManager.deviceMotionUpdateInterval = kUpdateInterval;
    
    __weak ViewController *weakSelf = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        BallView *ballView = (BallView *)weakSelf.view;
        [ballView setAcceleration:motion.gravity];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ballView update];
        });
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
