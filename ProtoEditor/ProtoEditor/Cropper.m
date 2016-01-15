//
//  Cropper.m
//  Crop
//
//  Created by Franco Santa Cruz on 2/6/15.
//  Copyright (c) 2015 BirdMaker. All rights reserved.
//

#import "Cropper.h"

typedef enum : NSUInteger {
    PanStateNone,
    PanStateMoving,
    PanStateChangingSize,
} PanState;

typedef enum : NSUInteger {
    None,
    Left = 1 << 0,
    Top = 1 << 1,
    Right = 1 << 2,
    Bottom = 1 << 3,
} ResizingState;


@interface Cropper ()

@property (assign, nonatomic) CGRect croppingRect;
@property (assign, nonatomic) CGPoint lastDistance;
@property (assign, nonatomic) CGPoint lastDistancePan;
@property (strong, nonatomic) UIView *bar;
@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic, assign) PanState panState;
@property (nonatomic, assign) ResizingState resizingState;


@end

@implementation UIImageView (util)

-(CGRect)cropRectForFrame:(CGRect)frame
{
    NSAssert(self.contentMode == UIViewContentModeScaleAspectFit, @"content mode must be aspect fit");
    
    CGFloat widthScale = self.bounds.size.width / self.image.size.width;
    CGFloat heightScale = self.bounds.size.height / self.image.size.height;
    
    float x, y, w, h, offset;
    if (widthScale<heightScale) {
        offset = (self.bounds.size.height - (self.image.size.height*widthScale))/2;
        x = frame.origin.x / widthScale;
        y = (frame.origin.y-offset) / widthScale;
        w = frame.size.width / widthScale;
        h = frame.size.height / widthScale;
    } else {
        offset = (self.bounds.size.width - (self.image.size.width*heightScale))/2;
        x = (frame.origin.x-offset) / heightScale;
        y = frame.origin.y / heightScale;
        w = frame.size.width / heightScale;
        h = frame.size.height / heightScale;
    }
    return CGRectMake(x, y, w, h);
}

@end

@implementation Cropper

- (instancetype)initWithImageView:(UIImageView*)imageView
{
    [imageView setNeedsLayout];
    [imageView layoutIfNeeded];
    self = [super initWithFrame:imageView.frame];
    if (self) {
        self.imageView = imageView;
        [self setupInitialCroppingRect];
        [self setBackgroundColor:[UIColor clearColor]];
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        [self addGestures];
        [self addButtonsBar];
        
        UIView *sup = [imageView superview];
        [self addViewToHierarchy:imageView parent:sup];
        
    }
    return self;
}

- (UIImage*)image
{
    return self.imageView.image;
}

