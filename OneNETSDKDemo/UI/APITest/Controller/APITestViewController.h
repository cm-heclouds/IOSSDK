//
//  APITestViewController.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/26.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "BaseCenterViewController.h"
#import "ONDeviceAPI.h"
#import "NSDictionary+on_addition.h"

@interface APITestViewController : BaseCenterViewController
@property(nonatomic,copy) OneNETCallback callback;
- (void)alertTextFieldDidChange:(NSNotification *)notification;
@end
