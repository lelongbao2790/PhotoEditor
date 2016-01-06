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

@end
