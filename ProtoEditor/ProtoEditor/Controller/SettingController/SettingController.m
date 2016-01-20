//
//  SettingController.m
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/20/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import "SettingController.h"

@interface SettingController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *listSetting;

@property (weak, nonatomic) IBOutlet UITableView *tableSetting;

@end

@implementation SettingController

//*****************************************************************************
#pragma mark -
#pragma mark - ** Life Cycle **

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listSetting = kListSetting;
    // This will remove extra separators from tableview
    self.tableSetting.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableSetting.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//*****************************************************************************
#pragma mark -
#pragma mark - ** Helper Method **

//*****************************************************************************
#pragma mark -
#pragma mark - ** Table View Delegate **

-  (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kNumberOfSectionDefault;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listSetting.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingIdentifier];
    if (cell == nil) {
        cell = (SettingCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSettingIdentifier];
    }
    cell.nameSetting.text = self.listSetting[indexPath.row];
    
    // Test
    if (indexPath.row == 2) {
        cell.switchSetting.hidden = YES;
        cell.childPanelRightArrow.hidden = NO;
    } else {
        // Set background cell
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}
@end
