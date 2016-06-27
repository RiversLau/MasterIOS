//
//  CustomPickerViewController.m
//  Pickers
//
//  Created by shine-team2 on 16/6/27.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *images;

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UILabel *winLabel;

@property (weak, nonatomic) IBOutlet UIButton *button;

@property (assign, nonatomic) SystemSoundID winSoundID;

@property (assign, nonatomic) SystemSoundID crunchSoundID;
@end

@implementation CustomPickerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.winLabel.text = @" ";
    
    self.images = @[[UIImage imageNamed:@"seven"],
                    [UIImage imageNamed:@"bar"],
                    [UIImage imageNamed:@"crown"],
                    [UIImage imageNamed:@"cherry"],
                    [UIImage imageNamed:@"lemon"],
                    [UIImage imageNamed:@"apple"]];
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender {
    
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; i++) {
        int newValue = random() % (uint)[self.images count];
        
        if (newValue == lastVal) {
            numInRow++;
        } else {
            numInRow = 1;
        }
        
        lastVal = newValue;
        
        [self.picker selectRow:newValue inComponent: i animated: YES];
        [self.picker reloadComponent:i];
        
        if (numInRow >= 3) {
            win = YES;
        }
    }
    
    if (_crunchSoundID == 0) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"crunch" ofType:@"wav"];
        NSURL *soundUrl = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &_crunchSoundID);
    }
    
    AudioServicesPlaySystemSound(_crunchSoundID);
    if (win) {
        [self performSelector:@selector(playWithSound) withObject:nil afterDelay:.5];
    } else {
        [self performSelector:@selector(showButton) withObject:nil afterDelay:.5];
    }
    
    self.button.hidden = YES;
    self.winLabel.text = @" ";
}

- (void)showButton {
    self.button.hidden = NO;
}

- (void)playWithSound {
    
    if (_winSoundID == 0) {
        NSURL *soundUrl = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &_winSoundID);
    }
    AudioServicesPlaySystemSound(_winSoundID);
    self.winLabel.text = @"WINNER";
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1.5];
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.images count];
}

#pragma mark Picker Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UIImage *image = self.images[row];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    
    return imageView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 64;
}
@end
