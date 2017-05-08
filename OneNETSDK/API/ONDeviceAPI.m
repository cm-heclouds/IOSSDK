//
//  ONDeviceAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONDeviceAPI.h"
#import "ONHttpClient.h"

@implementation ONDeviceAPI
/**
 注册设备
 
 @param registCode 设备注册码（必填）
 @param deviceInfo json字符串
 @param callback 回调
 */
+(void)registerDeviceWithRegistCode:(NSString *)registCode
                         deviceInfo:(NSString *)deviceInfo
                           callBack:(OneNETCallback)callback {
    [[ONHttpClient sharedInstance] fetchWithURL:[NSString stringWithFormat:@"register_de?register_code = %@",registCode]
                                         params:[deviceInfo dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}

/**
 新增设备
 
 @param deviceInfo 设备信息
 @param callback 回调
 */
+(void)addDeviceWithInfo:(NSString *)deviceInfo
                callBack:(OneNETCallback)callback {
    [[ONHttpClient sharedInstance] fetchWithURL:@"devices"
                                         params:[deviceInfo dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}


/**
 更新设备信息
 
 @param deviceId 设备id
 @param deviceInfo 设备信息
 @param callback 回调
 */
+(void)editDeviceWithDeviceId:(NSString *)deviceId
                   deviceInfo:(NSString *)deviceInfo
                     callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[deviceInfo dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPUT
                                       callback:callback];
}


/**
 精确查询单个设备
 
 @param deviceId 设备id
 @param callback 回调
 */
+(void)querySingleDeviceWithDeviceId:(NSString *)deviceId
                            callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}
/**
 模糊查询设备
 
 @param param 查询条件
 @param callback 回调
 */
+(void)fuzzyQueryDevicesWithParam:(NSDictionary *)param
                         callBack:(OneNETCallback)callback {
    [[ONHttpClient sharedInstance] fetchWithURL:@"devices"
                                         params:param
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 删除设备
 
 @param deviceId 设备id
 @param callback 回调
 */
+(void)deleteDeviceWithDeviceId:(NSString *)deviceId
                       callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpDELETE
                                       callback:callback];
}

@end
