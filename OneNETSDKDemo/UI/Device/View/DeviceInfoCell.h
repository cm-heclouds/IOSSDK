//
//  DeviceInfoCell.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoCell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *devicenameLabel;
@property(nonatomic,weak) IBOutlet UILabel *protocolLabel;
@property(nonatomic,weak) IBOutlet UILabel *deviceidLabel;
@property(nonatomic,weak) IBOutlet UILabel *create_timeLabel;
@property(nonatomic,weak) IBOutlet UILabel *onlineLabel;
@property(nonatomic,strong) NSDictionary *deviceInfo;
@end
