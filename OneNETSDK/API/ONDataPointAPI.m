//
//  ONDataPointAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONDataPointAPI.h"
#import "ONHttpClient.h"

@implementation ONDataPointAPI
/**
 *  新增数据点
 *
 *  @param deviceId 当前设备ID
 *  @param bodyparam    请求参数 特定数据格式 {"lon":33.2,"lat":23,"ele":222}
 *  @param callback  请求回调
 */
+(void)reportDataPointWithDeviceId:(NSString *)deviceId
                      andBodyParam:(NSString *)bodyparam
                          callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datapoints",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}

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
                          callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datapoints?type=%d",deviceId,type];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}


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
                         callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datapoints",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:param
                                    requestType:ONHttpGET
                                       callback:callback];
}
@end
