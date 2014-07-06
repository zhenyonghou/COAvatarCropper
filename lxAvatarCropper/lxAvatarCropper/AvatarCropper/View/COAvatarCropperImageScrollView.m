//
//  lxScrollView
//
//  Created by houzhenyong on 14-6-21.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import "COAvatarCropperImageScrollView.h"
#import "COViewUtlity.h"
#import "UIImage+Additions.h"

static CGFloat kImageViewMinimumZoomScale   = 1.0;
static CGFloat kImageViewMaximumZoomScale   = 2.5;

@interface COAvatarCropperImageScrollView()

@property (nonatomic, strong) UIImageView *previewImageView;

@end

@implementation COAvatarCropperImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = YES;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;      // 当点击statusbar的时候不让滚动到top
        self.decelerationRate = UIScrollViewDecelerationRateFast;

        self.minimumZoomScale = kImageViewMinimumZoomScale;
        self.maximumZoomScale = kImageViewMaximumZoomScale;
        
        self.backgroundColor = [UIColor clearColor];
        
        _displayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_displayImageView];
    }
    return self;
}

- (void)setDisplayImage:(UIImage*)image avatarArea:(CGRect)avatarArea
{
    _avatarArea = avatarArea;
    self.displayImageView.image = image;
    
    self.contentInset = UIEdgeInsetsMake(avatarArea.origin.y,
                                         avatarArea.origin.x,
                                         self.bounds.size.height - CGRectGetMaxY(avatarArea),
                                         self.bounds.size.width - CGRectGetMaxX(avatarArea));
    
    [self layoutScrollViewAnimated:NO];
}

- (UIImage*)cropImageAtAvatarArea
{
    CGRect cropRectForImageView = CGRectMake(_avatarArea.origin.x + self.contentOffset.x,
                                             _avatarArea.origin.y + self.contentOffset.y,
                                             _avatarArea.size.width,
                                             _avatarArea.size.height);
    
    CGFloat offsetXRate = (self.contentInset.left + self.contentOffset.x) / self.contentSize.width;
    CGFloat offsetYRate = (self.contentInset.top + self.contentOffset.y) / self.contentSize.height;
    CGFloat widthRate = cropRectForImageView.size.width / _displayImageView.frame.size.width;
    CGFloat heightRate = cropRectForImageView.size.height / _displayImageView.frame.size.height;

    // 截取
    CGSize imageSize = self.displayImageView.image.size;
    CGRect cropRect = CGRectMake(imageSize.width * offsetXRate,
                                 imageSize.height * offsetYRate,
                                 imageSize.width * widthRate,
                                 imageSize.height * heightRate);
    
    UIImage *originalImage = self.displayImageView.image;
    UIImageOrientation orientation = originalImage.imageOrientation;
    NSLog(@"image orientation0 = %d", orientation);

    UIImage* orientationUpImage = [UIImage rotateToOrientationUpImage:originalImage];
    
    UIImage* cropedImage = [UIImage cropImage:orientationUpImage toRect:cropRect];
    
    return [UIImage scaleImage:cropedImage toSize:CGSizeMake(150, 150)];
}

// 恢复到铺满view大小
- (void)layoutScrollViewAnimated:(BOOL)animated {
    if (!self.displayImageView.image) {
        return;
    }

    if (animated) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.1];
    }

    CGSize newImageSize = [COViewUtlity sizeScaledWithRawSize:self.displayImageView.image.size constrainedSize:self.bounds.size];
    
    self.displayImageView.frame = CGRectMake((_avatarArea.size.width - newImageSize.width)/2,
                                             (_avatarArea.size.height - newImageSize.height)/2,
                                             newImageSize.width,
                                             newImageSize.height);
    
    self.contentSize = CGSizeMake(newImageSize.width, newImageSize.height);
    [self resetContentSize];

    if (animated) {
        [UIView commitAnimations];
    }
}

- (void)onTesting
{
    CGRect imageRect = self.displayImageView.frame;
    
    NSLog(@"imageViewFrame:[%d, %d, %d, %d]", (int)imageRect.origin.x, (int)imageRect.origin.y, (int)imageRect.size.width, (int)imageRect.size.height);

//    NSLog(@"imageSize=[%d, %d]", (int)self.displayImageView.image.size.width, (int)self.displayImageView.image.size.height);
    
    NSLog(@"contentSize=[%d, %d]", (int)self.contentSize.width, (int)self.contentSize.height);
    NSLog(@"contentOffset=[%d, %d]", (int)self.contentOffset.x, (int)self.contentOffset.y);
    
    NSLog(@"contentInset:[%d, %d, %d, %d]", (int)self.contentInset.top, (int)self.contentInset.left, (int)self.contentInset.bottom, (int)self.contentInset.right);
    
//    NSLog(@"avatar area=[%d, %d, %d, %d]", (int)_avatarArea.origin.x, (int)_avatarArea.origin.y, (int)_avatarArea.size.width, (int)_avatarArea.size.height);
    
    [self cropImageAtAvatarArea];
}

#pragma mark - Zoom methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.displayImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self resetContentSize];
}

- (void)resetContentSize
{
    CGFloat offsetX = (_avatarArea.size.width > self.contentSize.width) ? (_avatarArea.size.width - self.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (_avatarArea.size.height > self.contentSize.height) ? (_avatarArea.size.height - self.contentSize.height) * 0.5 : 0.0;
    
    self.displayImageView.center = CGPointMake(self.contentSize.width * 0.5 + offsetX, self.contentSize.height * 0.5 + offsetY);
}

@end
