//
//  UIImage+Filter.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/6/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "UIImage+Filter.h"

@implementation UIImage (Filter)

//*****************************************************************************
#pragma mark -
#pragma mark - ** Blend **

/*
 * Filter Image with type
 */
+ (nonnull UIImage *)filterImageWithImage:(nonnull UIImage *)originalImage andType:(NSInteger )typeFilter withCompletion:(nonnull LoadImageCompleted)callBack {
    // Init
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:originalImage];
    GPUImageFilter *stillImageFilter = nil;
    GPUImageFilterGroup *stillImageFilterGroup = nil;
    __block UIImage *outputImage = originalImage;
    
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
        
//        [stillImageSource processImage];
//        outputImage = [stillImageFilter imageFromCurrentFramebuffer];
        
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
        
//        [stillImageSource processImage];
//        outputImage = [stillImageFilterGroup imageFromCurrentFramebuffer];
    } else {
        outputImage = originalImage;
        callBack(outputImage);
    }
    
    return outputImage;
}

@end
