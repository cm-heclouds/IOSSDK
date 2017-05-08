//
//  ONMqttAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONMqttAPI.h"
#import "ONHttpClient.h"

@implementation ONMqttAPI
/**
 *  按Topic发送命令
 *
 *  @param topic 设备订阅的主题
 *  @param bodyparam    自定义请求参数
 *  @param callback  请求回调
 *
 */
+(void)sentCmdByTopic:(NSString *)topic
            bodyParam:(NSString *)bodyparam
             callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt?topic=%@",topic];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:bodyparam
                                    requestType:ONHttpPOST
                                       callback:callback];
}

/**
 *  查询订阅指定Topic设备的列表
 *
 *  @param topic 备订阅的主题（必选）
 *  @param page    当前页码. 必填,大于等于1
 *  @param per_page    每页. 必填，范围1-1000
 *  @param callback  请求回调
 *
 */
+(void)queryDevicesByTopic:(NSString *)topic
                      page:(int)page
                  per_page:(int)per_page
                  callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt/topic_device"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:@{@"topic":topic,@"page":@(page),@"per_page":@(per_page)}
                                    requestType:ONHttpGET
                                       callback:callback];
}


/**
 *  查询设备订阅的Topic列表
 *
 *  @param deviceId deviceId
 *  @param callback  请求回调
 *
 */
+(void)queryTopicsByDeviceId:(NSString *)deviceId
                    callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt/device_topic/%@",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}


/**
 *  创建产品的Topic
 *
 *  @param bodyparam    自定义请求参数
 *  @param callback  请求回调
 *
 */
+(void)addTopicWithBodyParam:(NSString *)bodyparam
                    callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt/topic"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];

}

/**
 *  删除产品的Topic
 *
 *  @param topic 设备订阅的主题
 *  @param callback  请求回调
 *
 */
+(void)deleteTopic:(NSString *)topic
          callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt/topic?name=%@",topic];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpDELETE
                                       callback:callback];
}


/**
 *  查询产品Topic
 *
 *  @param callback  请求回调
 *
 */
+(void)queryAllTopicsWithCallBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"mqtt/topic"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}

@end
