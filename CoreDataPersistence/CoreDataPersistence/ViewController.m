//
//  ViewController.m
//  CoreDataPersistence
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

static NSString * const kLineEntityName = @"Line";
static NSString * const kLineNumberKey = @"lineNumber";
static NSString * const kLineTextKey = @"lineText";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:kLineEntityName];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        NSLog(@"There was an error");
    }
    
    for (NSManagedObject *oneObject in objects) {
        int lineNum = [[oneObject valueForKey:kLineNumberKey]intValue];
        NSString *lineText = [oneObject valueForKey:kLineTextKey];
        
        UITextField *theField = self.lineFields[lineNum];
        theField.text = lineText;
    }
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    NSError *error;
    
    for (int i = 0; i < 4; i++) {
        UITextField *field = self.lineFields[i];
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:kLineEntityName];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"(%K = %d)", kLineNumberKey, i];
        [request setPredicate:pred];
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        if (objects == nil) {
            NSLog(@"There was an error");
        }
        
        NSManagedObject *theLine = nil;
        if ([objects count] > 0) {
            theLine = [objects objectAtIndex:0];
        } else {
            theLine = [NSEntityDescription insertNewObjectForEntityForName:kLineEntityName inManagedObjectContext:context];
        }
        [theLine setValue:[NSNumber numberWithInt:i] forKey:kLineNumberKey];
        [theLine setValue:field.text forKey:kLineTextKey];
    }
    [delegate saveContext];
}
@end
