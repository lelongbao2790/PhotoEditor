//
//  MainController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

#pragma mark - Properties

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantWidthButton;

@end

@implementation MainController

//*****************************************************************************
#pragma mark -
#pragma mark - ** Life Cycle **

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Config view
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper Method **

/*
 * Method config view
 */
- (void)config {
    // Set delegate for multiple device
    [Utilities fixAutolayoutWithDelegate:self];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **
- (IBAction)btnCollage:(id)sender {
}

- (IBAction)btnPhotoEdit:(id)sender {
}

- (IBAction)btnFilterCamera:(id)sender {
}

- (IBAction)btnSetting:(id)sender {
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Config screen with multiple device **

- (void)fixAutolayoutFor47 {
    self.constantWidthButton.constant = kConstantWidthButtonIp6;
}
- (void)fixAutolayoutFor55 {
    self.constantWidthButton.constant = kConstantWidthButtonIp6;
}
- (void)fixAutolayoutForIpad {
    self.constantWidthButton.constant = kConstantWidthButtonIpad;
}

@end
