//
//  COFakeNavigationBar.m
//  LxAsset
//
//  Created by houzhenyong on 14-7-1.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#define kButtonItemWidth    60

#import "COFakeNavigationBar.h"

@implementation COFakeNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitleLabel:(UILabel *)titleLabel
{
    if (_titleLabel) {
        [_titleLabel removeFromSuperview];
    }
    _titleLabel = titleLabel;
    [self addSubview:_titleLabel];
}

- (void)setBackButton:(UIButton *)backButton
{
    if (_backButton) {
        [_backButton removeFromSuperview];
    }
    _backButton = backButton;
    [self addSubview:_backButton];
}

- (void)setRightButton:(UIButton *)rightButton
{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightButton = rightButton;
    [self addSubview:_rightButton];
}

- (void)layoutSubviews
{
    if (self.titleLabel) {
        [self.titleLabel sizeToFit];
        self.titleLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    }
    
    if (self.backButton) {
        self.backButton.frame = CGRectMake(0, 0, kButtonItemWidth, self.bounds.size.height);
    }
    
    if (self.rightButton) {
        self.rightButton.frame = CGRectMake(self.bounds.size.width - kButtonItemWidth, 0, kButtonItemWidth, self.bounds.size.height);
    }
}

@end
