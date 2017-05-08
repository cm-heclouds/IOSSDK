//
//  DeviceInfoCell.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "DeviceInfoCell.h"

@implementation DeviceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDeviceInfo:(NSDictionary *)deviceInfo {
    _deviceInfo = deviceInfo;
    self.devicenameLabel.text = deviceInfo[@"title"];
    self.protocolLabel.text = deviceInfo[@"protocol"];
    self.deviceidLabel.text = [NSString stringWithFormat:@"%@",deviceInfo[@"id"]];
    self.create_timeLabel.text = deviceInfo[@"create_time"];
    BOOL online = [deviceInfo[@"online"] boolValue];
    self.onlineLabel.text = online ? @"online" : @"offline";
    self.onlineLabel.textColor = online ? [UIColor greenColor] : [UIColor redColor];
    self.onlineLabel.hidden = [deviceInfo[@"protocol"] isEqualToString:@"HTTP"];
}

@end
