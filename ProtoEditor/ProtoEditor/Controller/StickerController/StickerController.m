//
//  StickerController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/11/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "StickerController.h"

@interface StickerController ()

#pragma mark - Properties
@property (strong, nonatomic) NSArray *listPhotoSticker;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageOriginal;
@property (weak, nonatomic) IBOutlet UICollectionView *photoStickerCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTopImageOriginal;

@end

@implementation StickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/*
 * Method config view
 */
- (void)config {
    self.title = kStickerTitle;
    [AppDelegate share].stickerController = self;
    [Utilities turnOnBarButton:self];
    
    // Set delegate for multiple device
    [Utilities fixAutolayoutWithDelegate:self];
    
    // Init
    self.listPhotoSticker = kListStickerImage;
    
    // Show image
    self.imageOriginal.image = kPhotoBlend;
    
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Collection View Delegate **

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.listPhotoSticker.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoStickerCellIdentifier" forIndexPath:indexPath];
    
    if (cell.selected) {
        [Utilities changeSelectedColorOfView:cell];
    } else {
        [Utilities changeDeselectedColorOfView:cell];
    }
    
    UIImageView *imgStickerCell = (UIImageView *)[cell viewWithTag:105];
    imgStickerCell.image = self.listPhotoSticker[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    [Utilities changeSelectedColorOfView:datasetCell];
    
    UIImage *imgSticker = self.listPhotoSticker[indexPath.row];
    DragView *imageStickerTmp = [[DragView alloc] initWithFrame:frameForSticker(self.view, imgSticker)];
    imageStickerTmp.viewDrag = self.imageOriginal;
    imageStickerTmp.userInteractionEnabled = YES;
    imageStickerTmp.image = imgSticker;
    [self.view addSubview:imageStickerTmp];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *datasetCell =[collectionView cellForItemAtIndexPath:indexPath];
    [Utilities changeDeselectedColorOfView:datasetCell];
}

- (void)applyFrameImage {
    UIImage *screenShot = takeScreenShot(self.view, realFrameForImage(kPhotoBlend, self.imageOriginal, self.constraintTopImageOriginal.constant));
    [Photo share].imgPhotoBlend =[UIImage scaleTo2xImage:screenShot];
}

@end
