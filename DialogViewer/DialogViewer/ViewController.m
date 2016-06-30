//
//  ViewController.m
//  DialogViewer
//
//  Created by shine-team2 on 16/6/29.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import "HeaderCell.h"
#import "ContentCell.h"

@interface ViewController ()

@property (copy, nonatomic) NSArray *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.sections = @[@{@"header" : @"First Witch",
                        @"content" : @"Hey, when will the three of us meet up later?"},
                      @{@"header" : @"Second Witch",
                        @"content" : @"When everything's straightened out."},
                      @{@"header" : @"Third Witch",
                        @"content" : @"That'll be just before sunset."},
                      @{@"header" : @"First Witch",
                        @"content" : @"Where?"},
                      @{@"header" : @"Second Witch",
                        @"content" : @"The dirt patch."},
                      @{@"header" : @"Third Witch",
                        @"content" : @"I guess we'll see Mac there."}];
    
    [self.collectionView registerClass:[ContentCell class] forCellWithReuseIdentifier:@"CONTENT"];
    
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    contentInset.top = 20;
    [self.collectionView setContentInset: contentInset];
    
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout *)layout;
    flow.sectionInset = UIEdgeInsetsMake(10, 20, 30, 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)wordsInSection:(NSInteger)section {
    
    NSString *content = self.sections[section][@"content"];
    NSCharacterSet *space = [NSCharacterSet whitespaceCharacterSet];
    NSArray *words = [content componentsSeparatedByCharactersInSet: space];
    return words;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[self wordsInSection:section]count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSArray *words = [self wordsInSection:indexPath.section];
    CGSize size = [ContentCell sizeForContentString:words[indexPath.row] forMaxWidth:collectionView.bounds.size.width];
    
    return size;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *words = [self wordsInSection:indexPath.section];
    
    ContentCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CONTENT" forIndexPath:indexPath];
    cell.maxWidth = collectionView.bounds.size.width;
    cell.text = words[indexPath.row];
    
    return cell;
}
@end
