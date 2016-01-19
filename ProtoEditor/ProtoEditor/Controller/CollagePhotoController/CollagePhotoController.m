//
//  CollagePhotoController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/18/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "CollagePhotoController.h"

@interface CollagePhotoController () <RACollectionViewDelegateReorderableTripletLayout,  RACollectionViewReorderableTripletLayoutDataSource, WSAssetPickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collagePhotoCollectionView;
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;

@end

@implementation CollagePhotoController
//*****************************************************************************
#pragma mark -
#pragma mark - ** Life Cycle **
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self config];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper Method **
- (void)config {
    
    // Delegate collage photo
    self.collagePhotoCollectionView.delegate = self;
    self.collagePhotoCollectionView.dataSource = self;
    [self.collagePhotoCollectionView reloadData];
    
    // Init array photo
    [self initRefreshBarButton];
    [self.collagePhotoCollectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    GuideController *guideController = InitStoryBoardWithIdentifier(kGuideController);
    [self.navigationController presentViewController:guideController animated:YES completion:nil];
    
}

- (void)initRefreshBarButton {
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc ] initWithImage:kRefreshImage style:UIBarButtonItemStylePlain target:self action:@selector(pickMultiplePhoto:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc ] initWithImage:kSaveImage style:UIBarButtonItemStylePlain target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **
- (IBAction)pickMultiplePhoto:(id)sender {
    
    self.assetsLibrary = [[ALAssetsLibrary alloc] init];
    WSAssetPickerController *picker = [[WSAssetPickerController alloc] initWithAssetsLibrary:self.assetsLibrary];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)saveImage {
    
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** WSAssetPickerControllerDelegate Methods **

- (void)assetPickerControllerDidCancel:(WSAssetPickerController *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)assetPickerController:(WSAssetPickerController *)sender didFinishPickingMediaWithAssets:(NSArray *)assets
{
    // Dismiss the picker controller.
    [self dismissViewControllerAnimated:YES completion:^{
        if (assets.count == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
            return;
        }
        int index = 0;
        
        [self.photosArray removeAllObjects];
        self.photosArray = nil;
        self.photosArray = [NSMutableArray array];
        // Run loop to add photo image
        for (ALAsset *asset in assets) {
            UIImage *image = [[UIImage alloc] initWithCGImage:asset.defaultRepresentation.fullScreenImage];
            [self.photosArray addObject:image];
            index++;
        }
        [self.collagePhotoCollectionView reloadData];
        
    }];
    
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Collection View Delegate **
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photosArray.count;
}

- (CGFloat)sectionSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (CGFloat)minimumInteritemSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (CGFloat)minimumLineSpacingForCollectionView:(UICollectionView *)collectionView
{
    return 5.f;
}

- (UIEdgeInsets)insetsForCollectionView:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(5.f, 0, 5.f, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForLargeItemsInSection:(NSInteger)section
{
    return RACollectionViewTripletLayoutStyleSquare; //same as default !
}

- (UIEdgeInsets)autoScrollTrigerEdgeInsets:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(0.f, 0, 0.f, 0); //Sorry, horizontal scroll is not supported now.
}

- (UIEdgeInsets)autoScrollTrigerPadding:(UICollectionView *)collectionView
{
    return UIEdgeInsetsMake(0.f, 0, 0, 0);
}

- (CGFloat)reorderingItemAlpha:(UICollectionView *)collectionview
{
    return .3f;
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collagePhotoCollectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    UIImage *image = [_photosArray objectAtIndex:fromIndexPath.item];
    [_photosArray removeObjectAtIndex:fromIndexPath.item];
    [_photosArray insertObject:image atIndex:toIndexPath.item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = kPhotoCollageCellIdentifier;
    CollagePhotoCell *cell = [self.collagePhotoCollectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.imageView removeFromSuperview];
    cell.imageView.frame = cell.bounds;
    cell.imageView.image = _photosArray[indexPath.item];
    [cell.contentView addSubview:cell.imageView];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Count = 1
    if (_photosArray.count == 1) {
        return;
    }
    
    // Count > 1
    [self.collagePhotoCollectionView performBatchUpdates:^{
        [_photosArray removeObjectAtIndex:indexPath.item];
        [self.collagePhotoCollectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collagePhotoCollectionView reloadData];
    }];
}

@end
