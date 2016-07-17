//
//  ViewController.m
//  Persistence
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import "FourLines.h"

@interface ViewController ()

@end

static NSString *const kRooKey = @"kRootKey";

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableData *data = [[NSMutableData alloc]initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        FourLines *fourLines = [unarchiver decodeObjectForKey:kRooKey];
        [unarchiver finishDecoding];
        
        for (int i = 0; i < 4; i++) {
            UITextField *theField = self.lineFields[i];
            theField.text = fourLines.lines[i];
        }
    }
    
    UIApplication *application = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationDidBecomeActiveNotification object:application];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (NSString *)dataFilePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = paths[0];
    
    return [documentPath stringByAppendingPathComponent:@"data.archive"];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    
    NSString *filePath = [self dataFilePath];
    
    FourLines *fourLines = [[FourLines alloc]init];
    fourLines.lines = [self.lineFields valueForKey:@"text"];
    
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kRooKey];
    [archiver finishEncoding];
    
    [data writeToFile:filePath atomically:YES];
}
@end
