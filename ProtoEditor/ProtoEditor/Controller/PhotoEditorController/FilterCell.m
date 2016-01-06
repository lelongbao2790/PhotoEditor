//
//  FilterCell.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/6/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

- (void)awakeFromNib {
    // Initialization code
    [Utilities caculateImageSizeToPresent:self.imageFilter];
}

- (void)loadImageWithType:(NSInteger)typeFilter andText:(NSString *)nameFilter {
    // Hide
    self.activityLoading.hidden = NO;
    self.labelFilter.hidden = YES;
    self.imageFilter.hidden = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        [Utilities filterImageWithImage:kImageSample andType:typeFilter withCompletion:^(UIImage * _Nonnull imageComplete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageFilter.image = imageComplete;
                self.labelFilter.text = nameFilter;
                
                // Show
                [self.activityLoading stopAnimating];
                self.labelFilter.hidden = NO;
                self.imageFilter.hidden = NO;
            });
        }];
    });
}

@end
