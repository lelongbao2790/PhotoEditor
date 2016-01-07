//
//  BlendViewController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/7/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "BlendViewController.h"

@interface BlendViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - Properties
@property (strong, nonatomic) NSDictionary *dictFilter;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantBottomImage;
@property (weak, nonatomic) IBOutlet UIView *viewLoading;

@end

@implementation BlendViewController

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

/*
 * Method config view
 */
- (void)config {
    // Set delegate for multiple device
    [Utilities fixAutolayoutWithDelegate:self];
    
    // Init
    self.filterCollectionView.delegate = self;
    self.dictFilter = kDictListFilter;
    
    // Register custom cell
    [self.filterCollectionView registerClass:[FilterCell class] forCellWithReuseIdentifier:kFilterCell];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self.dictFilter.allKeys indexOfObject:@"None"] inSection:0];
    [self.filterCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    // Show image
    self.imageView.image = [Photo share].imgPhoto;
    [Utilities caculateImageSizeToPresent:self.imageView];
    
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Collection View Delegate **

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dictFilter.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilterCell *cell = (FilterCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kFilterCellIdentifier forIndexPath:indexPath];
    NSInteger numberType = [self.dictFilter.allValues[indexPath.row] integerValue];
    [cell loadImageWithType:numberType andText:self.dictFilter.allKeys[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewLoading setHidden:NO];
    NSInteger numberType = [self.dictFilter.allValues[indexPath.row] integerValue];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{ // 1
        [Utilities filterImageWithImage:[Photo share].imgPhoto andType:numberType withCompletion:^(UIImage * _Nonnull imageComplete) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = imageComplete;
                [self.viewLoading setHidden:YES];
            });
        }];
    });
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **

- (IBAction)btnDelete:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [Photo share].imgPhotoBlend = self.imageView.image;
}

@end