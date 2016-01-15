//
//  UIImage+AutoScaleResize.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "UIImage+AutoScaleResize.h"

@implementation UIImage (AutoScaleResize)

+ (nonnull UIImage *)scaleTo2xImage:(nonnull UIImage *)image {
    UIImage *imageScale = [UIImage imageWithImage:image scaledToSize:CGSizeMake(image.size.width * 2, image.size.height * 2)];
    return imageScale;
   
}

+ (nonnull UIImage *)imageWithImage:(nonnull UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (nonnull UIImage*) maskImage:(nonnull UIImage *)image withMask:(nonnull UIImage *)maskImage {
    
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
     [maskImage drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
      UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    return result;
}

+ (nonnull UIImage*)imageByCropping:(nonnull UIImage *)imageToCrop toRect:(CGRect)rect {
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(currentContext, 0.0, rect.size.height);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    CGRect clippedRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextClipToRect( currentContext, clippedRect);
    CGRect drawRect = CGRectMake(rect.origin.x * -1,rect.origin.y * -1,imageToCrop.size.width,imageToCrop.size.height);
    CGContextDrawImage(currentContext, drawRect, imageToCrop.CGImage);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cropped;
}

+ (nonnull UIImage *) addImageToImage:(nonnull UIImage *)img withImage2:(nonnull UIImage *)img2 andRect:(CGRect)cropRect withImageWidth:(int) width
{
    
    CGSize size = CGSizeMake(width,40);
    UIGraphicsBeginImageContext(size);
    
    CGPoint pointImg1 = CGPointMake(0,0);
    [img drawAtPoint:pointImg1];
    
    CGPoint pointImg2 = cropRect.origin;
    [img2 drawAtPoint: pointImg2];
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
    
}

/*
 * Get image from name
 */
+ (nonnull UIImage *)drawImage:(nonnull UIImage *)inputImage inRect:(CGRect)frame originalImage:(nonnull UIImage *)originalImage {
    UIGraphicsBeginImageContextWithOptions(originalImage.size, NO, 0.0);
    [originalImage drawInRect:CGRectMake(0.0, 0.0, originalImage.size.width, originalImage.size.height)];
    [inputImage drawInRect:frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
