//
//  COcropImageViewController.m
//  LxAsset
//
//  Created by houzhenyong on 14-6-23.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import "COAvatarCropperViewController.h"
#import "COAvatarCropperLayoutView.h"
#import "UIImage+Additions.h"
#import "COFakeNavigationBar.h"

@interface COAvatarCropperViewController () <UIScrollViewDelegate> {
    COAvatarCropperLayoutView *_layoutView;
    UIToolbar *_toolbar;
}

@property (nonatomic, strong) COFakeNavigationBar *fakeNavigationBar;

@end

@implementation COAvatarCropperViewController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    _layoutView = [[COAvatarCropperLayoutView alloc] initWithFrame:self.view.bounds];
    _layoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_layoutView setDisplayImage:_displayImage];
    [self.view addSubview:_layoutView];

    [self setupFakeNavigationBar];
    [self buildToolbar];
}

- (void)setDisplayImage:(UIImage *)displayImage
{
    _displayImage = displayImage;
    if (_layoutView) {
        [_layoutView setDisplayImage:_displayImage];
    }
}

- (void)setupFakeNavigationBar
{
    self.fakeNavigationBar = [[COFakeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    self.fakeNavigationBar.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [self.view addSubview:self.fakeNavigationBar];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self action:@selector(onBackButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    [backButton setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    self.fakeNavigationBar.backButton = backButton;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = @"移动和缩放";
    self.fakeNavigationBar.titleLabel = titleLabel;
}

- (void)setTopBarsHidden:(BOOL)hidden
{
    [[UIApplication sharedApplication] setStatusBarHidden:hidden withAnimation:UIStatusBarAnimationNone];
    [self.navigationController setNavigationBarHidden:hidden animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTopBarsHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTopBarsHidden:NO];
}

- (void)onBackButtonTouched
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buildToolbar
{
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 44)];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [toolBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]]
             forToolbarPosition:UIBarPositionBottom
                     barMetrics:UIBarMetricsDefault];

    CGFloat buttonHeight = 26;
    UIButton* completeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, (44 - buttonHeight)/2, 52, buttonHeight)];
    [completeButton setTitle:@"确定" forState:UIControlStateNormal];
    [completeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    completeButton.backgroundColor = [UIColor blueColor];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    [completeButton addTarget:self action:@selector(onComplete) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* completeButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeButton];

    UIBarButtonItem *btnPlace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // testing
    UIButton* testButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 3, 52, 44 - 6)];
    [testButton setTitle:@"测试" forState:UIControlStateNormal];
    [testButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [testButton addTarget:self action:@selector(onTesting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* testButtonItem = [[UIBarButtonItem alloc] initWithCustomView:testButton];
    
    NSArray* items = @[testButtonItem, btnPlace, completeButtonItem];
    
    [toolBar setItems:items];
    
    _toolbar = toolBar;
    [self.view addSubview:_toolbar];
}

- (void)onComplete
{
    UIImage *croppedImage = [_layoutView cropImage];
    [self.delegate croppedImage:croppedImage];
}

- (void)onTesting
{
    [_layoutView onTesting];
}

@end
