//
//  CenterButton.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/15/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "CenterButton.h"
#define kTextTopPadding 3
@implementation CenterButton
-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect titleLabelFrame = self.titleLabel.frame;
    
    CGRect labelSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.bounds)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
    
    CGRect imageFrame = self.imageView.frame;
    
    CGSize fitBoxSize = (CGSize){.height = labelSize.size.height + kTextTopPadding +  imageFrame.size.height, .width = MAX(imageFrame.size.width, labelSize.size.width)};
    
    CGRect fitBoxRect = CGRectInset(self.bounds, (self.bounds.size.width - fitBoxSize.width)/2, (self.bounds.size.height - fitBoxSize.height)/2);
    
    imageFrame.origin.y = fitBoxRect.origin.y;
    imageFrame.origin.x = CGRectGetMidX(fitBoxRect) - (imageFrame.size.width/2);
    self.imageView.frame = imageFrame;
    
    // Adjust the label size to fit the text, and move it below the image
    
    titleLabelFrame.size.width = labelSize.size.width;
    titleLabelFrame.size.height = labelSize.size.height;
    titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.size.width / 2);
    titleLabelFrame.origin.y = fitBoxRect.origin.y + imageFrame.size.height + kTextTopPadding;
    self.titleLabel.frame = titleLabelFrame;
}


@end
