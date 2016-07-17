//
//  FourLines.m
//  Persistence
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "FourLines.h"

static NSString * const kLinesKey = @"kLinesKey";

@implementation FourLines

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

- (id)copyWithZone:(NSZone *)zone {
    
    FourLines *copy = [[self class]allocWithZone:zone];
    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:[line copyWithZone:zone]];
    }
    
    copy.lines = linesCopy;
    return copy;
}
@end
