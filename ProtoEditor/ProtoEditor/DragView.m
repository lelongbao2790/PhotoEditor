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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    p = [[touches anyObject] locationInView:self.viewDrag];
}

- (void)touchesMoved:(NSSet *)set withEvent:(UIEvent *)event {
    p = [[set anyObject] locationInView:self.viewDrag];
    self.center = p;
}

@end
