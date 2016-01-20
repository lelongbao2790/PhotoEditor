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

#define kDictListFrameImage [[NSDictionary alloc] initWithObjectsAndKeys: [UIImage imageNamed:@"frame_1.png"], [NSNumber numberWithInteger:0], \
[UIImage imageNamed:@"frame_2.png"], [NSNumber numberWithInteger:1], \
[UIImage imageNamed:@"frame_3.png"], [NSNumber numberWithInteger:2], \
[UIImage imageNamed:@"frame_4.png"], [NSNumber numberWithInteger:3], \
[UIImage imageNamed:@"frame_5.png"], [NSNumber numberWithInteger:4], \
[UIImage imageNamed:@"frame_6.png"], [NSNumber numberWithInteger:5], \
[UIImage imageNamed:@"frame_7.png"], [NSNumber numberWithInteger:6], nil]

#define kListStickerImage [NSArray arrayWithObjects:[UIImage imageNamed:@"sticker1.png"], \
[UIImage imageNamed:@"sticker2.png"], \
[UIImage imageNamed:@"sticker3.png"], \
[UIImage imageNamed:@"sticker4.png"], \
[UIImage imageNamed:@"sticker5.png"], \
[UIImage imageNamed:@"sticker6.png"], \
[UIImage imageNamed:@"sticker7.png"], \
[UIImage imageNamed:@"sticker8.png"], \
[UIImage imageNamed:@"sticker9.png"], \
[UIImage imageNamed:@"sticker10.png"], nil]

#define kListSetting [NSArray arrayWithObjects:@"Receive notification", \
@"Use camera", \
@"Feedback", \
@"Sign in", \
@"Save to cloud", nil]



#define kImageSample [UIImage imageNamed:@"girl_sample.png"]
#define kStringLoading @"Loading"
#define kStringDone @"Done"
#define kStringColor @"Color"
#define kStringBlend @"Blend"
#define kEmptyString @""
#define kCropString @"Crop"
#define kPhotoEditorTitle @"Photo Editor"
#define kEditorTitle @"Edit"
#define kFrameTitle @"Frame"
#define kStickerTitle @"Sticker"
#define kSaveImageSuccess @"Photo saved to album"
#define kPhotoCollageCellIdentifier @"collagePhotoCellIdentifier"
#define kSettingIdentifier @"settingIdentifier"


// Image
#define kNavigationBarBackground [UIImage imageNamed:@"navigation_bar"]
#define kBackgroundImage [UIImage imageNamed:@"background"]
#define kBackImage [UIImage imageNamed:@"back_icon"]
#define kApplyImage [UIImage imageNamed:@"apply"]
#define kDeleteImage [UIImage imageNamed:@"delete"]
#define kSaveImage [UIImage imageNamed:@"save"]
#define kRefreshImage [UIImage imageNamed:@"refresh_icon"]
#endif /* CommonString_h */
