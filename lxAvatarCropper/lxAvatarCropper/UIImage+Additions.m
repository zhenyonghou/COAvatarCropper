//
//  UIImage+Additions.m
//
//  Created by houzhenyong on 14-3-15.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

static CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}
static CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;}

+ (UIImage *)rotateToOrientationUpImage:(UIImage *)image
{
    int width = image.size.width;
    int height = image.size.height;
    CGSize size = CGSizeMake(width, height);
    
    CGRect imageRect;
    
    if(image.imageOrientation==UIImageOrientationUp
       || image.imageOrientation==UIImageOrientationDown)
    {
        imageRect = CGRectMake(0, 0, width, height);
    }
    else
    {
        imageRect = CGRectMake(0, 0, height, width);
    }
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0, height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    if(image.imageOrientation==UIImageOrientationLeft)
    {
        CGContextRotateCTM(context, M_PI / 2);
        CGContextTranslateCTM(context, 0, -width);
    }
    else if(image.imageOrientation==UIImageOrientationRight)
    {
        CGContextRotateCTM(context, - M_PI / 2);
        CGContextTranslateCTM(context, -height, 0);
    }
    else if(image.imageOrientation==UIImageOrientationUp)
    {
        //DO NOTHING
    }
    else if(image.imageOrientation==UIImageOrientationDown)
    {
        CGContextTranslateCTM(context, width, height);
        CGContextRotateCTM(context, M_PI);
    }
    
    CGContextDrawImage(context, imageRect, image.CGImage);
    CGContextRestoreGState(context);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return (img);
}

+ (UIImage*)cropImage:(UIImage *)originalImage toRect:(CGRect)rect
{
    if (!originalImage) {
        return nil;
    }

    CGImageRef imageRef = originalImage.CGImage;
    if (!imageRef) {
        imageRef = [[self class] imageFromCIImage:originalImage.CIImage].CGImage;
    }

    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));

    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();

    CGImageRelease(subImageRef);
    return smallImage;
}

+ (UIImage*)imageFromCIImage:(CIImage*)ciImage {
    CGSize size = ciImage.extent.size;
    UIGraphicsBeginImageContext(size);
    CGRect rect;
    rect.origin = CGPointZero;
    rect.size   = size;
    UIImage *remImage = [UIImage imageWithCIImage:ciImage];
    [remImage drawInRect:rect];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    remImage = nil;
    ciImage = nil;
    //
    return result;
}

+ (UIImage *)scaleImage:(UIImage *)sourceImage toSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
   
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    //   CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    return newImage ;
}

+ (UIImage *)rotateImage:(UIImage *)image degrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
//    [rotatedViewBox release];
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)rotateImage:(UIImage *)image radians:(CGFloat)radians
{
    return [[self class] rotateImage:image degrees:RadiansToDegrees(radians)];
}

@end
