//
//  UIImage+Filter.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/6/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Filter)

/*
 * Filter Image with : Sepial
 */
+ (nonnull UIImage *)filterImageWithSepiaFilter:(nonnull UIImage *)originalImage;

/*
 * Filter Image with : Gray Scale
 */
+ (nonnull UIImage *)filterImageWithGrayScaleFilter:(nonnull UIImage *)originalImage;

/*
 * Filter Image with : Amatorka
 */
+ (nonnull UIImage *)filterImageWithAmatorkaFilter:(nonnull UIImage *)originalImage;

/*
 * Filter Image with : Brightness
 */
+ (nonnull UIImage *)filterImageWithGausian:(nonnull UIImage *)originalImage withBlur:(CGFloat)blur;

/*
 * Filter Image with : HighPass
 */
+ (nonnull UIImage *)filterImageWithHighPass:(nonnull UIImage *)originalImage withFilterStrength:(CGFloat)strength;

@end
