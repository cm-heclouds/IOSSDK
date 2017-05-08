//
//  OneNETSDK.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/18.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "OneNETSDK.h"
#import "ONHttpClient.h"

@implementation OneNETSDK
+(void)setAPIKey:(NSString *)apikey {
    [[ONHttpClient sharedInstance] setApikey:apikey];
}
+(void)setBaseURL:(NSString *)baseURL {
    [[ONHttpClient sharedInstance] setBaseURL:baseURL];
}
@end
