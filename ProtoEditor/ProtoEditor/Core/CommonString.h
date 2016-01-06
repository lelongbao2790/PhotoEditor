//
//  CommonString.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#ifndef CommonString_h
#define CommonString_h

// Fixed auto layout for multiple device
#define kFixAutoLayoutForIp4 @"fixAutolayoutFor35"
#define kFixAutoLayoutForIp5 @"fixAutolayoutFor40"
#define kFixAutoLayoutForIp6 @"fixAutolayoutFor47"
#define kFixAutoLayoutForIp6Plus @"fixAutolayoutFor55"
#define kFixAutoLayoutForIpad @"fixAutolayoutForIpad"

// Common string
#define kUIImagePickerOriginalImage @"UIImagePickerControllerOriginalImage"
#define kDictListFilter [[NSDictionary alloc] initWithObjectsAndKeys: [Photo share].imgPhoto, @"None", \
                                                                      [UIImage filterImageWithSepiaFilter:[Photo share].imgPhoto], @"Sepia", \
                                                                      [UIImage filterImageWithGrayScaleFilter:[Photo share].imgPhoto], @"Grayscale", \
                                                                      [UIImage filterImageWithAmatorkaFilter:[Photo share].imgPhoto], @"Amatorka", nil]

#endif /* CommonString_h */
