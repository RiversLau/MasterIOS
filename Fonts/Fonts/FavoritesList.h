//
//  FavoritesList.h
//  Fonts
//
//  Created by shine-team2 on 16/6/29.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoritesList : NSObject

+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorite:(id) item;

- (void)removeFavorite:(id) item;

- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;

@end
