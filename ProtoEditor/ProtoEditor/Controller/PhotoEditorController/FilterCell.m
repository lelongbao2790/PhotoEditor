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
    
    self.labelFilter.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
    [Utilities caculateImageSizeToPresent:self.imageFilter];
}

@end
