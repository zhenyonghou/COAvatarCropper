//
//  COcropCoverView.m
//  LxAsset
//
//  Created by houzhenyong on 14-6-23.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import "COAvatarCropperOverlayView.h"

#define kLeftMargin     5

@implementation COAvatarCropperOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _invertedLayer = [CAShapeLayer layer];
        [_invertedLayer setFillRule:kCAFillRuleEvenOdd];
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setMaskColor:(UIColor*)maskColor
{
    if (!_invertedLayer.superlayer) {
        [self.layer addSublayer:_invertedLayer];
    }
    [_invertedLayer setFillColor:[maskColor CGColor]];
}

- (void)drawRect:(CGRect)rect
{
//    CGFloat coverWidth = self.frame.size.width - kLeftMargin * 2;
//    CGFloat coverHeight = coverWidth;
//    
//    _coverFrame = CGRectMake(kLeftMargin, (self.frame.size.height - coverHeight) / 2, coverWidth, coverHeight);

    CGRect circleFrame = _coverFrame; // CGRectInset(_coverFrame, 1, 1);

    CGMutablePathRef path = CGPathCreateMutable();
    // draw circle
    CGPoint circleCenter = CGPointMake(circleFrame.origin.x + circleFrame.size.width / 2,
                                       circleFrame.origin.y + circleFrame.size.height / 2);
    CGFloat radius = MIN(circleFrame.size.width, circleFrame.size.height)/2;

    CGPathAddArc(path, NULL, circleCenter.x, circleCenter.y, radius, 0, 2 * M_PI, true);

    // draw rect
    CGRect rectangle = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, rectangle);


    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddPath(context, path);
    
    [[UIColor clearColor] setFill];
    [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] setStroke];
    
    CGContextDrawPath(context, kCGPathFillStroke);

    [_invertedLayer setPath:path];
    
    CGPathRelease(path);
}

@end
