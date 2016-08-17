//
//  ViewController.m
//  TouchExplorer
//
//  Created by LiuRivers on 16/8/8.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UILabel *tapsLabel;

@property (weak, nonatomic) IBOutlet UILabel *touchesLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateLabelsFromTouches:(NSSet *)touches {
    NSUInteger numTaps = [[touches anyObject] tapCount];
    NSString *tapsMessage = [[NSString alloc]initWithFormat:@"%ld taps detected", numTaps];
    self.tapsLabel.text = tapsMessage;
    
    NSUInteger numTouches = [touches count];
    NSString *touchMsg = [[NSString alloc]initWithFormat:@"%ld touches detected", numTouches];
    self.touchesLabel.text = touchMsg;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Begin";
    [self updateLabelsFromTouches:event.allTouches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches cancelled";
    [self updateLabelsFromTouches:event.allTouches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Touches Ended";
    [self updateLabelsFromTouches:event.allTouches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.messageLabel.text = @"Drag Detected";
    [self updateLabelsFromTouches:event.allTouches];
}
@end
