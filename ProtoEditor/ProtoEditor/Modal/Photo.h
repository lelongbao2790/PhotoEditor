//
//  Photo.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Photo : NSObject

+ (Photo *)share;

@property (strong, nonatomic) UIImage *imgPhoto;

@end
