//
//  CheckMarkRecognizer.m
//  CheckPlease
//
//  Created by LiuRivers on 16/8/14.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "CheckMarkRecognizer.h"
#import "CGPointUtils.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

static CGFloat const kMinimumCheckMarkAngle = 50;
static CGFloat const kMaximumCheckMarkAngle = 135;
static CGFloat const kMinimumCheckMarkLength = 10;

@implementation CheckMarkRecognizer {
    CGPoint lastPreviousPoint;
    CGPoint lastCurrentPoint;
    CGFloat lineLengthSoFar;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    lastPreviousPoint = point;
    lastCurrentPoint = point;
    lineLengthSoFar = 0.0;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    CGFloat angle = angleBetweenLines(lastPreviousPoint, lastCurrentPoint, previousPoint, currentPoint);
    if (angle >= kMinimumCheckMarkAngle && angle <= kMaximumCheckMarkAngle && lineLengthSoFar > kMinimumCheckMarkLength) {
        self.state = UIGestureRecognizerStateRecognized;
    }
    
    lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint);
    lastPreviousPoint = previousPoint;
    lastCurrentPoint = currentPoint;
}
@end
