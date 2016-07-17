//
//  RootViewController.m
//  Presidents
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    UIViewController *spltVC = self.viewControllers[0];
    UITraitCollection *newTraits = self.traitCollection;
    
    if (newTraits.horizontalSizeClass == UIUserInterfaceSizeClassCompact && newTraits.verticalSizeClass == UIUserInterfaceSizeClassCompact) {
        
        UITraitCollection *childTraits = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
        [self setOverrideTraitCollection:childTraits forChildViewController:spltVC];
    } else {
        [self setOverrideTraitCollection:nil forChildViewController:spltVC];
    }
    
    [super traitCollectionDidChange:previousTraitCollection];
}

@end
