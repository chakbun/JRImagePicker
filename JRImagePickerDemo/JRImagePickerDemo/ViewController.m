//
//  ViewController.m
//  JRImagePickerDemo
//
//  Created by Wonder on 2019/8/29.
//  Copyright © 2019 Zach. All rights reserved.
//

#import "ViewController.h"
#import "JRImagePicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *libraryButton;
@property (weak, nonatomic) IBOutlet UIImageView *preImageView;
@property (weak, nonatomic) IBOutlet UIButton *albumnButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)selectImageButtonAction:(id)sender {
    __weak __typeof(self) weakSelf = self;
    JRImagePicker.shareManager.popAtView = (UIButton *)sender;
    JRImagePicker.shareManager.presentStyle = UIModalPresentationPopover;
    if (sender == self.libraryButton) {
        [JRImagePicker.shareManager launchImagePickerIn:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary completionHandler:^(UIImage *image) {
            weakSelf.preImageView.image = image;
        }];
    }else if(sender == self.albumnButton) {
        [JRImagePicker.shareManager launchImagePickerIn:self sourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum completionHandler:^(UIImage *image) {
            weakSelf.preImageView.image = image;
        }];
    }else {
        [JRImagePicker.shareManager launchImagePickerIn:self sourceType:UIImagePickerControllerSourceTypeCamera completionHandler:^(UIImage *image) {
            weakSelf.preImageView.image = image;
        }];
    }

}



@end
