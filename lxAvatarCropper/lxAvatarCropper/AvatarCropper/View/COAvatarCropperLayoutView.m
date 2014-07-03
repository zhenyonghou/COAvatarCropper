//
//  COcropLayoutView.m
//  LxAsset
//
//  Created by houzhenyong on 14-6-23.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import "COAvatarCropperLayoutView.h"
#import "COAvatarCropperImageScrollView.h"
#import "COAvatarCropperOverlayView.h"
#import "COViewUtlity.h"

#define SCALE_FRAME_Y 100.0f
#define BOUNDCE_DURATION 0.3f

@interface COAvatarCropperLayoutView() {
    COAvatarCropperImageScrollView *_imageScrollView;
    COAvatarCropperOverlayView *_cropOverlayView;
}

@property (nonatomic, assign) CGRect latestFrame;

@end

@implementation COAvatarCropperLayoutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageScrollView = [[COAvatarCropperImageScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:_imageScrollView];

        _cropOverlayView = [[COAvatarCropperOverlayView alloc] initWithFrame:self.bounds];
        _cropOverlayView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        CGFloat coverWidth = self.frame.size.width - 10 * 2;
        CGFloat coverHeight = coverWidth;
        _cropOverlayView.coverFrame = CGRectMake(10, (_cropOverlayView.frame.size.height - coverHeight) / 2, coverWidth, coverHeight);

        [_cropOverlayView setMaskColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        [self addSubview:_cropOverlayView];
    }
    return self;
}

- (void)setDisplayImage:(UIImage*)image
{
    [_imageScrollView setDisplayImage:image avatarArea:_cropOverlayView.coverFrame];
}

- (UIImage*)cropImage
{
    return [_imageScrollView cropImageAtAvatarArea];
}

- (void)onTesting
{
    [_imageScrollView onTesting];
}

@end
