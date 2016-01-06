//
//  UIImage+AutoScaleResize.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AutoScaleResize)

+ (nonnull UIImage *)imageWithImage:(nonnull UIImage *)image scaledToSize:(CGSize)newSize;

@end
