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
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UIImageView *preImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)selectImageButtonAction:(id)sender {
    __weak __typeof(self) weakSelf = self;
    JRImagePicker.shareManager.popAtView = self.selectImageButton;
    JRImagePicker.shareManager.presentStyle = UIModalPresentationPopover;
    [JRImagePicker.shareManager loadImageFromPhotoLibrary:self
                                              completionHandler:^(UIImage *image) {
                                                  weakSelf.preImageView.image = image;
                                              }];
//    [JRImagePicker.shareManager loadImageFromiPhonePhotoAlbum:self completionHandler:^(UIImage *image) {
//        weakSelf.preImageView.image = image;
//    }];
}



@end
