//
//  SearchResultsController.m
//  Sections
//
//  Created by shine-team2 on 16/6/28.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "SearchResultsController.h"

static NSString *SectionTableIdentifier = @"SectionTableIdentifier";

@interface SearchResultsController ()

@property (strong, nonatomic) NSDictionary *names;

@property (strong, nonatomic) NSArray *keys;

@property (strong, nonatomic) NSMutableArray *filteredNames;

@end

@implementation SearchResultsController

- (instancetype)initWithNames:(NSDictionary *)names keys:(NSArray *)keys {
    
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.names = names;
        self.keys = keys;
        self.filteredNames = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SectionTableIdentifier];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.filteredNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionTableIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.filteredNames[indexPath.row];
    
    return cell;
}

#pragma mark - UISearchResultsUpdating Conformance

static const NSUInteger longNameSize = 6;
static const NSUInteger shortNamesButtonIndex = 1;
static const NSUInteger longNamesButtonIndex = 2;

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchString = searchController.searchBar.text;
    NSInteger buttonIndex = searchController.searchBar.selectedScopeButtonIndex;
    [self.filteredNames removeAllObjects];
    
    if (searchString.length > 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *name, NSDictionary *b) {
            NSUInteger nameLength = name.length;
            if ((buttonIndex == shortNamesButtonIndex && nameLength >= longNameSize) ||
                (buttonIndex == longNamesButtonIndex && nameLength < longNameSize)) {
                return NO;
            }
            
            NSRange range = [name rangeOfString:searchString options:NSCaseInsensitiveSearch];
            return range.location != NSNotFound;
        }];
        
        for (NSString *key in self.keys) {
            
            NSArray *matches = [self.names[key] filteredArrayUsingPredicate: predicate];
            [self.filteredNames addObjectsFromArray: matches];
        }
    }
    
    [self.tableView reloadData];
}
@end
