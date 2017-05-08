//
//  ONDataPointAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  数据点API 详情链接http://open.iot.10086.cn/doc/art260.html#68
 */
@interface ONDataPointAPI : NSObject
/**
 *  新增数据点
 *
 *  @param deviceId 当前设备ID
 *  @param bodyparam    请求参数 特定数据格式 {"lon":33.2,"lat":23,"ele":222}
 *  @param callback  请求回调
 */
+(void)reportDataPointWithDeviceId:(NSString *)deviceId
                      andBodyParam:(NSString *)bodyparam
                          callBack:(OneNETCallback)callback;

/**
 *  新增数据点
 *
 *  @param deviceId 当前设备ID
 *  @param type 格式类型,目前有3，4，5三种类型
 *  @param bodyparam    请求参数 特定数据格式 {"lon":33.2,"lat":23,"ele":222}
 *  @param callback  请求回调
 */
+(void)reportDataPointWithDeviceId:(NSString *)deviceId
                              type:(int)type
                      andBodyParam:(NSString *)bodyparam
                          callBack:(OneNETCallback)callback;


/**
 *  查询数据点
 *
 *  @param deviceId 当前设备ID
 *  @param param    请求参数
 *  @param callback  请求回调
 *
 */
+(void)queryDataPointWithDeviceId:(NSString *)deviceId
                         andParam:(NSDictionary *)param
                         callBack:(OneNETCallback)callback;
@end
