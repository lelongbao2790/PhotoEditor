//
//  Utilities.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Face;

@interface Utilities : NSObject

// typedef block failed
typedef void (^LoadImageCompleted)( UIImage * _Nonnull imageComplete);

/**
 * fix auto layout for iPhone 5/5S, iPhone 6/6S, iPhone 6/6S Plus
 */
+ (void) fixAutolayoutWithDelegate:(nonnull id /*<UIFixAutolayoutDelegate>*/)delegate;

+ (void)addAnimation:(nonnull UIView *)view;

/*
 * Show view on windown
 */
+ (void)showViewOnWindow:(nonnull UIView *)subView  withTag:(NSInteger)tagView;

/*
 * Hide view on windown
 */
+ (void)hideViewOnWindown:(nonnull UIView *)subView withTag:(NSInteger)tagView;

+ (void)caculateImageSizeToPresent:(nonnull UIImageView *)imageView;

//*****************************************************************************
#pragma mark -
#pragma mark - ** Blend **

/*
 * Filter Image with type
 */
+ (void)filterImageWithImage:(nonnull UIImage *)originalImage andType:(NSInteger )typeFilter withCompletion:(nonnull LoadImageCompleted)callBack;

/*
 * Get child root view controller
 */
+ (nonnull UIViewController*) getChildRootViewController;

/*
 * Turn off left and right bar button
 */
+ (void)turnOffBarButton:(nonnull  UIViewController *)controller;

/*
 * Turn on left and right bar button
 */
+ (void)turnOnBarButton:(nonnull  UIViewController *)controller;

/*
 * Capture screen
 */
+ (nonnull UIImage*)captureView:(nonnull UIView *)yourView withRect:(CGRect)frameCapture;

/**
 * Show iToast message for informing.
 * @param message
 */
+ (void)showiToastMessage:(nonnull NSString *)message;

+ (CGRect)frameForImage:(nonnull UIImage*)image inImageViewAspectFit:(nonnull UIImageView*)imageView;

+ (CGRect)caculateFrameImage:(nonnull UIImage *)imageComplete andImageView:(nonnull UIImageView *)imageView andTopConstant:(CGFloat)topConstant;

@end
