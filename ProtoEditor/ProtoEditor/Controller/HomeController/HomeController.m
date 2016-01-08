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
- (IBAction)btnDelete:(id)sender {
    [Utilities turnOffBarButton:getController];
    if ([getController isKindOfClass:[BlendViewController class]]) {
        [getController.navigationController popViewControllerAnimated:YES];
        [Photo share].imgPhotoBlend = nil;
    } else if ([getController isKindOfClass:[PhotoEditorController class]]) {
         [[AppDelegate share].photoController deleteAction];
    }
    
}
- (IBAction)btnDone:(id)sender {
    [Utilities turnOffBarButton:getController];
    if ([getController isKindOfClass:[BlendViewController class]]) {
        [getController.navigationController popViewControllerAnimated:YES];
    } else if ([getController isKindOfClass:[PhotoEditorController class]]) {
        [[AppDelegate share].photoController applyImageWithSlideValue];
    }
}

@end
