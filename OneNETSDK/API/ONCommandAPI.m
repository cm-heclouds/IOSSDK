//
//  ONCommandAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONCommandAPI.h"
#import "ONHttpClient.h"

@implementation ONCommandAPI
/**
 *  发送命令
 *
 *  @param deviceId deviceId
 *  @param bodyparam    自定义请求参数
 *  @param callback  请求回调
 *
 */
+(void)sentCmdWithDeviceId:(NSString *)deviceId
              andBodyParam:(NSString *)bodyparam
                  callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"cmds?device_id=%@",deviceId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  发送命令
 *
 *  @param deviceId deviceId
 *  @param bodyparam    自定义请求参数
 *  @param callback  请求回调
 *
 */
+(void)sentCmdWithDeviceId:(NSString *)deviceId
              andBodyParam:(NSString *)bodyparam
              needResponse:(BOOL)needResponse
                   timeout:(NSInteger)timeout
               commandType:(CommandType)type
                  callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"cmds?device_id=%@&qos=%d&timeout=%d&type=%d",deviceId,(int)needResponse,(int)timeout,(int)type];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  用于查看命令发送状态。
 *
 *  @param cmdId 发送命令ID
 *  @param callback  请求回调
 *
 */
+(void)queryStatueWithCmdId:(NSString *)cmdId
                   callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"cmds/%@",cmdId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}

/**
 *  获取响应
 *
 *  @param cmdId 发送命令ID
 *  @param callback  请求回调
 */
+(void)queryCmdResponseWithCmdId:(NSString *)cmdId
                        callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"cmds/%@/resp",cmdId];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}
@end
