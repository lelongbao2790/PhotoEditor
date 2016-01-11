//
//  DragView.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/11/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "DragView.h"

@implementation DragView
@synthesize p;
- (void)touchesMoved:(NSSet *)set withEvent:(UIEvent *)event {
    p = [[set anyObject] locationInView:self.superview];
    self.center = p;
}

@end
