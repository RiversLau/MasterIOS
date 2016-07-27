//
//  TinyPixDocument.m
//  TinyPix
//
//  Created by LiuRivers on 16/7/18.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "TinyPixDocument.h"

@interface TinyPixDocument()

@property (strong, nonatomic) NSMutableData *bitmap;

@end

@implementation TinyPixDocument

-(id)initWithFileURL:(NSURL *)url {
    
    self = [super initWithFileURL:url];
    if (self) {
        unsigned char startPattern[] = {
            0x01,
            0x02,
            0x04,
            0x08,
            0x10,
            0x20,
            0x40,
            0x80
        };
        
        self.bitmap = [NSMutableData dataWithBytes:startPattern length:8];
    }
    return self;
}

- (BOOL)stateAtRow:(NSUInteger)row column:(NSUInteger)column {
    
    const char *bitmapBytes = [self.bitmap bytes];
    char rowType = bitmapBytes[row];
    char result = (1 << column) & rowType;
    if (result != 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)setState:(BOOL)state atRow:(NSUInteger)row column:(NSUInteger)column {
    
    char *bitmapBytes = [self.bitmap mutableBytes];
    char *rowByte = &bitmapBytes[row];
    
    if (state) {
        *rowByte = *rowByte | (1 << column);
    } else {
        *rowByte = *rowByte & ~(1 << column);
    }
}

- (void)toggleStateAtRow:(NSUInteger)row column:(NSUInteger)column {
    
    BOOL state = [self stateAtRow:row column:column];
    [self setState:state atRow:row column:column];
}

- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    NSLog(@"Saving document to URL %@", self.fileURL);
    return [self.bitmap copy];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    NSLog(@"Loading document from URL %@", self.fileURL);
    self.bitmap = [contents mutableCopy];
    return true;
}
@end
