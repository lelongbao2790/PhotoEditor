//
//  Photo.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

+ (Photo *)share;

@property (strong, nonatomic) UIImage *imgPhoto;
@property (strong, nonatomic) UIImage *imgPhotoBlend;
@property (assign, nonatomic) float brightnessValue;
@property (assign, nonatomic) float exposureValue;
@property (assign, nonatomic) float constrastValue;
@property (assign, nonatomic) float saturationValue;


- (void)setPhotoColor:(float)brightValue andExposure:(float)exposure andConstrast:(float)constrast andSaturation:(float)saturation;

@end