// add contraints so the view is always align with imageview
- (void)addViewToHierarchy:(UIImageView*)imageView parent:(UIView*)sup
{
    //add
    [sup addSubview:self];
    
    // add contraints so the view is always align with imageview
    //
    // left
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    // right
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    // top
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    // bottom
    [sup addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:imageView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
}

- (void)cancel:(id)sender
{
//    if( self.cropAction )
//    {
//        [self finishCropper];
//        self.cropAction(CropperActionCancel, nil);
//        
//    }
    [self finishCropper];
    self.cropAction(CropperActionCancel, nil);
}

- (IBAction)crop:(id)sender
{
//    if( self.cropAction )
//    {
//        UIImage *image = [self generateCroppedImage];
//        [self finishCropper];
//        self.cropAction(CropperActionDidCrop, image);
//    }
    UIImage *image = [self generateCroppedImage];
    [self finishCropper];
    self.cropAction(CropperActionDidCrop, image);
}

- (void)finishCropper
{
    [self removeFromSuperview];
}

- (void)addButtonsBar
{
//    // create crop & cancel buttons
//    UIButton *crop = [UIButton buttonWithType:UIButtonTypeSystem];
//    crop.imageView.image = kApplyImage;
//    [crop addTarget:self action:@selector(crop:) forControlEvents:UIControlEventTouchUpInside];
//    [crop setTranslatesAutoresizingMaskIntoConstraints:NO];
//    //    [crop setTitle:@"Crop" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *cropBarButton = [[UIBarButtonItem alloc ] initWithCustomView:crop];
//    [AppDelegate share].photoController.navigationItem.rightBarButtonItem = cropBarButton;
//    
//    // add
//    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
//    cancel.imageView.image = kDeleteImage;
//    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTranslatesAutoresizingMaskIntoConstraints:NO];
//    //    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc ] initWithCustomView:cancel];
//    [AppDelegate share].photoController.navigationItem.leftBarButtonItem = cancelBarButton;

//    UIView *bar = [[UIView alloc] initWithFrame:CGRectZero];
//    // set instance
//    self.bar = bar;
//    // set to manage via autolayout
//    [bar setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    [bar setBackgroundColor:[UIColor blackColor]];
//    [self addSubview:bar];
//    id views = @{@"bar":bar};
//    id metrics = @{@"buttonHeight":@40};
//    // add constraints
//    //
//    // Vertical
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bar(buttonHeight)]"
//                                                                 options:0
//                                                                 metrics:metrics
//                                                                   views:views]];
//    // Horizontal
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bar]|"
//                                                                 options:0
//                                                                 metrics:metrics
//                                                                   views:views]];
//    
//    // create crop & cancel buttons
//    UIButton *crop = [UIButton buttonWithType:UIButtonTypeSystem];
//    [crop addTarget:self action:@selector(crop:) forControlEvents:UIControlEventTouchUpInside];
//    [crop setTranslatesAutoresizingMaskIntoConstraints:NO];
////    [crop setTitle:@"Crop" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *cropBarButton = [[UIBarButtonItem alloc ] initWithCustomView:crop];
//    getController.navigationItem.rightBarButtonItem = cropBarButton;
//    
//    // add
//    [bar addSubview:crop];
//    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeSystem];
//    [cancel addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTranslatesAutoresizingMaskIntoConstraints:NO];
////    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
//    
//    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc ] initWithCustomView:cancel];
//    getController.navigationItem.leftBarButtonItem = cancelBarButton;
//    
//    // add
//    [bar addSubview:cancel];
//    // set constraints
//    
//    id array = @[ crop, cancel, bar ];
//    // force buttons calculate their width & height
//    [array makeObjectsPerformSelector:@selector(setNeedsLayout)];
//    [array makeObjectsPerformSelector:@selector(layoutIfNeeded)];
//    
//    
//    CGFloat separationBetweenButtons = 9;
//    // center constant
//    CGFloat firstButtonCenterXConstant = cancel.frame.size.width/2 + separationBetweenButtons/2;
//    
//    // add bar & buttons constraints
//    [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:crop attribute:NSLayoutAttributeCenterX multiplier:1 constant:firstButtonCenterXConstant]];
//    // bar & crop center y
//    [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:crop attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
//    // bar & cancel center y
//    [bar addConstraint:[NSLayoutConstraint constraintWithItem:bar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
//    // separation cancel & crop
//    [bar addConstraint:[NSLayoutConstraint constraintWithItem:crop attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cancel attribute:NSLayoutAttributeLeft multiplier:1 constant:-1*separationBetweenButtons]];
    
}

- (void)setupInitialCroppingRect
{
    // create initial cropping rect
    CGFloat w = self.frame.size.width / 4 * 3;
    CGFloat h = self.frame.size.height / 4 * 3;
    CGFloat x = (self.frame.size.width - w) / 2;
    CGFloat y = (self.frame.size.height - h) / 2;
    // set
    self.croppingRect = CGRectMake(x, y, w, h);
    // invalidate view so initial rect gets drawn
    [self setNeedsDisplay];
}

