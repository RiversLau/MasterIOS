//
//  ViewController.m
//  ShakeAndBreak
//
//  Created by LiuRivers on 16/8/15.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *fixed;

@property (strong, nonatomic) UIImage *broken;

@property (assign, nonatomic) BOOL brokenScreenShowing;

@property (strong, nonatomic) AVAudioPlayer *crashPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"glass" withExtension:@"wav"];
    NSError *error = nil;
    
    self.crashPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    
    if (!self.crashPlayer) {
        NSLog(@"Audio Error! %@", error.localizedDescription);
    }
    
    self.fixed = [UIImage imageNamed:@"home"];
    self.broken = [UIImage imageNamed:@"homebroken"];
    
    self.imageView.image = self.fixed;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    
    if (!self.brokenScreenShowing && motion == UIEventSubtypeMotionShake) {
        self.imageView.image = self.broken;
        [self.crashPlayer play];
        self.brokenScreenShowing = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.imageView.image = self.fixed;
    self.brokenScreenShowing = NO;
}
@end
