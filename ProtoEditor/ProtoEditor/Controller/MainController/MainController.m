//
//  MainController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/5/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "MainController.h"

@interface MainController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark - Properties
@property (strong, nonatomic) UIImagePickerController *imagePicker;

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
    [self openLibraryPhoto];
}

- (IBAction)btnFilterCamera:(id)sender {
}

- (IBAction)btnSetting:(id)sender {
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
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [Photo share].imgPhoto = [info objectForKey:kUIImagePickerOriginalImage];
    PhotoEditorController *photoController = InitStoryBoardWithIdentifier(kPhotoEditorController);
    [self.navigationController pushViewController:photoController animated:YES];
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
