//
//  ONDeviceAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  设备API 详情链接http://open.iot.10086.cn/doc/art262.html#68
 */
@interface ONDeviceAPI : NSObject

/**
 *  注册设备
 *
 *  @param registCode 设备注册码（必填）
 *  @param deviceInfo json字符串
 *  @param callback 回调
 */
+(void)registerDeviceWithRegistCode:(NSString *)registCode
                         deviceInfo:(NSString *)deviceInfo
                           callBack:(OneNETCallback)callback;

/**
 *  新增设备
 *
 *  @param deviceInfo 设备信息
 *  @param callback 回调
 */
+(void)addDeviceWithInfo:(NSString *)deviceInfo
                callBack:(OneNETCallback)callback;;

/**
 *  更新设备信息
 *
 *  @param deviceId 设备id
 *  @param deviceInfo 设备信息
 *  @param callback 回调
 */
+(void)editDeviceWithDeviceId:(NSString *)deviceId
                   deviceInfo:(NSString *)deviceInfo
                     callBack:(OneNETCallback)callback;

/**
 *  精确查询单个设备
 *
 *  @param deviceId 设备id
 *  @param callback 回调
 */
+(void)querySingleDeviceWithDeviceId:(NSString *)deviceId
                            callBack:(OneNETCallback)callback;
/**
 *  模糊查询设备
 *
 *  @param param 查询条件
 *  @param callback 回调
 */
+(void)fuzzyQueryDevicesWithParam:(NSDictionary *)param
                         callBack:(OneNETCallback)callback;
/**
 *  删除设备
 *
 *  @param deviceId 设备id
 *  @param callback 回调
 */
+(void)deleteDeviceWithDeviceId:(NSString *)deviceId
                       callBack:(OneNETCallback)callback;
@end
