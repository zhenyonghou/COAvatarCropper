//
//  COAvatarCropComponent.h
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

@protocol COAvatarCropComponentDelegate;

@interface COAvatarCropComponent : NSObject

@property (nonatomic, weak) id<COAvatarCropComponentDelegate> delegate;

- (void)showInViewController:(UIViewController*)viewController controllerSourceType:(COAvatarCropControllerSourceType)controllerSourcetype;

@end


@protocol COAvatarCropComponentDelegate <NSObject>

- (void)croppedImage:(UIImage*)image;

- (void)avatarCropDidCancel;

@end
