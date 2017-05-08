//
//  ONTriggerAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  触发器相关API 详情链接http://open.iot.10086.cn/doc/art259.html#68
 */
@interface ONTriggerAPI : NSObject
/**
 *  添加触发器
 *
 *  @param bodyparam    请求参数
 *  @param callback  请求回调
 *
 */
+(void)addTriggerWithBodyParam:(NSString *)bodyparam
                      callBack:(OneNETCallback)callback;

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
                       callBack:(OneNETCallback)callback;

/**
 *  读取单个触发器数据
 *
 *  @param triggerId  触发器ID
 *  @param callback  请求回调
 *
 */
+(void)queryTriggerWithTriggerId:(NSString *)triggerId
                        callBack:(OneNETCallback)callback;

/**
 *  批量读取触发器
 *
 *  @param param  查询参数
 *  @param callback  请求回调
 *
 */
+(void)queryTriggerWithParam:(NSDictionary *)param
                    callBack:(OneNETCallback)callback;

/**
 *  删除触发器
 *
 *  @param triggerId  触发器ID
 *  @param callback  请求回调
 */
+(void)deleteTriggerWithTriggerId:(NSString *)triggerId
                         callBack:(OneNETCallback)callback;
@end
