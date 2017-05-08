//
//  TriggerInfoCell.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TriggerInfoCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *nameLabel;
@property(nonatomic,weak) IBOutlet UILabel *urlLabel;
@property(nonatomic,weak) IBOutlet UILabel *datastreamidLabel;
@property(nonatomic,weak) IBOutlet UILabel *create_timeLabel;
@property(nonatomic,strong) NSDictionary *triggerInfo;
@end
