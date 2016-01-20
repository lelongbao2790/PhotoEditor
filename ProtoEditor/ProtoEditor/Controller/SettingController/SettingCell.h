//
//  SettingCell.h
//  ProtoEditor
//
//  Created by Bao (Brian) L. LE on 1/20/16.
//  Copyright © 2016 Brian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameSetting;
@property (weak, nonatomic) IBOutlet UISwitch *switchSetting;
@property (weak, nonatomic) IBOutlet UIImageView *childPanelRightArrow;

@end
