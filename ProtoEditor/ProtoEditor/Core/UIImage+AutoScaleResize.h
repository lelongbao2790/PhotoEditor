//
//  UIImage+AutoScaleResize.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AutoScaleResize)

/*
 * Scale image to 2x
 */
+ (nonnull UIImage *)scaleTo2xImage:(nonnull UIImage *)image;

/*
 * Resize Image
 */
+ (nonnull UIImage *)imageWithImage:(nonnull UIImage *)image scaledToSize:(CGSize)newSize;

/*
 * Mark image
 */
+ (nonnull UIImage*) maskImage:(nonnull UIImage *)image withMask:(nonnull UIImage *)maskImage;

/*
 * Crop image
 */
+ (nonnull UIImage*)imageByCropping:(nonnull UIImage *)imageToCrop toRect:(CGRect)rect;

+ (nonnull UIImage *) addImageToImage:(nonnull UIImage *)img withImage2:(nonnull UIImage *)img2 andRect:(CGRect)cropRect withImageWidth:(int) width;

/*
 * Get image from name
 */
+ (nonnull UIImage *)drawImage:(nonnull UIImage *)inputImage inRect:(CGRect)frame originalImage:(nonnull UIImage *)originalImage;

@end
