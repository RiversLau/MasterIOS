//
//  LanguageListController.m
//  Presidents
//
//  Created by LiuRivers on 16/7/16.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "LanguageListController.h"
#import "DetailViewController.h"

@interface LanguageListController ()

@end

@implementation LanguageListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.languageNames = @[@"English", @"French", @"German", @"Spanish", @"Chinese"];
    self.languageCodes = @[@"en", @"fr", @"de", @"es", @"cn"];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.preferredContentSize = CGSizeMake(320.0, [self.languageCodes count] * 44.0);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.languageNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.languageNames[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.detailViewController.languageString = self.languageCodes[indexPath.row];
}
@end
