//
//  JRImagePicker.h
//  CameraLapTimer
//
//  Created by Jaben on 15-1-14.
//  Copyright (c) 2015年 Jaben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^JRImagePickerImageBlock)(UIImage *image);

@interface JRImagePicker : NSObject


//4 iPad:
@property (nonatomic, assign) UIModalPresentationStyle presentStyle;

//if presentStyle does NOT UIModalPresentationFullScreen, popAtView can not be nil;
//JRImagePicker will be poped at popAtView;
@property (nonatomic, strong) UIView *popAtView;

+ (instancetype)shareManager;
    
- (void)launchImagePickerIn:(UIViewController *)controller sourceType:(UIImagePickerControllerSourceType)type completionHandler:(JRImagePickerImageBlock)completed;
    
@end
