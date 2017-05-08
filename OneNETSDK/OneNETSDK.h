//
//  OneNETSDK.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/18.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  请求回调
 *
 *  @param response 服务器返回数据
 *  @param error 错误信息
 */
typedef void(^OneNETCallback)(NSDictionary *response,NSError *error);

/**
 *  ONENETAPI配置 相关术语链接http://open.iot.10086.cn/doc/art246.html#68
 */
@interface OneNETSDK : NSObject
/**
 * 设置apiKey
 *
 * @param apiKey masterkey 或者 设备apikey
 */
+ (void)setAPIKey:(NSString *)apiKey;
/**
 * 设置SDK访问的服务器地址
 *
 * @param baseURL SDK访问的服务器地址
 */
+ (void)setBaseURL:(NSString *)baseURL;
@end
