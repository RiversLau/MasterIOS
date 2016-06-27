//
//  ViewController.m
//  ViewSwitcher
//
//  Created by LiuRivers on 16/6/26.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "SwitchingViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"

@interface SwitchingViewController ()

@property (strong, nonatomic) BlueViewController *blueViewController;

@property (strong, nonatomic) YellowViewController *yellowViewController;

@end

@implementation SwitchingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    self.blueViewController.view.frame = self.view.frame;
    
    [self switchViewFromViewController: nil toViewController: self.blueViewController];
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
}

- (IBAction)switchViews:(id)sender {
    
    if (!self.yellowViewController.view.superview) {
        if (!self.yellowViewController) {
            self.yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"Yellow"];
        }
    } else {
        if (!self.blueViewController) {
            self.blueViewController = [self.storyboard instantiateViewControllerWithIdentifier: @"Blue"];
        }
    }
    
    [UIView beginAnimations:@"View Flip" context: NULL];
    [UIView setAnimationDuration: 1.0];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
    
    if (!self.yellowViewController.view.superview) {
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        
        self.yellowViewController.view.frame = self.view.frame;
        [self switchViewFromViewController: self.blueViewController toViewController: self.yellowViewController];
    } else {
        
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        
        self.blueViewController.view.frame = self.view.frame;
        [self switchViewFromViewController: self.yellowViewController toViewController: self.blueViewController];
    }
    
    [UIView commitAnimations];
}

- (void)switchViewFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *) toVc {
    
    if (fromVC != nil) {
        [fromVC willMoveToParentViewController: nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    
    if (toVc != nil) {
        [self addChildViewController:toVc];
        [self.view insertSubview: toVc.view atIndex: 0];
        [toVc didMoveToParentViewController: self];
    }
}

@end
