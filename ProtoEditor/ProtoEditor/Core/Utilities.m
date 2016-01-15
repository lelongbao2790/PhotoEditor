//
//  Utilities.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "Utilities.h"

#define TIME_DURATION_TOAST 300

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
                    
                    // Prevent output image auto rotate
                    outputImage = [UIImage imageWithCGImage:[outputImage CGImage] scale:1.0 orientation:originalImage.imageOrientation];
                    callBack(outputImage);
                });
            }];
        });
        return;
        
    } else {
        // Check type filter
        switch (typeFilter) {
                
            case kTypeSaturation: {
                GPUImageSaturationFilter *saturationFilter = [[GPUImageSaturationFilter alloc] init];
                saturationFilter.saturation = [Photo share].saturationValue;
                stillImageFilter = saturationFilter;
            } break;
                
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
                
            case kTypeBlur: {
                GPUImageGaussianBlurFilter *blurImage = [[GPUImageGaussianBlurFilter alloc] init];
                blurImage.blurRadiusInPixels = 40.0;
                stillImageFilter = blurImage;
            }
                
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
                    outputImage = [UIImage imageWithCGImage:[outputImage CGImage] scale:1.0 orientation:originalImage.imageOrientation];
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
                    outputImage = [UIImage imageWithCGImage:[outputImage CGImage] scale:1.0 orientation:originalImage.imageOrientation];
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
                                  kHomeController,
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

/**
 * Show iToast message for informing.
 * @param message
 */
+ (void)showiToastMessage:(nonnull NSString *)message
{
    
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    theSettings.duration = TIME_DURATION_TOAST;
    
    // Prevent crash with null string
    if (message == (id)[NSNull null]) {
        message = kEmptyString;
    }
    
    [[[[iToast makeText:message]
       setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
}

+ (CGRect)frameForImage:(nonnull UIImage*)image inImageViewAspectFit:(nonnull UIImageView*)imageView
{
    float imageRatio = image.size.width / image.size.height;
    
    float viewRatio = imageView.frame.size.width / imageView.frame.size.height;
    
    if(imageRatio < viewRatio)
    {
        float scale = imageView.frame.size.height / image.size.height;
        
        float width = scale * image.size.width;
        
        float topLeftX = (imageView.frame.size.width - width) * 0.5;
        
        return CGRectMake(topLeftX, 0, width, imageView.frame.size.height);
    }
    else
    {
        float scale = imageView.frame.size.width / image.size.width;
        
        float height = scale * image.size.height;
        
        float topLeftY = (imageView.frame.size.height - height) * 0.5;
        
        return CGRectMake(0, topLeftY, imageView.frame.size.width, height);
    }
}

+ (CGRect)caculateFrameImage:(nonnull UIImage *)imageComplete andImageView:(nonnull UIImageView *)imageView andTopConstant:(CGFloat)topConstant {
    
    CGRect rectImageConvert = [Utilities frameForImage:imageComplete inImageViewAspectFit:imageView];
    CGRect rectImageView = imageView.frame;
    
    if (rectImageView.size.width > rectImageConvert.size.width) {
        rectImageConvert.origin.x = (rectImageView.size.width - rectImageConvert.size.width)/2 + rectImageView.origin.x;
    } else if (rectImageView.size.width < rectImageConvert.size.width) {
        rectImageConvert.origin.x = (rectImageConvert.size.width - rectImageView.size.width)/2 + rectImageView.origin.x;
    } else {
        rectImageConvert.origin.x = rectImageView.origin.x;
    }
    
    if (rectImageView.size.height > rectImageConvert.size.height) {
        rectImageConvert.origin.y = (rectImageView.size.height - rectImageConvert.size.height)/2 + 64 + topConstant;
    } else if (rectImageView.size.height < rectImageConvert.size.height) {
        rectImageConvert.origin.y = (rectImageConvert.size.height - rectImageView.size.height)/2 + 64 + topConstant;
    } else {
        rectImageConvert.origin.y = rectImageView.origin.y;
    }
    
    return rectImageConvert;
}

+ (void)changeSelectedColorOfView:(nonnull UICollectionViewCell *)cell {
    cell.backgroundColor = [UIColor whiteColor]; // highlight selection
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
}

+ (void)changeDeselectedColorOfView:(nonnull UICollectionViewCell *)cell {
    cell.backgroundColor = [UIColor clearColor]; // Default color
    cell.layer.cornerRadius = 0;
    cell.layer.masksToBounds = NO;
}

@end
