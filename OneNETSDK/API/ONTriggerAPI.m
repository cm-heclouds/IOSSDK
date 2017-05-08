//
//  ONTriggerAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONTriggerAPI.h"
#import "ONHttpClient.h"

@implementation ONTriggerAPI
/**
 *  添加触发器
 *
 *  @param bodyparam    请求参数
 *  @param callback  请求回调
 *
 */
+(void)addTriggerWithBodyParam:(NSString *)bodyparam
                      callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"triggers"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}

/**
 *  编辑触发器
 *
 *  @param triggerId  触发器ID
 *  @param bodyparam    请求参数
 *  @param callback  请求回调
 *
 */
+(void)editTriggerWithTriggerId:(NSString *)triggerId
                      bodyParam:(NSString *)bodyparam
                       callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"triggers/%@",triggerId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPUT
                                       callback:callback];
}

/**
 *  读取单个触发器数据
 *
 *  @param triggerId  触发器ID
 *  @param callback  请求回调
 *
 */
+(void)queryTriggerWithTriggerId:(NSString *)triggerId
                        callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"triggers/%@",triggerId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  批量读取触发器
 *
 *  @param param  查询参数
 *  @param callback  请求回调
 *
 */
+(void)queryTriggerWithParam:(NSDictionary *)param
                    callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"triggers"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:param
                                    requestType:ONHttpGET
                                       callback:callback];

}

/**
 *  删除触发器
 *
 *  @param triggerId  触发器ID
 *  @param callback  请求回调
 */
+(void)deleteTriggerWithTriggerId:(NSString *)triggerId
                         callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"triggers/%@",triggerId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpDELETE
                                       callback:callback];
}
@end
