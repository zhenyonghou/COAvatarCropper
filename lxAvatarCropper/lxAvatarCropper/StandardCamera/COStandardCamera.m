

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIImagePickerController.h>
#import "COStandardCamera.h"
#import "COImageUtlity.h"

@interface COStandardCamera ()

@end

@implementation COStandardCamera

- (id)init
{
    if (self = [super init]) {
        _cameraOrientation = kCameraOrientationRear;
    }

    return self;
}

- (void)showCameraInViewController:(UIViewController *)controller animated:(BOOL)animated
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (!_pickerController) {
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            [pickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            pickerController.delegate = self;
            if (_cameraOrientation == kCameraOrientationRear) {
                pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear; // 后置摄像头
            }
            else
            {
                pickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront; // 前置摄像头
            }

            _pickerController = pickerController;
            _pickerController.view.backgroundColor = [UIColor blackColor];
        }
        [controller presentViewController:_pickerController animated:animated completion:nil];
    }
}

- (void)dismissCameraWithAnimated:(BOOL)animated
{
    [_pickerController dismissViewControllerAnimated:animated completion:^{
        _pickerController = nil;
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if( picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        CGFloat max = kHDImageMaxLength;
        image = [COImageUtlity scaleAndRotateImage:image size:max];
        
        __strong id<COStandardCameraDelegate> strongDelegate = self.delegate;
        if (strongDelegate && [strongDelegate respondsToSelector:@selector(cameraController:didFinishWithImage:)]) {
            [strongDelegate performSelector:@selector(cameraController:didFinishWithImage:) withObject:picker withObject:image];
        }
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        NSMutableDictionary *originMetadata = [info valueForKey:UIImagePickerControllerMediaMetadata];
        NSMutableDictionary *mutableMetadata = [NSMutableDictionary dictionary];
        if ([originMetadata objectForKey:@"{Exif}"]) {
            [mutableMetadata setValue:[originMetadata objectForKey:@"{Exif}"] forKey:@"{Exif}"];
        }
        if ([originMetadata objectForKey:@"{TIFF}"]) {
            [mutableMetadata setValue:[originMetadata objectForKey:@"{TIFF}"] forKey:@"{TIFF}"];
        }
        if ([originMetadata objectForKey:@"{GPS}"]) {
            [mutableMetadata setValue:[originMetadata objectForKey:@"{GPS}"] forKey:@"{GPS}"];
        }

        [library writeImageToSavedPhotosAlbum:[image CGImage]
                                     metadata:mutableMetadata
                              completionBlock:^(NSURL *assetURL, NSError *error) {
                                  if (!error) {
                                      if (strongDelegate && [strongDelegate respondsToSelector:@selector(cameraControllerDidFinishSaveMetaData:)]) {
                                          [strongDelegate cameraControllerDidFinishSaveMetaData:picker];
                                      }
                                  }
                              }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    __strong id<COStandardCameraDelegate> strongDelegate = self.delegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(cameraControllerDidCancel:)]) {
        [strongDelegate cameraControllerDidCancel:picker];
    }
}

@end
