//
//  COcropCoverView.h
//  LxAsset
//
//  Created by houzhenyong on 14-6-23.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COAvatarCropperOverlayView : UIView {
    CAShapeLayer *_invertedLayer;
}

@property (nonatomic, assign) CGRect coverFrame; // coverview在COcropCoverView里的位置

- (void)setMaskColor:(UIColor*)maskColor;

@end
