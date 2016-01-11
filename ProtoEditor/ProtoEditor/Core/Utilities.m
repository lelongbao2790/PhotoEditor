//
//  Utilities.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

/**
 * fix auto layout for iPhone 5/5S, iPhone 6/6S, iPhone 6/6S Plus
 */
+ (void) fixAutolayoutWithDelegate:(nonnull id /*<UIFixAutolayoutDelegate>*/)delegate {
    static SEL s_selector = nil;
    if (!s_selector) {
        if (kDeviceIsPhoneSmallerOrEqual35) {
            s_selector = NSSelectorFromString(kFixAutoLayoutForIp4);
        } else if (kDeviceIsPhoneSmallerOrEqual40) {
            s_selector = NSSelectorFromString(kFixAutoLayoutForIp5);
        } else if (kDeviceIsPhoneSmallerOrEqual47) {
            s_selector = NSSelectorFromString(kFixAutoLayoutForIp6);
        } else if (kDeviceIsPhoneSmallerOrEqual55) {
            s_selector = NSSelectorFromString(kFixAutoLayoutForIp6Plus);
        } else if (kDeviceIpad) {
            s_selector = NSSelectorFromString(kFixAutoLayoutForIpad);
        }
    }
    
    id<FixAutolayoutDelegate> realDelegate = delegate;
    if ([realDelegate respondsToSelector:s_selector]) {
        IMP imp = [delegate methodForSelector:s_selector];
        void (*func)(id, SEL) = (void *)imp;
        func(realDelegate, s_selector);
    }
}

+ (void)addAnimation:(nonnull UIView *)view {
    [UIView transitionWithView:view
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
}

/*
 * Show view on windown
 */
+ (void)showViewOnWindow:(nonnull UIView *)subView  withTag:(NSInteger)tagView {
    subView.tag = tagView;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:subView];
}

/*
 * Hide view on windown
 */
+ (void)hideViewOnWindown:(nonnull UIView *)subView withTag:(NSInteger)tagView  {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [[window viewWithTag:tagView] removeFromSuperview];
}

+ (void)caculateImageSizeToPresent:(nonnull UIImageView *)imageView {
    // Caculate image size to present
    imageView.contentMode = UIViewContentModeCenter;
    if (kWidthImageView(imageView) > (kWidthImagePhoto && kHeighImageView(imageView) > (kHeighImagePhoto))) {
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Blend **

/*
 * Filter Image with type
 */
+ (void)filterImageWithImage:(nonnull UIImage *)originalImage andType:(NSInteger )typeFilter withCompletion:(nonnull LoadImageCompleted)callBack {
    // Init
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageFilter *stillImageFilter = nil;
    GPUImageFilterGroup *stillImageFilterGroup = nil;
    __block UIImage *outputImage = originalImage;
    
    if (typeFilter == kTypeColor) {
        // Init and set value
        GPUImageBrightnessFilter *brightnessImage = [[GPUImageBrightnessFilter alloc] init];
        GPUImageContrastFilter *constrastImage = [[GPUImageContrastFilter alloc] init];
        GPUImageExposureFilter *exposure = [[GPUImageExposureFilter alloc] init];
        brightnessImage.brightness = [Photo share].brightnessValue;
        constrastImage.contrast = [Photo share].constrastValue;
        exposure.exposure = [Photo share].exposureValue;
        
        // Add target
        [stillImageSource addTarget:brightnessImage];
        [brightnessImage addTarget:exposure];
        [exposure addTarget:constrastImage];
        [constrastImage useNextFrameForImageCapture];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
            [stillImageSource processImageWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    outputImage = [constrastImage imageFromCurrentFramebuffer];
                    callBack(outputImage);
                });
            }];
        });
        return;
        
    } else {
        // Check type filter
        switch (typeFilter) {
                
                // Blend
            case kTypeSepia: {
                stillImageFilter = [[GPUImageSepiaFilter alloc] init];
            } break;
                
            case kTypeGrayScale: {
                stillImageFilter = [[GPUImageGrayscaleFilter alloc] init];
            } break;
                
            case kTypeAmatorka: {
                stillImageFilterGroup = [[GPUImageAmatorkaFilter alloc] init];
                
            } break;
                
            case kTypeGaussian: {
                stillImageFilter = [[GPUImageGaussianBlurFilter alloc] init];
            } break;
                
            case kTypeHighPass: {
                stillImageFilterGroup = [[GPUImageHighPassFilter alloc] init];
            } break;
                
            case kTypeMissEtikate: {
                stillImageFilterGroup = [[GPUImageMissEtikateFilter alloc] init];
            } break;
                
            case kTypeSoftElegan1: {
                stillImageFilterGroup = [[GPUImageSoftEleganceFilter alloc] init];
            } break;
                
            case kTypeInvert: {
                stillImageFilter = [[GPUImageColorInvertFilter alloc] init];
            } break;
                
            default:
                break;
        }

    }
    
    // Export image
    if (stillImageFilter) {
        [stillImageSource addTarget:stillImageFilter];
        [stillImageFilter useNextFrameForImageCapture];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
            [stillImageSource processImageWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    outputImage = [stillImageFilter imageFromCurrentFramebuffer];
                    callBack(outputImage);
                });
            }];
        });
        
    } else if (stillImageFilterGroup) {
        [stillImageSource addTarget:stillImageFilterGroup];
        [stillImageFilterGroup useNextFrameForImageCapture];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
            [stillImageSource processImageWithCompletionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    outputImage = [stillImageFilterGroup imageFromCurrentFramebuffer];
                    callBack(outputImage);
                });
            }];
        });
    } else {
        outputImage = originalImage;
        callBack(outputImage);
    }
}

/*
 * Get child root view controller
 */
+ (nonnull UIViewController*) getChildRootViewController {
    NSArray *s_viewController = @[kMainController,
                                  kPhotoEditorController,
                                  kPhotoFrameController,
                                  kStickerController,
                                  kBlendController];
    for (NSString *stringViewController in s_viewController) {
        if ([[AppDelegate share].homeController.navigationController.topViewController isKindOfClass:NSClassFromString(stringViewController)]) {
            return [AppDelegate share].homeController.navigationController.topViewController;
        }
    }
    
    return nil;
}

/*
 * Turn off left and right bar button
 */
+ (void)turnOffBarButton:(nonnull UIViewController *)controller {
    controller.navigationItem.leftBarButtonItem = nil;
    controller.navigationItem.rightBarButtonItem = nil;
}

/*
 * Turn on left and right bar button
 */
+ (void)turnOnBarButton:(nonnull  UIViewController *)controller {
    controller.navigationItem.leftBarButtonItem = [AppDelegate share].homeController.navigationBarCustom.leftBarButtonItem;
    controller.navigationItem.rightBarButtonItem = [AppDelegate share].homeController.navigationBarCustom.rightBarButtonItem;
}

/*
 * Capture screen
 */
+ (nonnull UIImage*)captureView:(nonnull UIView *)yourView withRect:(CGRect)frameCapture {
//    CGRect rect = frameCapture;
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [yourView.layer renderInContext:context];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
    
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(frameCapture.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(frameCapture.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -frameCapture.origin.x, -frameCapture.origin.y);
    [yourView.layer renderInContext:ctx];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}


@end
