//
//  DetailViewController.m
//  Presidents
//
//  Created by LiuRivers on 16/7/3.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "DetailViewController.h"
#import "LanguageListController.h"

@interface DetailViewController ()<UIPopoverControllerDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.languageButton = [[UIBarButtonItem alloc]initWithTitle:@"Choose Language" style:UIBarButtonItemStylePlain target:self action:@selector(toggleLanguagePopover)];
        self.navigationItem.rightBarButtonItem = self.languageButton;
    }
    
    [self configureView];
}

- (void)setLanguageString:(NSString *)languageString {
    
    if (![languageString isEqualToString:self.languageString]) {
        _languageString = [languageString copy];
        [self configureView];
    }
    
    if (self.languagePopoverController != nil) {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (void)toggleLanguagePopover {
    
    if (self.languagePopoverController == nil) {
        LanguageListController *languageListController = [[LanguageListController alloc]init];
        languageListController.detailViewController = self;
        UIPopoverController *poc = [[UIPopoverController alloc]initWithContentViewController:languageListController];
        [poc presentPopoverFromBarButtonItem:self.languageButton permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.languagePopoverController = poc;
    } else {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    
    if (popoverController == self.languagePopoverController) {
        self.languagePopoverController = nil;
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

static NSString * modifyUrlForLanguage(NSString *url, NSString *lang) {
    
    if (!lang) {
        return url;
    }
    
    NSRange codeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:codeRange] isEqualToString:lang]) {
        return url;
    } else {
        NSString *newUrl = [url stringByReplacingCharactersInRange:codeRange withString:lang];
        return newUrl;
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSDictionary *dic = (NSDictionary *)self.detailItem;
        NSString *urlString = modifyUrlForLanguage(dic[@"url"], self.languageString);
        self.detailDescriptionLabel.text = urlString;
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
        NSString *name = dic[@"name"];
        self.title = name;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
