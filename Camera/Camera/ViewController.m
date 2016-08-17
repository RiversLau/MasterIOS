//
//  ViewController.m
//  Camera
//
//  Created by LiuRivers on 16/8/16.
//  Copyright © 2016年 ShowTime. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSURL *movieUrl;

@property (strong, nonatomic) NSString *lastChoseMediaType;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.takePictureButton.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)updateDisplay {
    
    if ([self.lastChoseMediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        
        self.moviePlayerController.view.hidden = YES;
    } else if ([self.lastChoseMediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        if (self.moviePlayerController == nil) {
            
            self.moviePlayerController = [[MPMoviePlayerController alloc]initWithContentURL:self.movieUrl];
            
            UIView *movieView = self.moviePlayerController.view;
            movieView.frame = self.imageView.frame;
            movieView.clipsToBounds = YES;
            [self.view addSubview:movieView];
            [self setMoviePlayerLayoutConstraints];
        } else {
            self.moviePlayerController.contentURL = self.movieUrl;
        }
    }
    
    self.imageView.hidden = YES;
    self.moviePlayerController.view.hidden = NO;
    [self.moviePlayerController play];
}

- (void)setMoviePlayerLayoutConstraints {
    
    UIView *moviePlayerView = self.moviePlayerController.view;
    UIView *takePictureButton = self.takePictureButton;
    moviePlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(moviePlayerView, takePictureButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[moviePlayerView]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[moviePlayerView]-0-[takePictureButton]" options:0 metrics:nil views:views]];
}

- (IBAction)shootPictureOrVideo:(UIButton *)sender {
    
    [self pickerMediaFromResource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectExistingPictureOrVideo:(UIButton *)sender {
    
    [self pickerMediaFromResource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)pickerMediaFromResource:(UIImagePickerControllerSourceType)sourceType {
    
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error accessing media" message:@"Unsupported media type" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.lastChoseMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChoseMediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.image = info[UIImagePickerControllerEditedImage];
    } else if ([self.lastChoseMediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        self.movieUrl = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
