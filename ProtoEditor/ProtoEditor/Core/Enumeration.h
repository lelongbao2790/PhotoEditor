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
    kConstantWidthButtonIp6 = 142,
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

typedef NS_ENUM(NSInteger, MultipleDevicePhotoEdit) {
    kConstantWidthButtonPhotoEditIp5 = 100,
    kConstantWidthButtonPhotoEditIp6 = 118,
    kConstantWidthButtonPhotoEditIpad = 190,
    kConstantBottomImageNormal = 95,
    kConstantLeftImageNormal = -10,
    kConstantRightImageNormal = -10,
    kConstantBottomImageEdit = 140,
    kConstantLeftImageEdit = 35,
    kConstantRightImageEdit = 35,
    kConstantTopImageNormal = 8,
    kConstantTopImageEdit = 2,
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
};

#endif /* Enumeration_h */
