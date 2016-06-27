//
//  DependentComponentPickerViewController.m
//  Pickers
//
//  Created by shine-team2 on 16/6/27.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "DependentComponentPickerViewController.h"

#define kStateComponent 0
#define kZipComponent 1

@interface DependentComponentPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *dependentPicker;

@property (nonatomic, strong) NSDictionary *stateZips;

@property (nonatomic, strong) NSArray *states;

@property (nonatomic, strong) NSArray *zips;

@end

@implementation DependentComponentPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *plistUrl = [bundle URLForResource:@"statedictionary" withExtension:@"plist"];
    
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL: plistUrl];
    
    NSArray *allState = [self.stateZips allKeys];
    NSArray *sortedStates = [allState sortedArrayUsingSelector:@selector(compare:)];
    self.states = sortedStates;
    
    NSString *selectedStates = self.states[0];
    self.zips = self.stateZips[selectedStates];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    NSInteger stateRow = [self.dependentPicker selectedRowInComponent:kStateComponent];
    NSInteger zipRow = [self.dependentPicker selectedRowInComponent:kZipComponent];
    
    NSString *state = self.states[stateRow];
    NSString *zip = self.zips[zipRow];
    
    NSString *title = [[NSString alloc]initWithFormat:@"You selected zip code %@", zip];
    NSString *message = [[NSString alloc]initWithFormat:@"%@ is in %@", zip, state];
    
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertCtrl addAction: action];
    
    [self presentViewController: alertCtrl animated: YES completion: nil];
}

#pragma mark -
#pragma mark Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        return [self.states count];
    } else {
        return [self.zips count];
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        return self.states[row];
    } else {
        return self.zips[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == kStateComponent) {
        NSString *selectedStates = self.states[row];
        self.zips = self.stateZips[selectedStates];
        [self.dependentPicker reloadComponent:kZipComponent];
        [self.dependentPicker selectRow:0 inComponent:kZipComponent animated:YES];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat pickerWidth = pickerView.bounds.size.width;
    if (component == kZipComponent) {
        return pickerWidth / 3;
    } else {
        return 2 * pickerWidth / 3;
    }
}
@end
