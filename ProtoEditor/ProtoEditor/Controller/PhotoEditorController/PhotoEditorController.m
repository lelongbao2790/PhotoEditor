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
@property (strong, nonatomic) NSMutableArray *faceDetect;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *optionCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantBottomImage;

@end

@implementation PhotoEditorController

//*****************************************************************************
#pragma mark -
#pragma mark - ** Life Cycle **

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Config
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
    
    // Set image
    [self showImage];
    
    // Detect face
    if ([Photo share].imgPhoto) {}
}

/*
 * Show image from photo
 */
- (void)showImage {
    
    self.imageView.image = [Photo share].imgPhoto;
    
    // Caculate image size to present
    self.imageView.contentMode = UIViewContentModeCenter;
    if (kWidthImageView(self.imageView) > (kWidthImagePhoto && kHeighImageView(self.imageView) > (kHeighImagePhoto))) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
}

@end
