//
//  DatePickerViewController.m
//  Pickers
//
//  Created by shine-team2 on 16/6/27.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSDate *now = [NSDate date];
    [self.datePicker setDate: now animated: YES];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    NSDate *date = self.datePicker.date;
    NSString *message = [[NSString alloc] initWithFormat:@"The date and time you selected is %@", date];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Date and Time Selected" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"That's so true!" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction: action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
