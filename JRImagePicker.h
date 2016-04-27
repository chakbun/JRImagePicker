//
//  JRImagePicker.h
//  CameraLapTimer
//
//  Created by Jaben on 15-1-14.
//  Copyright (c) 2015年 xpg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JRImagePickerImageBlock)(UIImage *image);

@interface JRImagePicker : NSObject

+ (instancetype)shareManager;
- (void)loadImageFromiPhoneCamera:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed;
- (void)loadImageFromiPhonePhotoLibrary:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed;
- (void)loadImageFromiPhonePhotoAlbum:(UIViewController *)controller completionHandler:(JRImagePickerImageBlock)completed;
@end
