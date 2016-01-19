//
//  BasicShape.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/18/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "BasicShape.h"

@implementation BasicShape
@synthesize shapeType;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
//    if (self) {
//        [self drawTargetArea:frame];
//    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.frame;
    UIBezierPath *roundedPath = [UIBezierPath heartShape:maskLayer.frame];
    roundedPath.lineWidth = 2.0f;
    [[UIColor whiteColor] setStroke];
    [roundedPath stroke];
    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.path = [roundedPath CGPath];
    self.layer.mask = maskLayer;
}

- (void)drawShape:(CGRect)rect andImageView:(UIImageView *)imgView {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = imgView.bounds ;
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithOvalInRect:maskLayer.frame];
    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.path = [roundedPath CGPath];
    
    // Add mask
    imgView.layer.mask = maskLayer;
}

-(void)drawTargetArea:(CGRect)frame
{
    UIBezierPath *aPath = nil;
    
    switch (shapeType) {
        case kTypeHeartShape: aPath = [UIBezierPath heartShape:frame]; break;
            
        case kTypeMartiniShape: aPath = [UIBezierPath martiniShape:frame]; break;
            
        case kTypeStartShape: aPath = [UIBezierPath starShape:frame]; break;
            
        case kTypeUserShape: [UIBezierPath userShape:frame]; break;
            
        case kTypeBeakerShape: [UIBezierPath beakerShape:frame]; break;
            
        default: aPath = [UIBezierPath heartShape:frame]; break;
    }
    
    [aPath closePath]; // close the final path
    
    aPath.lineWidth = 2.0f;
    [[UIColor whiteColor] setStroke];
    [aPath stroke];
}


@end
