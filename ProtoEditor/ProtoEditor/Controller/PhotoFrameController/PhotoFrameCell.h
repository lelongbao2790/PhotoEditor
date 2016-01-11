//
//  PhotoFrameCell.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/11/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoFrameCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *imgFrameFromDict;
@property (weak, nonatomic) IBOutlet UIImageView *imageFrame;

- (void)loadImage;

@end
