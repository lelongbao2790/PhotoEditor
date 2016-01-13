//
//  PhotoEditorController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "PhotoEditorController.h"

@interface PhotoEditorController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark - Properties
@property (assign, nonatomic) NSInteger typePhotoEdit;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) UIImage *tempImage;

#pragma mark - IBOutlet
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantWidthButton;
@property (weak, nonatomic) IBOutlet UIView *viewEdit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollEdit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantBottomImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantLeftImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantRightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantTopImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintWidthCenterImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightCenterImage;
@property (strong, nonatomic) IBOutlet UIView *viewChangeEdit;
@property (weak, nonatomic) IBOutlet NYSliderPopover *sliderChange;
@property (weak, nonatomic) IBOutlet UIView *viewChangePhotoEdit;
@property (weak, nonatomic) IBOutlet NYSliderPopover *sliderExposure;
@property (weak, nonatomic) IBOutlet NYSliderPopover *sliderConstrast;
@property (weak, nonatomic) IBOutlet UIImageView *centerImageBlur;


@end

@implementation PhotoEditorController

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

- (void)viewWillAppear:(BOOL)animated {
    // Config
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveImage)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    [self showImage];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.navigationItem.rightBarButtonItem = nil;
    self.centerImageBlur.hidden = YES;
}

