//
//  ViewController.m
//  GestureSwipe
//
//  Created by LiuRivers on 16/8/9.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) CGPoint gestureStartPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    for (NSUInteger touchCount = 1; touchCount <= 5; touchCount++) {
        UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reportVerticalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        vertical.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:vertical];
        
        UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(reportHorizontalSwipe:)];
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontal.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:horizontal];
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer {
    
    self.label.text = [NSString stringWithFormat:@"%@ Horizontal swipe detected", [self descriptionForTouchCount:recognizer.numberOfTouches]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.label.text = @"";
    });
}

- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer {
    
    self.label.text = [NSString stringWithFormat:@"%@ Vertical swipe detected", [self descriptionForTouchCount:recognizer.numberOfTouches]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.label.text = @"";
    });
}

- (NSString *)descriptionForTouchCount:(NSUInteger)touchCount {
    switch (touchCount) {
        case 1:
            return @"Single";
            break;
        case 2:
            return @"Double";
            break;
        case 3:
            return @"Triple";
            break;
        case 4:
            return @"Quadruple";
            break;
        case 5:
            return @"Quintuple";
            break;
        default:
            return @"";
            break;
    }
}
@end
