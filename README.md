# JRImagePicker 
is encapsulation of UIImageUIImagePickerController ans UIImagePickerControllerDelegate.
You can get image from camera simply like this, 
```
[JRImagePicker.shareManager launchImagePickerIn:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary completionHandler:^(UIImage *image) {
    //TODO:do something with image;
}];
```
> You must add NSCameraUsageDescription in info.plist if you want to get image from camera;

