//
//  Photo.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "Photo.h"

@implementation Photo

+ (Photo *)share {
    static dispatch_once_t once;
    static Photo *share;
    
    dispatch_once(&once, ^{
        share = [[Photo alloc] init];
    });
    
    return share;
}

- (instancetype) init{
    self = [super init];
    if (self) {
        // Set name default for user name
        self.imgPhoto = [UIImage imageNamed:@"no_image.png"];
        self.imgPhotoBlend = nil;
        self.brightnessValue = 0.0;
        self.exposureValue = 0.0;
        self.constrastValue = 1.0;
    }
    return self;
}

- (void)setPhotoColor:(float)brightValue andExposure:(float)exposure andConstrast:(float)constrast {
    self.brightnessValue = brightValue;
    self.exposureValue = exposure;
    self.constrastValue = constrast;
}

@end
