//
//  ViewController.m
//  PinchMe
//
//  Created by LiuRivers on 16/8/14.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

CGFloat scale, previousScale;
CGFloat rotation, previousRotation;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    previousScale = 1;
    
    UIImage *image = [UIImage imageNamed:@"yosemite-meadows"];
    self.imageView = [[UIImageView alloc]initWithImage:image];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(doPinch:)];
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(doRotate:)];
    rotationGesture.delegate = self;
    [self.imageView addGestureRecognizer:rotationGesture];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

- (void)transformImageView {
    
    CGAffineTransform t = CGAffineTransformMakeScale(scale * previousScale, scale * previousScale);
    t = CGAffineTransformRotate(t, rotation + previousRotation);
    self.imageView.transform = t;
}

- (void)doPinch:(UIPinchGestureRecognizer *)gesture {
    
    scale = gesture.scale;
    [self transformImageView];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        previousScale = scale * previousScale;
        scale = 1;
    }
}

- (void)doRotate:(UIRotationGestureRecognizer *)gesture {
    
    rotation = gesture.rotation;
    [self transformImageView];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        previousRotation = rotation * previousRotation;
        rotation = 0;
    }
}
@end
