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
    });
    return shareManager;
}

#pragma mark --Public

- (void)loadImageFromiPhoneCamera:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed {
    [self loadImagePickerOnController:controller type:UIImagePickerControllerSourceTypeCamera completionHandler:completed];
}

- (void)loadImageFromiPhonePhotoLibrary:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed {
    [self loadImagePickerOnController:controller type:UIImagePickerControllerSourceTypePhotoLibrary completionHandler:completed];
}

- (void)loadImageFromiPhonePhotoAlbum:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed {
    [self loadImagePickerOnController:controller type:UIImagePickerControllerSourceTypeSavedPhotosAlbum completionHandler:completed];
}

#pragma mark --Misc

- (void)loadImagePickerOnController:(UIViewController *)controller type:(UIImagePickerControllerSourceType)type completionHandler:(JRImagePickerImageBlock)completed {
    self.rootController = controller;
    self.imageBlock = completed;
    [self loadImagePick:type];
}

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
                [self.rootController presentViewController:imagePicker animated:YES completion:^{}];
            }
            break;
        }
        case UIImagePickerControllerSourceTypeSavedPhotosAlbum:{
            [imagePicker setSourceType:sourceType];
            [imagePicker setAllowsEditing:NO];
            [self.rootController presentViewController:imagePicker animated:YES completion:^{}];
            break;
        }
        case UIImagePickerControllerSourceTypePhotoLibrary:{
            [imagePicker setSourceType:sourceType];
            [imagePicker setAllowsEditing:NO];
            [self.rootController presentViewController:imagePicker animated:YES completion:^{}];
            break;
        }
        default:
            break;
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