- (UIImage*)generateCroppedImage
{
    CGRect rect = [self.imageView cropRectForFrame:self.croppingRect];
    // begin
    UIGraphicsBeginImageContext(rect.size);
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, self.image.size.width, self.image.size.height);
    // draw image
    [self.image drawInRect:drawRect];
    // grab image
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    // end
    UIGraphicsEndImageContext();
    return croppedImage;
}


- (void)addGestures
{
    // create pinch
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    // add
    [self addGestureRecognizer:
        pinch
     ];
    
    // create & configure pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    // add pan
    [self addGestureRecognizer:pan];
    
    [pinch addTarget:self action:@selector(genericGesture:)];
    [pan addTarget:self action:@selector(genericGesture:)];
}

#pragma mark - Gestures

- (void)genericGesture:(UIGestureRecognizer*)gesture
{
    CGFloat duration = 0.1;
    if( gesture.state == UIGestureRecognizerStateBegan )
    {
        [UIView animateWithDuration:duration animations:^{
            [self.bar setAlpha:0];
        }];
    }
    else if( gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed || gesture.state == UIGestureRecognizerStateCancelled )
    {
        [UIView animateWithDuration:duration animations:^{
            [self.bar setAlpha:1];
        }];
    }
}

- (void)printState:(UIGestureRecognizer*)g
{
    id array = @{
                 
                 @(UIGestureRecognizerStatePossible):@"Possible",
                 
                 @(UIGestureRecognizerStateBegan):@"Began",
                 @(UIGestureRecognizerStateChanged):@"Changed",
                 @(UIGestureRecognizerStateEnded):@"Ended",
                 @(UIGestureRecognizerStateCancelled):@"Cancelled",
                 @(UIGestureRecognizerStateFailed):@"Failed",
                 @(UIGestureRecognizerStateRecognized):@"Recognized",
                 };
    NSLog(@"g = %@, state = %@",[g class], array[@(g.state)]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [touches arra]
    if( touches.count != 1 ){
        return;
    }

    CGFloat padding2 = 10;
    UITouch *touch = [touches.objectEnumerator nextObject];
    CGPoint point = [touch locationInView:self];
//    CGRect left = CGRectMake(_croppingRect.origin.x-padding2,
//                             _croppingRect.origin.y+cornerPadding,
//                             padding2*2,
//                             _croppingRect.size.height-(cornerPadding*2));
//    CGRect top = CGRectMake(_croppingRect.origin.x + cornerPadding,
//                            _croppingRect.origin.y - padding2,
//                            _croppingRect.size.width - (cornerPadding*2),
//                            padding2*2);
//    CGRect right = CGRectMake(_croppingRect.origin.x + _croppingRect.size.width - padding2,
//                              _croppingRect.origin.y - cornerPadding,
//                              padding2*2,
//                              _croppingRect.size.height - (cornerPadding*2));
//    CGRect bottom = CGRectMake(_croppingRect.origin.x + cornerPadding,
//                               _croppingRect.origin.y + _croppingRect.size.height - padding2,
//                               _croppingRect.size.width - (cornerPadding*2),
//                               padding2*2);
    CGRect left = CGRectMake(0,
                             0,
                             _croppingRect.origin.x + padding2,
                             self.frame.size.height);
    CGRect top = CGRectMake(0,
                            0,
                            self.frame.size.width,
                            _croppingRect.origin.y + padding2);
    CGRect right = CGRectMake(_croppingRect.origin.x + _croppingRect.size.width - padding2,
                              0,
                              self.frame.size.width,
                              self.frame.size.height);
    CGRect bottom = CGRectMake(0,
                               _croppingRect.origin.y + _croppingRect.size.height - padding2,
                               self.frame.size.width,
                               self.frame.size.height);

    
    if( CGRectContainsPoint(left, point) )
    {
        _resizingState |= Left;
    }
    if( CGRectContainsPoint(top, point) )
    {
        _resizingState |= Top;
    }
    if( CGRectContainsPoint(right, point) )
    {
        _resizingState |= Right;
    }
    if( CGRectContainsPoint(bottom, point) )
    {
        _resizingState |= Bottom;
    }
//    else
//    {
//        CGRect leftCorner = CGRectMake(_croppingRect.origin.x - cornerPadding, _croppingRect.origin.y - cornerPadding, cornerPadding, cornerPadding);
//        
//    }

}

- (void)pan:(UIPanGestureRecognizer*)pan
{
//    [self printState:pan];
    if( pan.state == UIGestureRecognizerStateEnded || !pan.numberOfTouches )
    {
        _panState = PanStateNone;
        _resizingState = None;
        return;
    }
    CGFloat padding = 5;
//    CGFloat padding2 = 5;
    CGPoint point = [pan locationOfTouch:0 inView:self];
    if( pan.state == UIGestureRecognizerStateBegan ){
        if( _resizingState != None ){
            NSLog(@"PanStateChangingSize");
            _panState = PanStateChangingSize;
            // resizing, no op
        } else if( CGRectContainsPoint(CGRectMake(_croppingRect.origin.x+padding, _croppingRect.origin.y+padding, _croppingRect.size.width-(padding*2), _croppingRect.size.height-(padding*2)), point) ){
            // moving
            NSLog(@"PanStateMoving");
            _panState = PanStateMoving;
        } else {
            NSLog(@"PanStateNone");
            _panState = PanStateNone;
            _resizingState = None;
            // cancel
            [pan setEnabled:NO];
            [pan setEnabled:YES];
            return;
        }
    }

    if( pan.state == UIGestureRecognizerStateChanged )
    {

        if( _panState == PanStateMoving ){
            // x
            _croppingRect.origin.x += (point.x-_lastDistancePan.x);
            // x checks
            _croppingRect.origin.x = _croppingRect.origin.x < 0 ? 0 : _croppingRect.origin.x;
            _croppingRect.origin.x = CGRectGetMaxX(_croppingRect) > self.bounds.size.width ? self.bounds.size.width - _croppingRect.size.width : _croppingRect.origin.x;
            
            // y
            _croppingRect.origin.y += (point.y-_lastDistancePan.y);
            // y checks
            _croppingRect.origin.y = _croppingRect.origin.y < 0 ? 0 : _croppingRect.origin.y;
            _croppingRect.origin.y = CGRectGetMaxY(_croppingRect) > self.bounds.size.height ? self.bounds.size.height - _croppingRect.size.height : _croppingRect.origin.y;
        } else if( _panState == PanStateChangingSize ){
            CGFloat distance;
            if( (_resizingState&Left) ){
                distance = _lastDistancePan.x - point.x;
                _croppingRect.origin.x -= distance;
                _croppingRect.size.width += distance;
            }
            if( (_resizingState&Top) ){
                distance = _lastDistancePan.y - point.y;
                _croppingRect.origin.y -= distance;
                _croppingRect.size.height += distance;
            }
            if( (_resizingState&Right) ){
                distance = _lastDistancePan.x - point.x;
                _croppingRect.size.width -= distance;
            }
            if( (_resizingState&Bottom) ){
                distance = _lastDistancePan.y - point.y;
                _croppingRect.size.height -= distance;
   
            }
            
        }
        // make redraw happen
        [self setNeedsDisplay];

    }
    // advance last distance
    _lastDistancePan = point;

    
 
}

- (void)pinch:(UIPinchGestureRecognizer*)pinch
{
    if( pinch.state == UIGestureRecognizerStateEnded || [pinch numberOfTouches] != 2 )
    {
        return;
    }
    
    // get points
    CGPoint point1 = [pinch locationOfTouch:0 inView:self];
    CGPoint point2 = [pinch locationOfTouch:1 inView:self];
    // calc diff
    int xDiff = fabs(point1.x-point2.x);
    int yDiff = fabs(point1.y-point2.y);
    
    if( pinch.state == UIGestureRecognizerStateChanged )
    {
        [self growWidth:(xDiff-_lastDistance.x)];
        [self growHeight:(yDiff-_lastDistance.y)];
        [self setNeedsDisplay];
    }
    
    _lastDistance.x = xDiff;
    _lastDistance.y = yDiff;
    
}

#pragma mark - Helper



- (void)growWidth:(int)distance
{
    _croppingRect.origin.x -= (distance/3.0);
    _croppingRect.size.width += (distance*2.0/3.0);
    // checks    
    _croppingRect.origin.x = _croppingRect.origin.x < 0 ? 0 : _croppingRect.origin.x;
    _croppingRect.size.width = _croppingRect.size.width < 20 ? 20 : _croppingRect.size.width;
    _croppingRect.size.width = _croppingRect.size.width > self.bounds.size.width ? self.bounds.size.width : _croppingRect.size.width;
}

- (void)growHeight:(int)distance
{
    _croppingRect.origin.y -= (distance/3.0);
    _croppingRect.size.height += (distance*2.0/3.0);
    // checks
    _croppingRect.origin.y = _croppingRect.origin.y < 0 ? 0 : _croppingRect.origin.y;
    _croppingRect.size.height = _croppingRect.size.height < 20 ? 20 : _croppingRect.size.height;
    _croppingRect.size.height = _croppingRect.size.height > self.bounds.size.height ? self.bounds.size.height : _croppingRect.size.height;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(c, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor);
    // fill bkg with black transparent
    CGContextFillRect(c, self.bounds);
    
    // set clear the cropping rect
    CGContextClearRect(c, self.croppingRect);

    // set cropping rect border
    CGContextSetStrokeColorWithColor(c, [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor);
    CGContextStrokeRect(c, self.croppingRect);
    
    CGFloat minHeightToShow = 100;
    UIColor *horizColor = [UIColor colorWithWhite:1 alpha:(self.croppingRect.size.height/minHeightToShow)-0.5];
    // draw lines
    // horizontal
    CGFloat yPart = self.croppingRect.size.height/3;
    CGFloat yLine;
    yLine = self.croppingRect.origin.y + yPart;

    CGContextBeginPath(c);
    CGContextMoveToPoint(c, self.croppingRect.origin.x,  yLine);
    CGContextAddLineToPoint(c, self.croppingRect.origin.x + self.croppingRect.size.width, yLine);
    CGContextSetStrokeColorWithColor(c, horizColor.CGColor);
    CGContextStrokePath(c);
    
    yLine = self.croppingRect.origin.y + (yPart * 2);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, self.croppingRect.origin.x, yLine);
    CGContextAddLineToPoint(c, self.croppingRect.origin.x + self.croppingRect.size.width, yLine);
    CGContextSetStrokeColorWithColor(c, horizColor.CGColor);
    CGContextStrokePath(c);

    CGFloat minWidthToShow = 100;
    UIColor *vertColor = [UIColor colorWithWhite:1 alpha:(self.croppingRect.size.width/minWidthToShow)-0.5];

    // vertical
    CGFloat xPart = self.croppingRect.size.width/3;
    CGFloat xLine;
    xLine = self.croppingRect.origin.x + xPart;
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, xLine,  self.croppingRect.origin.y);
    CGContextAddLineToPoint(c, xLine, self.croppingRect.origin.y + self.croppingRect.size.height);
    CGContextSetStrokeColorWithColor(c, vertColor.CGColor);
    CGContextStrokePath(c);

    xLine = self.croppingRect.origin.x + (xPart * 2);
    
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, xLine,  self.croppingRect.origin.y);
    CGContextAddLineToPoint(c, xLine, self.croppingRect.origin.y + self.croppingRect.size.height);
    CGContextSetStrokeColorWithColor(c, vertColor.CGColor);
    CGContextStrokePath(c);

    // vamos rafa
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, xLine,  self.croppingRect.origin.y);

    
    
}




@end
