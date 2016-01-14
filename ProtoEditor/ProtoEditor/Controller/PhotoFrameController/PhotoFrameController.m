//
//  PhotoFrameController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/11/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "PhotoFrameController.h"

@interface PhotoFrameController ()

#pragma mark - Properties
@property (strong, nonatomic) NSDictionary *dictPhotoFrame;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoFrameCollectionView;
@property (weak, nonatomic) IBOutlet DragView *imageOrignial;

@end

@implementation PhotoFrameController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate share].photoFrameController = self;
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
    [Utilities turnOnBarButton:self];
    
    // Set delegate for multiple device
    [Utilities fixAutolayoutWithDelegate:self];
    
    // Init
    self.dictPhotoFrame = kDictListFrameImage;
    [self.photoFrameCollectionView registerClass:[PhotoFrameCell class] forCellWithReuseIdentifier:kPhotoFrameCell];
    
    // Show image
    self.imageOrignial.image = kPhotoBlend;
    self.imageOrignial.userInteractionEnabled = YES;
    self.imageOrignial.viewDrag = self.imageView;
    
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Collection View Delegate **

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dictPhotoFrame.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoFrameCell *cell = (PhotoFrameCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kPhotoFrameCellIdentifier forIndexPath:indexPath];
    cell.imgFrameFromDict = self.dictPhotoFrame.allValues[indexPath.row];
    [cell loadImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *frameImg = self.dictPhotoFrame.allValues[indexPath.row];
    self.imageView.image = frameImg;
}

- (void)applyFrameImage {
    [Photo share].imgPhotoBlend = [UIImage scaleTo2xImage:takeScreenShot(self.view, self.imageView.frame)];
}

@end
