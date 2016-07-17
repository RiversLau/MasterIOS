//
//  AppDelegate.m
//  Presidents
//
//  Created by LiuRivers on 16/7/3.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UINavigationController *rootViewController = (UINavigationController *)self.window.rootViewController;
    
    UISplitViewController *splitViewController = (UISplitViewController *)rootViewController.viewControllers[0];
    
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    
    splitViewController.preferredPrimaryColumnWidthFraction = 0.4;
    splitViewController.maximumPrimaryColumnWidth = 600;
    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    
    return YES;
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

@end
