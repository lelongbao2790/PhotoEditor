//
//  UIBezierPath+BasicShape.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/18/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (BasicShape)

+ (UIBezierPath *)heartShape:(CGRect)originalFrame;
+ (UIBezierPath *)userShape:(CGRect)originalFrame;
+ (UIBezierPath *)martiniShape:(CGRect)originalFrame;
+ (UIBezierPath *)beakerShape:(CGRect)originalFrame;
+ (UIBezierPath *)starShape:(CGRect)originalFrame;
+ (UIBezierPath *)stars:(NSUInteger)numberOfStars shapeInFrame:(CGRect)originalFrame;

@end
