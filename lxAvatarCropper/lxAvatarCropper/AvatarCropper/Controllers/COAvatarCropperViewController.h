//
//  COcropImageViewController.h
//  LxAsset
//
//  Created by houzhenyong on 14-6-23.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol COAvatarCropperViewControllerDelegate;

@interface COAvatarCropperViewController : UIViewController

@property (nonatomic, strong) UIImage *displayImage;

@property (nonatomic, weak) id<COAvatarCropperViewControllerDelegate>delegate;

@end

@protocol COAvatarCropperViewControllerDelegate <NSObject>

- (void)croppedImage:(UIImage*)image;

@end
