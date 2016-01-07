//
//  PhotoEditorController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "PhotoEditorController.h"

@interface PhotoEditorController ()

#pragma mark - Properties
@property (assign, nonatomic) BOOL isShowViewEdit;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantWidthButton;
@property (weak, nonatomic) IBOutlet UIView *viewEdit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollEdit;


@end

@implementation PhotoEditorController

//*****************************************************************************
#pragma mark -
#pragma mark - ** Life Cycle **

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // Config
    [self config];
}

- (void)viewDidLayoutSubviews {
    [self.scrollEdit setContentSize:CGSizeMake(self.viewEdit.frame.size.width * 2, self.viewEdit.frame.size.height)];
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
    
    
    // Edit view
    self.viewEdit.hidden = YES;
    self.isShowViewEdit = NO;
    self.scrollEdit.hidden = YES;
    self.scrollEdit.backgroundColor = kColorBlackWithAlpha;
    
    
    // Show image
    [self showImage];
}

- (void)showImage {
    if ([Photo share].imgPhotoBlend) {
        self.imageView.image = [Photo share].imgPhotoBlend;
    } else {
        self.imageView.image = [Photo share].imgPhoto;
    }
    [Utilities caculateImageSizeToPresent:self.imageView];
}

- (void)configScrollView {
    
}


//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **
- (IBAction)btnEdit:(id)sender {
    if (self.isShowViewEdit) {
        [self hideEditView];
    } else {
        [self showEditView];
    }
}

/*
 * Show / Hide view edit
 */
- (void)showEditView {
    self.isShowViewEdit = YES;
    [Utilities addAnimation:self.scrollEdit];
    self.viewEdit.hidden = NO;
    self.scrollEdit.hidden = NO;
}

/*
 * Hide edit view
 */
- (void)hideEditView {
    self.isShowViewEdit = NO;
    [Utilities addAnimation:self.scrollEdit];
    self.viewEdit.hidden = YES;
    self.scrollEdit.hidden = YES;
}


- (IBAction)btnBlend:(id)sender {
    [self hideEditView];
    BlendViewController *blendController = InitStoryBoardWithIdentifier(kBlendController);
    [self presentViewController:blendController animated:YES completion:nil];
}
- (IBAction)btnFrame:(id)sender {
    [self hideEditView];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Config screen with multiple device **

- (void)fixAutolayoutFor35 {
    self.constantWidthButton.constant = kConstantWidthButtonPhotoEditIp5;
}
- (void)fixAutolayoutFor40 {
    self.constantWidthButton.constant = kConstantWidthButtonPhotoEditIp5;
}
- (void)fixAutolayoutFor47 {
    self.constantWidthButton.constant = kConstantWidthButtonPhotoEditIp6;
}
- (void)fixAutolayoutFor55 {
    self.constantWidthButton.constant = kConstantWidthButtonPhotoEditIp6;
}
- (void)fixAutolayoutForIpad {
    self.constantWidthButton.constant = kConstantWidthButtonPhotoEditIp6;
}


@end
