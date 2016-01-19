//
//  CollagePhotoCell.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/18/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "CollagePhotoCell.h"

@implementation CollagePhotoCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    self.imageView.frame = bounds;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if (highlighted) {
        _imageView.alpha = .7f;
    }else {
        _imageView.alpha = 1.f;
    }
}

@end
