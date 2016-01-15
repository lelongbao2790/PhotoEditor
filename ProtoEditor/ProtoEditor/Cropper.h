//
//  Cropper.h
//  Crop
//
//  Created by Franco Santa Cruz on 2/6/15.
//  Copyright (c) 2015 BirdMaker. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    CropperActionDidCrop = 1,
    CropperActionCancel
    
}CropperAction;


@interface Cropper : UIView

@property (copy, nonatomic) void (^cropAction)(CropperAction action, UIImage *image);


- (instancetype)initWithImageView:(UIImageView*)imageView;
- (UIImage*)generateCroppedImage;

@end
