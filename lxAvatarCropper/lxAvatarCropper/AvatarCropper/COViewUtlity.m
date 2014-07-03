//
//  COViewUtlity.m
//  lxScrollView
//
//  Created by houzhenyong on 14-6-21.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import "COViewUtlity.h"

@implementation COViewUtlity

// 缩小或放大originalSize到constrainedSize，保持原来的长宽比不变。
+ (CGSize)sizeScaledWithRawSize:(CGSize)rawSize constrainedSize:(CGSize)constrainedSize
{
    CGFloat scaleRatio = MAX(rawSize.width / constrainedSize.width, rawSize.height / constrainedSize.height);
    return CGSizeMake(rawSize.width / scaleRatio, rawSize.height / scaleRatio);
}

@end
