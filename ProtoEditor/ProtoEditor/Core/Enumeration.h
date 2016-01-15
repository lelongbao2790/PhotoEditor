//
//  Enumeration.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#ifndef Enumeration_h
#define Enumeration_h

// Constant for main controller
typedef NS_ENUM(NSInteger, ConstantMainController) {
    kConstantWidthButtonIp6 = 104,
    kConstantWidthButtonIpad = 150,
};

// Tag face
typedef NS_ENUM(NSInteger, TagFace) {
    kTagFaceView = 1,
    kTagLeftEyeView = 2,
    kTagRightEyeView = 3,
    kTagMouthView = 4,
};

typedef NS_ENUM(NSInteger, BlendTag) {
    kTagCollectionViewFilter = 100,
    kTagBlendController = 1,
};

typedef NS_ENUM(NSInteger, OrientationNumber) {
    kTopButtonOnMainPortrait = 90,
    kTopButtonOnMainLandscape = 25,
    kLeadingButtonPortrait = 18,
    kLeadingButtonLandscape = 50,
    kLeadingButtonEditPortrait = 15,
    kLeadingButtonEditLandscape = 50,
};

typedef NS_ENUM(NSInteger, MultipleDevicePhotoEdit) {
    kConstantWidthButtonPhotoEditIp5 = 70,
    kConstantWidthButtonPhotoEditIp6 = 88,
    kConstantWidthButtonPhotoEditIpad = 160,
    kConstantWidthButtonPhotoEditLandScapeIp5 = 110,
    kConstantWidthButtonPhotoEditLandScapeIp6 = 128,
    kConstantWidthButtonPhotoEditLandScapeIpad = 200,
    kConstantBottomImageNormal = 25,
    kConstantLeftImageNormal = 0,
    kConstantRightImageNormal = 0,
    kConstantBottomImageEdit = 140,
    kConstantLeftImageEdit = 35,
    kConstantRightImageEdit = 35,
    kConstantTopImageNormal = 25,
    kConstantTopImageEdit = 2,
    kSpaceCrop = 40,
};

typedef NS_ENUM(NSInteger, FilterNumber) {
    kTypeNone = 0,
    kTypeSepia = 1,
    kTypeGrayScale = 2,
    kTypeAmatorka = 3,
    kTypeHighPass = 4,
    kTypeGaussian = 5,
    kTypeMissEtikate = 6,
    kTypeSoftElegan1 = 7,
    kTypeSoftElegan2 = 8,
    kTypeInvert = 9,
    kTypeColor = 10,
    kTypeBlur = 11,
    kTypeSaturation = 12,
};

#endif /* Enumeration_h */
