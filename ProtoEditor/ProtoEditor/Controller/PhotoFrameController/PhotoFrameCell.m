//
//  PhotoFrameCell.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/11/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "PhotoFrameCell.h"

@implementation PhotoFrameCell

- (void)loadImage {
    self.imageFrame.image = self.imgFrameFromDict;
    
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
}

@end
