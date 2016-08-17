//
//  ViewController.m
//  Swipes
//
//  Created by LiuRivers on 16/8/9.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) CGPoint gestureStartPoint;

@end

static CGFloat const kMinimumGestureLength = 25;
static CGFloat const kMaximumVariance = 5;

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.gestureStartPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self.view];
    CGFloat deltaX = fabs(self.gestureStartPoint.x - currentPosition.x);
    CGFloat deltaY = fabs(self.gestureStartPoint.y - currentPosition.y);
    
    if (deltaX >= kMinimumGestureLength && deltaY >= kMaximumVariance) {
        self.label.text = @"Horizontal swipe detected";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.label.text = @"";
        });
    } else if (deltaY >= kMinimumGestureLength && deltaX <= kMaximumVariance) {
        self.label.text = @"Vertical swipe detected";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.label.text = @"";
        });
    }
}
@end
