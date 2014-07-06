//
//  UIImage+Additions.h
//
//  Created by houzhenyong on 14-3-15.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color;

// 相机拍的照片处理前先过此函数
+ (UIImage *)rotateToOrientationUpImage:(UIImage *)image;

// 截取部分图
+ (UIImage*)cropImage:(UIImage *)originalImage toRect:(CGRect)rect;

// 缩放
+ (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)targetSize;

// 旋转
+ (UIImage *)rotateImage:(UIImage *)image radians:(CGFloat)radians;

+ (UIImage *)rotateImage:(UIImage *)image degrees:(CGFloat)degrees;

+ (UIImage*)imageFromCIImage:(CIImage*)ciImage;

@end
