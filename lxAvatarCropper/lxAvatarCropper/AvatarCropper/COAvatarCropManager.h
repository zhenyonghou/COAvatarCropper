//
//  COAvatarCropManager.h
//  lxAvatarCropper
//
//  Created by houzhenyong on 14-7-3.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, COAvatarCropControllerSourceType) {
    kAvatarCropControllerSourceTypeCamerera = 0,
    kAvatarCropControllerSourceTypePhotosAlbum
};

@protocol COAvatarCropManagerDelegate;

@interface COAvatarCropManager : NSObject

@property (nonatomic, weak) id<COAvatarCropManagerDelegate> delegate;

- (void)showInViewController:(UIViewController*)viewController controllerSourceType:(COAvatarCropControllerSourceType)controllerSourcetype;

@end

@protocol COAvatarCropManagerDelegate <NSObject>

- (void)avatarCropDidCancel;

- (void)croppedImage:(UIImage*)image;

@end
