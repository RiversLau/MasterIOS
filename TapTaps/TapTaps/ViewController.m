//
//  ViewController.m
//  TapTaps
//
//  Created by LiuRivers on 16/8/14.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *singleLabel;

@property (weak, nonatomic) IBOutlet UILabel *doubleLabel;

@property (weak, nonatomic) IBOutlet UILabel *tripleLabel;

@property (weak, nonatomic) IBOutlet UILabel *quadrupleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    doubleTap.numberOfTouchesRequired = 1;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tripleTap)];
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tripleTap];
    
    [doubleTap requireGestureRecognizerToFail:tripleTap];
    
    UITapGestureRecognizer *quadrupleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quadrupleTap)];
    quadrupleTap.numberOfTouchesRequired = 1;
    quadrupleTap.numberOfTapsRequired = 4;
    [self.view addGestureRecognizer:quadrupleTap];
    
    [tripleTap requireGestureRecognizerToFail:quadrupleTap];
}

- (void)singleTap {
    
    self.singleLabel.text = @"Single Tap Detected";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.singleLabel.text = @"";
    });
}

- (void)doubleTap {
    
    self.doubleLabel.text = @"Double Tap Detected";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.doubleLabel.text = @"";
    });
}

- (void)tripleTap {
    
    self.tripleLabel.text = @"Triple Tap Detected";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.tripleLabel.text = @"";
    });
}

- (void)quadrupleTap {
    
    self.quadrupleLabel.text = @"Quadruple Tap Detected";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.quadrupleLabel.text = @"";
    });
}

@end
