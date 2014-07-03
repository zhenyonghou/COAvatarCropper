

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, COCameraOrientation) {
    kCameraOrientationRear = 0,        // 后置摄像头
    kCameraOrientationFront            // 前置摄像头
};

@protocol COStandardCameraManagerDelegate;


@interface COStandardCameraManager : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, weak)id<COStandardCameraManagerDelegate> delegate;
@property(nonatomic, assign)COCameraOrientation cameraOrientation;

@property(nonatomic, strong, readonly) UIImagePickerController *pickerController;

- (void)showCameraInViewController:(UIViewController *)controller animated:(BOOL)animated;

- (void)dismissCameraWithAnimated:(BOOL)animated;

@end


@protocol COStandardCameraManagerDelegate <NSObject>

@optional
- (void)cameraController:(UIViewController *)controller didFinishWithImage:(UIImage *)image;
- (void)cameraControllerDidCancel:(UIViewController *)controller;
- (void)cameraControllerDidFinishSaveMetaData:(UIViewController *)controller;

@end
