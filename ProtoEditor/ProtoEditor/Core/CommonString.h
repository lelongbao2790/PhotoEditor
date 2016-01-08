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
#define kDictListFilter [[NSDictionary alloc] initWithObjectsAndKeys: [NSNumber numberWithInteger:kTypeNone], @"None", \
[NSNumber numberWithInteger:kTypeMissEtikate], @"Miss Etikate", \
[NSNumber numberWithInteger:kTypeSoftElegan1], @"Soft Elegan", \
[NSNumber numberWithInteger:kTypeInvert], @"Invert", \
[NSNumber numberWithInteger:kTypeSepia], @"Sepia", \
[NSNumber numberWithInteger:kTypeGrayScale], @"Grayscale", \
[NSNumber numberWithInteger:kTypeAmatorka], @"Amatorka", nil]

#define kImageSample [UIImage imageNamed:@"girl_sample.png"]
#define kStringLoading @"Loading"
#define kStringDone @"Done"
#define kStringColor @"Color"
#define kStringBlend @"Blend"
#define kEmptyString @""

#endif /* CommonString_h */
