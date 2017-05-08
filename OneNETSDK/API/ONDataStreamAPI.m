//
//  ONDataStreamAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONDataStreamAPI.h"
#import "ONHttpClient.h"

@implementation ONDataStreamAPI
/**
 *  为设备增加一条数据流，用于存储和展现数据。(数据上报需要上报到具体的一条数据流）
 *
 *  @param deviceId 当前设备ID
 *  @param callback  请求回调
 *
 */
+(void)addDataStreamWithDeviceId:(NSString *)deviceId
                    andBodyParam:(NSString *)bodyparam
                        callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datastreams",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}

/**
 *  编辑数据流信息（数据流ID不能修改）
 *
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *  @param bodyparam    请求参数
 *  @param callback  请求回调
 *
 */
+(void)editDataStreamWithDeviceId:(NSString *)deviceId
                     dataStreamId:(NSString *)streamId
                        bodyParam:(NSString *)bodyparam
                         callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datastreams/%@",deviceId,streamId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPUT
                                       callback:callback];
}

/**
 *  读取单个数据流
 *
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *  @param callback  请求回调
 *
 */
+(void)querySingleDataStreamWithDeviceId:(NSString *)deviceId
                            dataStreamId:(NSString *)streamId
                                callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datastreams/%@",deviceId,streamId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  读取多个设备数据流
 *
 *  @param deviceId 当前设备ID
 *  @param dataStreamIds   请求参数 为datastream_ids=dataStringID1,dataStringId2
 *  @param callback  请求回调
 *
 */
+(void)queryMultiDataStreamsWithDeviceId:(NSString *)deviceId
                           dataStreamIds:(NSArray *)dataStreamIds
                                callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datastreams",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:@{@"datastream_ids":[dataStreamIds componentsJoinedByString:@","]}
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  删除数据流（删除数据流将删除所有数据）
 *
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *  @param callback  请求回调
 *
 */
+(void)deleteDataStreamWithDeviceId:(NSString *)deviceId
                       dataStreamId:(NSString *)streamId
                           callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"devices/%@/datastreams/%@",deviceId,streamId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpDELETE
                                       callback:callback];
}
@end
