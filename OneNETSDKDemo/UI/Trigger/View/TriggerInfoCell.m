//
//  TriggerInfoCell.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "TriggerInfoCell.h"

@implementation TriggerInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTriggerInfo:(NSDictionary *)triggerInfo {
    _triggerInfo = triggerInfo;
    self.nameLabel.text = triggerInfo[@"title"];
    self.urlLabel.text = triggerInfo[@"url"];
    self.datastreamidLabel.text = [NSString stringWithFormat:@"%@",triggerInfo[@"ds_id"]];
    self.create_timeLabel.text = triggerInfo[@"create_time"];
}

@end
