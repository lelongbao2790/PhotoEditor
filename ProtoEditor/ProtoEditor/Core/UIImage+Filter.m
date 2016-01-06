//
//  UIImage+Filter.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/6/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "UIImage+Filter.h"

@implementation UIImage (Filter)

/*
 * Filter Image with : Sepial
 */
+ (nonnull UIImage *)filterImageWithSepiaFilter:(nonnull UIImage *)originalImage {
    UIImage *inputImage = originalImage;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

/*
 * Filter Image with : Gray Scale
 */
+ (nonnull UIImage *)filterImageWithGrayScaleFilter:(nonnull UIImage *)originalImage {
    UIImage *inputImage = originalImage;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageGrayscaleFilter *stillImageFilter = [[GPUImageGrayscaleFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

/*
 * Filter Image with : Amatorka
 */
+ (nonnull UIImage *)filterImageWithAmatorkaFilter:(nonnull UIImage *)originalImage {
    UIImage *inputImage = originalImage;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageAmatorkaFilter *stillImageFilter = [[GPUImageAmatorkaFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

/*
 * Filter Image with : Brightness
 */
+ (nonnull UIImage *)filterImageWithGausian:(nonnull UIImage *)originalImage withBlur:(CGFloat)blur {
    UIImage *inputImage = originalImage;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageGaussianBlurFilter *stillImageFilter = [[GPUImageGaussianBlurFilter alloc] init];
    stillImageFilter.blurRadiusInPixels = blur;
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

/*
 * Filter Image with : HighPass
 */
+ (nonnull UIImage *)filterImageWithHighPass:(nonnull UIImage *)originalImage withFilterStrength:(CGFloat)strength {
    UIImage *inputImage = originalImage;
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageHighPassFilter *stillImageFilter = [[GPUImageHighPassFilter alloc] init];
    stillImageFilter.filterStrength = strength;
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    return currentFilteredVideoFrame;
}

@end
