//
//  FixAutoLayoutDelegate.h
//  RecipeApp
//
//  Created by Bao (Brian) L. LE on 12/28/15.
//  Copyright © 2015 enclave. All rights reserved.
//

#ifndef FixAutoLayoutDelegate_h
#define FixAutoLayoutDelegate_h

@protocol FixAutolayoutDelegate <NSObject>

@optional

- (void)fixAutolayoutFor35;
- (void)fixAutolayoutFor40;
- (void)fixAutolayoutFor47;
- (void)fixAutolayoutFor55;
- (void)fixAutolayoutForIpad;

@end

#endif /* FixAutoLayoutDelegate_h */
