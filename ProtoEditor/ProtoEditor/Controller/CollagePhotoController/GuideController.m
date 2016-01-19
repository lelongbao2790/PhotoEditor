//
//  GuideController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/19/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "GuideController.h"

@interface GuideController ()

@end

@implementation GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:kColorBlackWithAlpha];
    UITapGestureRecognizer *tapOutSide = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutSideController)];
    [self.view addGestureRecognizer:tapOutSide];
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

- (void)tapOutSideController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
