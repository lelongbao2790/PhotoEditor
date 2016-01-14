//
//  Macro.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define kDeviceIsPhoneSmallerOrEqual35 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 480.0)
#define kDeviceIsPhoneSmallerOrEqual40 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 568.0)
#define kDeviceIsPhoneSmallerOrEqual47 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 667.0)
#define kDeviceIsPhoneSmallerOrEqual55 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && MAX(UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height) <= 1104.0)
#define kDeviceIpad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define InitStoryBoardWithIdentifier(identifier) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:identifier]

#define kWidthImageView(imageView) imageView.bounds.size.width
#define kWidthImagePhoto [Photo share].imgPhoto.size.width
#define kHeighImageView(imageView) imageView.bounds.size.height
#define kHeighImagePhoto [Photo share].imgPhoto.size.height
#define kWindow [UIApplication sharedApplication].keyWindow

#define kPhotoBlend ([Photo share].imgPhotoBlend) ?  [Photo share].imgPhotoBlend : [Photo share].imgPhoto
#define kValueString(value) [NSString stringWithFormat:@"%.2f", value]

// Progress Bar
#define ProgressBarShowLoading(_Title_) [SNLoading showWithTitle:_Title_]
#define ProgressBarDismissLoading(_Title_) [SNLoading hideWithTitle:_Title_]
#define ProgressBarUpdateLoading(_Title_, _DetailsText_) [SNLoading updateWithTitle:_Title_ detailsText:_DetailsText_]
#define getController [Utilities getChildRootViewController]

// Frame
#define frameForImageWithAspectFit(imageView) [Utilities frameForImage:kPhotoBlend inImageViewAspectFit:imageView]
#define realFrameForImage(image, imageview, topConstant) [Utilities caculateFrameImage:image andImageView:imageview andTopConstant:topConstant]
#define takeScreenShot(view, rect) [Utilities captureView:view withRect:rect]
#define frameForSticker(view, imgSticker) CGRectMake(view.frame.size.width / 2 - imgSticker.size.width /2 ,\
view.frame.size.height / 2 - imgSticker.size.height /2\
, imgSticker.size.width, imgSticker.size.height)

#endif /* Macro_h */