- (void)viewDidLayoutSubviews {
    [self.scrollEdit setContentSize:CGSizeMake(self.viewEdit.frame.size.width + 100, self.viewEdit.frame.size.height)];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Action for Photo Editor **
/*
 * Open library photo
 */
- (void)openLibraryPhoto {
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [Photo share].imgPhoto = [info objectForKey:kUIImagePickerOriginalImage];
    [Photo share].imgPhotoBlend = nil;
    [self showImage];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper Method **

/*
 * Method config view
 */
- (void)config {
    
    [AppDelegate share].photoController = self;
    
    // Set delegate for multiple device
    [Utilities fixAutolayoutWithDelegate:self];
    
    // Update slider value
    [self updateSliderValue];
     [self.imageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLibraryPhoto)];
    [self.imageView addGestureRecognizer:tapImage];
}

/*
 * Update slider value
 */
- (void)updateSliderValue {
    // Slider
    self.sliderChange.popover.textLabel.text = kValueString(self.sliderChange.value);
    self.sliderExposure.popover.textLabel.text = kValueString(self.sliderExposure.value);
    self.sliderConstrast.popover.textLabel.text = kValueString(self.sliderConstrast.value);
}

- (void)showImage {
    
    self.imageView.image = kPhotoBlend;
    self.centerImageBlur.hidden = YES;
}

/*
 * Zoom in image
 */
- (void)zoomInImage {
    [Utilities addAnimation:self.imageView];
    self.constantTopImage.constant = kConstantTopImageEdit;
    self.constantBottomImage.constant = kConstantBottomImageEdit;
    self.constantLeftImage.constant = kConstantLeftImageEdit;
    self.constantRightImage.constant = kConstantRightImageEdit;
}

/*
 * Zoom out image
 */
- (void)zoomOutImage {
    [Utilities addAnimation:self.imageView];
    self.constantTopImage.constant = kConstantTopImageNormal;
    self.constantBottomImage.constant = kConstantBottomImageNormal;
    self.constantLeftImage.constant = kConstantLeftImageNormal;
    self.constantRightImage.constant = kConstantRightImageNormal;
}

/*
 * Delete action
 */
- (void)deleteAction {
    [Photo share].imgPhotoBlend = nil;
    [self hideEditView];
    [self zoomOutImage];
    [Utilities addAnimation:self.viewChangePhotoEdit];
    self.viewChangePhotoEdit.hidden = YES;
}

/*
 * Delete action
 */
- (void)applyAction {
    // Reset to default
    [self hideEditView];
    [self zoomOutImage];
    
    [Utilities addAnimation:self.viewChangePhotoEdit];
    self.viewChangePhotoEdit.hidden = YES;
}

/*
 * Apply image
 */
- (void)applyImageWithSlideValue {
    // Set value slider to photo
    [[Photo share] setPhotoColor:self.sliderChange.value andExposure:self.sliderExposure.value andConstrast:self.sliderConstrast.value];
    
    // Filter image
    ProgressBarShowLoading(kStringLoading);
    [Utilities filterImageWithImage:kPhotoBlend andType:self.typePhotoEdit withCompletion:^(UIImage * _Nonnull imageComplete) {
        ProgressBarDismissLoading(kStringDone);
        [Photo share].imgPhotoBlend = imageComplete;
        self.imageView.image = imageComplete;
        [Utilities caculateImageSizeToPresent:self.imageView];
        [self applyAction];
        
    }];
}

/*
 * Show / Hide view edit
 */
- (void)showEditView {
    // Config slider menu
    self.sliderChange.value = [Photo share].brightnessValue;
    self.sliderConstrast.value = [Photo share].constrastValue;
    self.sliderExposure.value = [Photo share].exposureValue;
    
    // Show view
    [Utilities addAnimation:self.scrollEdit];
    self.scrollEdit.hidden = NO;
}

/*
 * Hide edit view
 */
- (void)hideEditView {
    [Utilities addAnimation:self.scrollEdit];
    self.scrollEdit.hidden = YES;
}

/*
 * Zoom photo
 */
- (void)zoomPhoto {
    [self hideEditView];
    [self zoomInImage];
}

/*
 * Config view change edit
 */
- (void)configViewChangeEdit {
    [Utilities addAnimation:self.viewChangePhotoEdit];
    self.viewChangePhotoEdit.hidden = NO;
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** IBAction **
- (IBAction)btnEdit:(id)sender {
    if (self.scrollEdit.hidden && self.viewChangePhotoEdit.hidden) {
        [self showEditView];
    } else {
        [self hideEditView];
    }
}

- (IBAction)btnBlend:(id)sender {
    [self hideEditView];
}
- (IBAction)btnFrame:(id)sender {
    [self hideEditView];
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Edit action **

- (IBAction)btnColor:(id)sender {
    [Utilities turnOnBarButton:self];
    
    [self.viewChangePhotoEdit addSubview:self.viewChangeEdit];
    self.typePhotoEdit = kTypeColor;
    [self zoomPhoto];
    [self configViewChangeEdit];
}
- (IBAction)btnBrightnessChange:(id)sender {
    [self updateSliderValue];
}

- (IBAction)btnSliderExposure:(id)sender {
    [self updateSliderValue];
}
- (IBAction)btnSliderConstrast:(id)sender {
    [self updateSliderValue];
}
- (IBAction)btnBlur:(id)sender {
    if (self.centerImageBlur.hidden) {
        ProgressBarShowLoading(kStringLoading);
        [self performSelectorInBackground:@selector(blurImage) withObject:nil];
    }
}

- (void)blurImage {
    [Utilities filterImageWithImage:kPhotoBlend andType:kTypeBlur withCompletion:^(UIImage * _Nonnull imageComplete) {
        [self performSelectorOnMainThread:@selector(updateBlurImageInMain:) withObject:imageComplete waitUntilDone:YES];
    }];
}

- (void)updateBlurImageInMain:(UIImage *)imageComplete {
    [self hideEditView];
    ProgressBarDismissLoading(@"");
    self.imageView.image = imageComplete;
    self.centerImageBlur.image = kPhotoBlend;
    self.centerImageBlur.hidden = NO;
    self.centerImageBlur.layer.cornerRadius = 5.0;
    self.centerImageBlur.layer.borderColor = [UIColor whiteColor].CGColor;
    self.centerImageBlur.layer.borderWidth = 1.0f;
    self.constraintWidthCenterImage.constant = [Utilities frameForImage:kPhotoBlend inImageViewAspectFit:self.centerImageBlur].size.width;
    self.constraintHeightCenterImage.constant = [Utilities frameForImage:kPhotoBlend inImageViewAspectFit:self.centerImageBlur].size.height;
    CGRect realRectImage = [Utilities caculateFrameImage:imageComplete andImageView:self.imageView andTopConstant:self.constantTopImage.constant];
     [Photo share].imgPhotoBlend = [UIImage imageWithImage:[Utilities captureView:self.view withRect:realRectImage] scaledToSize:[Photo share].imgPhoto.size];
}

- (IBAction)btnCropImage:(id)sender {
    
}

- (void)saveImage {
    if (self.tempImage) {
        self.imageView.image = self.tempImage;
        [Photo share].imgPhotoBlend = self.tempImage;
        self.tempImage = nil;
    }
    
    UIImageWriteToSavedPhotosAlbum(kPhotoBlend, nil, nil, nil);
    [Utilities showiToastMessage:kSaveImageSuccess];
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
