//
//  PhotoEditorController.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoEditorController : UIViewController

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLeadingButton;

/*
 * Delete action
 */
- (void)deleteAction;

/*
 * Apply image
 */
- (void)applyImageWithSlideValue;

@end
