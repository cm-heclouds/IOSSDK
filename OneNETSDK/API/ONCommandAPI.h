//
//  ONCommandAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

///命令类型
typedef NS_ENUM(NSUInteger, CommandType) {
    /** 请求数据命令 */
    TYPE_CMD_REQ = 0,
    /** 推送数据命令 */
    TYPE_PUSH_DATA
};

/**
 *  命令 API 详情链接http://open.iot.10086.cn/doc/art257.html#68
 */
@interface ONCommandAPI : NSObject
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
                  callBack:(OneNETCallback)callback;

/**
 *  发送命令
 *
 *  @param deviceId deviceId
 *  @param bodyparam    自定义请求参数
 *  @param needResponse  是否需要响应
 *  @param timeout  超时时间
 *  @param type  命令类型
 *  @param callback  请求回调
 *
 */
+(void)sentCmdWithDeviceId:(NSString *)deviceId
              andBodyParam:(NSString *)bodyparam
              needResponse:(BOOL)needResponse
                   timeout:(NSInteger)timeout
               commandType:(CommandType)type
                  callBack:(OneNETCallback)callback;

/**
 *  用于查看命令发送状态。
 *
 *  @param cmdId 发送命令ID
 *  @param callback  请求回调
 *
 */
+(void)queryStatueWithCmdId:(NSString *)cmdId
                   callBack:(OneNETCallback)callback;

/**
 *  获取响应
 *
 *  @param cmdId 发送命令ID
 *  @param callback  请求回调
 */
+(void)queryCmdResponseWithCmdId:(NSString *)cmdId
                        callBack:(OneNETCallback)callback;
@end
