//
//  ONDataStreamAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  数据流API 详情链接http://open.iot.10086.cn/doc/art261.html#68
 */
@interface ONDataStreamAPI : NSObject
/**
 *  为设备增加一条数据流，用于存储和展现数据。(数据上报需要上报到具体的一条数据流）
 *
 *  @param deviceId 当前设备ID
 *  @param bodyparam 请求参数
 *  @param callback  请求回调
 *
 */
+(void)addDataStreamWithDeviceId:(NSString *)deviceId
                    andBodyParam:(NSString *)bodyparam
                        callBack:(OneNETCallback)callback;

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
                         callBack:(OneNETCallback)callback;

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
                                callBack:(OneNETCallback)callback;

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
                                callBack:(OneNETCallback)callback;

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
                           callBack:(OneNETCallback)callback;
@end
