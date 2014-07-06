//
//  COAvatarCropManager.m
//  lxAvatarCropper
//
//  Created by houzhenyong on 14-7-3.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import "COAvatarCropComponent.h"
#import "COStandardCamera.h"
#import "COAvatarCropperViewController.h"

@interface COAvatarCropComponent()<
COAvatarCropperViewControllerDelegate
, UINavigationControllerDelegate
, UIImagePickerControllerDelegate
, COStandardCameraDelegate>

@property (nonatomic, strong) COStandardCamera *cameraManager;

@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) COAvatarCropperViewController *avatarCropperViewController;

@property (nonatomic, weak) UIViewController* parentController;
@property (nonatomic, assign) COAvatarCropControllerSourceType controllerSourceType;

@end


@implementation COAvatarCropComponent

- (void)showInViewController:(UIViewController*)viewController controllerSourceType:(COAvatarCropControllerSourceType)controllerSourcetype
{
    self.parentController = viewController;
    self.controllerSourceType = controllerSourcetype;
    
    if (self.controllerSourceType == kAvatarCropControllerSourceTypeCamerera) {
        if (!self.cameraManager) {
            self.cameraManager = [[COStandardCamera alloc] init];
            self.cameraManager.delegate = self;
        }
        [self.cameraManager showCameraInViewController:self.parentController animated:YES];
    } else if (self.controllerSourceType == kAvatarCropControllerSourceTypePhotosAlbum) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.delegate = self;
        self.imagePickerController = imagePickerController;
        [self.parentController presentViewController:self.imagePickerController animated:YES completion:nil];
    }
}

- (void)showAvatarCropViewControllerInViewController:(UINavigationController*)pickerController withImage:(UIImage*)image
{
    if (!self.avatarCropperViewController) {
        self.avatarCropperViewController = [[COAvatarCropperViewController alloc] init];
        self.avatarCropperViewController.delegate = self;
    }
    self.avatarCropperViewController.displayImage = image;
    [pickerController pushViewController:_avatarCropperViewController animated:YES];
}

#pragma mark- COStandardCameraDelegate

- (void)cameraController:(UIViewController *)controller didFinishWithImage:(UIImage *)image
{
    [self showAvatarCropViewControllerInViewController:self.cameraManager.pickerController withImage:image];
}

- (void)cameraControllerDidCancel:(UIViewController *)controller
{
    [self.cameraManager dismissCameraWithAnimated:NO];
    self.avatarCropperViewController = nil;
    
    [self.delegate avatarCropDidCancel];
}

#pragma mark- COAvatarCropperViewControllerDelegate

- (void)croppedImage:(UIImage*)image {
    if (self.controllerSourceType == kAvatarCropControllerSourceTypeCamerera) {
        [self.cameraManager dismissCameraWithAnimated:YES];
    } else if (self.controllerSourceType == kAvatarCropControllerSourceTypePhotosAlbum) {
        [self.parentController dismissViewControllerAnimated:YES completion:nil];
    }
    self.avatarCropperViewController = nil;
    
    [self.delegate croppedImage:image];
}

#pragma mark- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self showAvatarCropViewControllerInViewController:picker withImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.imagePickerController dismissViewControllerAnimated:YES completion:^{
        [self.delegate avatarCropDidCancel];
    }];
}

@end
