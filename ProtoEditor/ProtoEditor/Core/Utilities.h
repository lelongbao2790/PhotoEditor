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

/**
 * fix auto layout for iPhone 5/5S, iPhone 6/6S, iPhone 6/6S Plus
 */
+ (void) fixAutolayoutWithDelegate:(nonnull id /*<UIFixAutolayoutDelegate>*/)delegate;

/*
 * Show view on windown
 */
+ (void)showViewOnWindow:(nonnull UIView *)subView  withTag:(NSInteger)tagView;

/*
 * Hide view on windown
 */
+ (void)hideViewOnWindown:(nonnull UIView *)subView withTag:(NSInteger)tagView;

@end
