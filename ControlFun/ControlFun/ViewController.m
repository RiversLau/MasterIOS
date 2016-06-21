//
//  ViewController.m
//  ControlFun
//
//  Created by shine-team2 on 16/6/21.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (weak, nonatomic) IBOutlet UITextField *numberField;

@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;

@property (weak, nonatomic) IBOutlet UISwitch *leftSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *rightSwitch;

@property (weak, nonatomic) IBOutlet UIButton *doSomethingButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sliderLabel.text = @"50";
}

- (IBAction)textFieldDoneEditing:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)backgoundTap:(id)sender
{
    [self.nameField resignFirstResponder];
    [self.numberField resignFirstResponder];
}

- (IBAction)sliderChanged:(UISlider *)sender
{
    int progress = (int)lround(sender.value);
    self.sliderLabel.text = [NSString stringWithFormat:@"%d", progress];
}

- (IBAction)switchChanged:(UISwitch *)sender
{
    BOOL setting = sender.isOn;
    [self.leftSwitch setOn:setting animated: YES];
    [self.rightSwitch setOn:setting animated: YES];
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"Are you sure?" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
   
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yew, I'm sure!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *msg;
        if ([self.nameField.text length] > 0) {
            msg = [NSString stringWithFormat: @"You can breathe easy, %@, everything went OK.", self.nameField.text];
        } else {
            msg = @"You can breathe easy, everything went OK.";
        }
        
        UIAlertController *alertCtrl2 = [UIAlertController alertControllerWithTitle:@"Something Was Done" message: msg preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Phew" style:UIAlertActionStyleCancel handler: nil];
        [alertCtrl2 addAction: cancelAction];
        
        [self presentViewController: alertCtrl2 animated: YES completion: nil];
    }];
    
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way!" style:UIAlertActionStyleCancel handler:nil];
    
    [alertCtrl addAction: yesAction];
    [alertCtrl addAction: noAction];
    
    UIPopoverPresentationController *ppc = alertCtrl.popoverPresentationController;
    if (ppc != nil) {
        ppc.sourceView = sender;
        ppc.sourceRect = sender.bounds;
    }
    
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
- (IBAction)toggleControls:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.leftSwitch.hidden = NO;
        self.rightSwitch.hidden = NO;
        self.doSomethingButton.hidden = YES;
    } else {
        self.leftSwitch.hidden = YES;
        self.rightSwitch.hidden = YES;
        self.doSomethingButton.hidden = NO;
    }
}
@end
