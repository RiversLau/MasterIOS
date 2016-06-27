//
//  SingleComponentViewController.m
//  Pickers
//
//  Created by shine-team2 on 16/6/27.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "SingleComponentViewController.h"

@interface SingleComponentViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *singlePicker;

@property (strong, nonatomic) NSArray *characterItems;

@end

@implementation SingleComponentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.characterItems = @[@"Luke", @"Leia", @"Han", @"Chewbacca", @"Artoo", @"Threepio", @"Lando"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    NSInteger row = [self.singlePicker selectedRowInComponent: 0];
    NSString *selected = self.characterItems[row];
    
    NSString *title = [[NSString alloc] initWithFormat:@"You selected %@!", selected];
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:@"Thank you for choosing." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"You're welcome" style:UIAlertActionStyleDefault handler:nil];
    [alertCtrl addAction: action];
    
    [self presentViewController: alertCtrl animated: YES completion: nil];
}

#pragma mark - picker data source methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.characterItems count];
}

#pragma mark = picker delegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.characterItems[row];
}
@end
