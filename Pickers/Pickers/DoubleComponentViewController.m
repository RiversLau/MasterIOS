//
//  DoubleComponentViewController.m
//  Pickers
//
//  Created by shine-team2 on 16/6/27.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "DoubleComponentViewController.h"

#define kFillingComponent 0
#define kBreadComponent 1

@interface DoubleComponentViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *doublePicker;

@property (nonatomic, strong) NSArray *fillingTypes;

@property (nonatomic, strong) NSArray *breadTypes;

@end

@implementation DoubleComponentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.fillingTypes = @[@"Ham", @"Turkey", @"Peanut Butter", @"Tuna Salad", @"Chicken Salad", @"Roast Beef", @"Vegemite"];
    self.breadTypes = @[@"White", @"Whole Wheat", @"Rye", @"Sourdough", @"Seven Grain"];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    NSInteger fillingRow = [self.doublePicker selectedRowInComponent:kFillingComponent];
    NSInteger breadRow = [self.doublePicker selectedRowInComponent:kBreadComponent];
    
    NSString *filling = self.fillingTypes[fillingRow];
    NSString *bread = self.breadTypes[breadRow];
    
    NSString *message = [[NSString alloc]initWithFormat:@"Your %@ and %@ bread will be right up.", filling, bread];
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Thank you for your order." message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Great!" style:UIAlertActionStyleDefault handler:nil];
    [alertCtrl addAction: action];
    
    [self presentViewController:alertCtrl animated: YES completion:nil];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kFillingComponent) {
        return [self.fillingTypes count];
    } else {
        return [self.breadTypes count];
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kFillingComponent) {
        return self.fillingTypes[row];
    } else {
        return self.breadTypes[row];
    }
}
@end
