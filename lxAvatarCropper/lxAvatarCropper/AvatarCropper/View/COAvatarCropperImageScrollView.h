//
//  lxScrollView
//
//  Created by houzhenyong on 14-6-21.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COAvatarCropperImageScrollView : UIScrollView <UIScrollViewDelegate> {
    CGRect _avatarArea;
}

@property (nonatomic, strong, readonly) UIImageView *displayImageView;

//- (void)setDisplayImage:(UIImage*)image;

- (void)setDisplayImage:(UIImage*)image avatarArea:(CGRect)avatarArea;

- (UIImage*)cropImageAtAvatarArea;

- (void)onTesting;

@end
