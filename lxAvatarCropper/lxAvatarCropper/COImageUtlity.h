//
//  COImageUtlity.h
//  lxAvatarCropper
//
//  Created by houzhenyong on 14-7-3.
//  Copyright (c) 2014年 houzhenyong. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat kSuperImageRatio;          // 超宽和超长图片的最大比例
extern const CGFloat kHDImageMaxHeight;         // 高清图片最大的高度 (超大图片)
extern const CGFloat kHDImageMaxLength;         // 高清图片最大的长度（长度和宽度）
extern const CGFloat kNormalImageMaxLength;     // 普通图片最大的长度 (长度和宽度)
extern const CGFloat kImageCompressionValue;    // 图片上传的压缩比例


@interface COImageUtlity : NSObject

+ (UIImage *)scaleAndRotateImage:(UIImage *)image size:(NSInteger)size;

@end
