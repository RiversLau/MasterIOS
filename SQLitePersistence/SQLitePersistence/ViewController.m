//
//  ViewController.m
//  SQLitePersistence
//
//  Created by LiuRivers on 16/7/17.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    NSString *createSQl = @"CREATE TABLE IF NOT EXISTS FIELDS" "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);";
    char *errorMsg;
    if (sqlite3_exec(database, [createSQl UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    
    NSString *query = @"SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW";
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
            char *rowData = (char *)sqlite3_column_text(statement, 1);
            NSString *fieldValue = [[NSString alloc]initWithUTF8String:rowData];
            UITextField *field = self.lineFields[row];
            field.text = fieldValue;
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
    
    UIApplication *app = [UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)applicationWillResignActive:(NSNotification *)notificaton {
 
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    
    for (int i = 0; i < 4; i++) {
        
        UITextField *field = self.lineFields[i];
        char *update = "INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA)" "VALUES (?, ?);";
        
        char *errorMsg = NULL;
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, update, -1, &statement, nil) == SQLITE_OK) {
            sqlite3_bind_int(statement, 1, i);
            sqlite3_bind_text(statement, 2, [field.text UTF8String], -1, NULL);
        }
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSAssert(0, @"Error updating table:%s", errorMsg);
        }
        
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
}

- (NSString *)dataFilePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = paths[0];
    
    return [documentDirectory stringByAppendingPathComponent:@"data.sqlite"];
}
@end
