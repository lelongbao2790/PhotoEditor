//
//  UIImage+Filter.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/6/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Filter)

// typedef block failed
typedef void (^LoadImageCompleted)( UIImage * _Nonnull imageComplete);
//*****************************************************************************
#pragma mark -
#pragma mark - ** Blend **

/*
 * Filter Image with type
 */
+ (nonnull UIImage *)filterImageWithImage:(nonnull UIImage *)originalImage andType:(NSInteger )typeFilter withCompletion:(nonnull LoadImageCompleted)callBack;

@end
