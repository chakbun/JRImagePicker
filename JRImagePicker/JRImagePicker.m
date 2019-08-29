//
//  JRImagePicker.m
//  CameraLapTimer
//
//  Created by Jaben on 15-1-14.
//  Copyright (c) 2015年 Jaben. All rights reserved.
//

#import "JRImagePicker.h"

@interface JRImagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIImagePickerController *imagePicker;
}

@property (nonatomic, strong) UIViewController *rootController;
@property (nonatomic, strong) JRImagePickerImageBlock imageBlock;

@end

@implementation JRImagePicker

+ (instancetype)shareManager {
    static JRImagePicker *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[[JRImagePicker alloc] init];
        shareManager.presentStyle = UIModalPresentationFullScreen;
    });
    return shareManager;
}

#pragma mark --Public
    
- (void)launchImagePickerIn:(UIViewController *)controller sourceType:(UIImagePickerControllerSourceType)type completionHandler:(JRImagePickerImageBlock)completed {
    self.rootController = controller;
    self.imageBlock = completed;
    [self loadImagePick:type];
}

#pragma mark --Misc

- (void)loadImagePick:(UIImagePickerControllerSourceType)sourceType {
    
    if (!imagePicker) {
        imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
    }
    
    switch (sourceType) {
        case UIImagePickerControllerSourceTypeCamera:{
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                [imagePicker setSourceType:sourceType];
                [imagePicker setAllowsEditing:NO];
                imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                [self.rootController presentViewController:imagePicker animated:YES completion:^{}];
            }
            break;
        }
        default: {
            [imagePicker setSourceType:sourceType];
            [imagePicker setAllowsEditing:NO];
            imagePicker.modalPresentationStyle = self.presentStyle;
            if (self.popAtView && imagePicker.modalPresentationStyle != UIModalPresentationFullScreen) {
                imagePicker.popoverPresentationController.barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.popAtView];
            }
            [self.rootController presentViewController:imagePicker animated:YES completion:^{}];
            break;
        }
    }
}


#pragma mark --ImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
#ifdef DEBUG
    NSLog(@"============ didFinishPickingMediaWithInfo ============");
    NSLog(@"info : %@",[info description]);
#endif
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (self.imageBlock) {
            self.imageBlock(image);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
#ifdef DEBUG
    NSLog(@"============ imagePickerControllerDidCancel ============");
#endif
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
@end
