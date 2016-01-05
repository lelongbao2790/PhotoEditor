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

#endif /* Macro_h */
