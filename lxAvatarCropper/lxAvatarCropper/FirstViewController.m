//
//  FirstViewController.m
//  LxAsset
//
//  Created by houzhenyong on 14-6-15.
//  Copyright (c) 2014年 hou zhenyong. All rights reserved.
//

#import "FirstViewController.h"
#import "COAvatarCropComponent.h"

@interface FirstViewController () <UIActionSheetDelegate, COAvatarCropComponentDelegate>

@property (nonatomic, strong) UIButton *avatarButton;

@property (nonatomic, strong) COAvatarCropComponent *cropComponent;

@end

@implementation FirstViewController

- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(onCropAvatar) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.avatarButton = button;
}

- (void)onCropAvatar
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从本地相册", @"拍照", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (!self.cropComponent) {
        self.cropComponent = [[COAvatarCropComponent alloc] init];
    }
    COAvatarCropControllerSourceType sourceType;
    if (buttonIndex == 0) {     // 本地相册
        sourceType = kAvatarCropControllerSourceTypePhotosAlbum;
    } else if (buttonIndex == 1) {  // 拍照
        sourceType = kAvatarCropControllerSourceTypeCamerera;
    }
    
    self.cropComponent.delegate = self;
    
    [self.cropComponent showInViewController:self controllerSourceType:sourceType];
}

#pragma mark- COAvatarCropComponentDelegate

- (void)avatarCropDidCancel
{
    self.cropComponent = nil;
}

- (void)croppedImage:(UIImage*)image
{
    [self.avatarButton setImage:image forState:UIControlStateNormal];
    self.cropComponent = nil;
}

@end
