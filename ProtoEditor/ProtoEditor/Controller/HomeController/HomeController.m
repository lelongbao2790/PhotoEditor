//
//  HomeController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/8/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate share].homeController = self;
    [Utilities turnOffBarButton:self];
    self.title = kPhotoEditorTitle;
    self.view.backgroundColor = [UIColor colorWithPatternImage:kBackgroundImage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(orientationChanged:)    name:UIDeviceOrientationDidChangeNotification  object:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btnDelete:(id)sender {
    [Utilities turnOffBarButton:getController];
    
    if ([getController isKindOfClass:[PhotoEditorController class]]) {
        [[AppDelegate share].photoController deleteAction];
    } else {
        [getController.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)btnDone:(id)sender {
    [Utilities turnOffBarButton:getController];
    if ([getController isKindOfClass:[PhotoEditorController class]]) {
        [[AppDelegate share].photoController applyImageWithSlideValue];
    } else if ([getController isKindOfClass:[PhotoFrameController class]]) {
        [[AppDelegate share].photoFrameController applyFrameImage];
        [getController.navigationController popViewControllerAnimated:YES];
    } else if ([getController isKindOfClass:[StickerController class]]) {
        [[AppDelegate share].stickerController applyFrameImage];
        [getController.navigationController popViewControllerAnimated:YES];
    }
    else {
        [getController.navigationController popViewControllerAnimated:YES];
    }
}

////*****************************************************************************
//#pragma mark -
//#pragma mark - ** Detect Rotate View **
//
//- (void)orientationChanged:(NSNotification *)notification{
//    [self adjustViewsForOrientation:[[UIDevice currentDevice] orientation]];
//}
//
//- (void) adjustViewsForOrientation:(UIDeviceOrientation) orientation {
//    if (UIDeviceOrientationIsValidInterfaceOrientation(orientation) && UIDeviceOrientationIsLandscape(orientation) ) {
//        // handle landscape
//        [self changeConstantForLandScape];
//        
//    } else if (UIDeviceOrientationIsValidInterfaceOrientation(orientation) && UIDeviceOrientationIsPortrait(orientation)) {
//        // handle portrait
//        [self changeConstantForPortrait];
//    } else {
//        // handle landscape
//        [self changeConstantForLandScape];
//    }
//}
//
///*
// * Change constant for land scape
// */
//- (void)changeConstantForLandScape {
//    if ([getController isKindOfClass:[HomeController class]] || [getController isKindOfClass:[MainController class]] ) {
//        [AppDelegate share].mainController.constraintTopButton.constant = kTopButtonOnMainLandscape;
//        [AppDelegate share].mainController.constraintLeadingButton.constant = kLeadingButtonLandscape;
//        [AppDelegate share].mainController.constraintTrailingButton.constant = kLeadingButtonLandscape;
//    }
//    else if ([getController isKindOfClass:[PhotoEditorController class]]){
//        [AppDelegate share].photoController.constantLeadingButton.constant = kLeadingButtonLandscape;
//    }
//}
//
///*
// * Change constant for portrait
// */
//- (void)changeConstantForPortrait {
//    if ([getController isKindOfClass:[HomeController class]] || [getController isKindOfClass:[MainController class]]) {
//        [AppDelegate share].mainController.constraintTopButton.constant = kTopButtonOnMainPortrait;
//        [AppDelegate share].mainController.constraintLeadingButton.constant = kLeadingButtonPortrait;
//        [AppDelegate share].mainController.constraintTrailingButton.constant = kLeadingButtonPortrait;
//    }
//    else if ([getController isKindOfClass:[PhotoEditorController class]]){
//        [AppDelegate share].photoController.constantLeadingButton.constant = kLeadingButtonPortrait;
//    }
//}

@end
