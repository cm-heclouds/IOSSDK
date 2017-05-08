//
//  ONAPIKeyAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  API key相关API 详情链接http://open.iot.10086.cn/doc/art296.html#68
 */
@interface ONAPIKeyAPI : NSObject
/**
 *  创建拥有一定权限的ApiKey
 *
 *  @param bodyparam HTTP内容 详见<a href="http://www.heclouds.com/doc/art296.html#68"></a>
 *  @param callback  请求回调
 *
 */
+(void)addAPIKeyWithBodyParam:(NSString *)bodyparam
                     callBack:(OneNETCallback)callback;

/**
 *  编辑APIKey
 *
 *  @param apikey 注：只能是用户master-key
 *  @param bodyparam  参数是为支持更多协议而设置，如不太清楚可不填写。
 *  @param callback  请求回调
 *
 */
+(void)editAPIKey:(NSString *)apikey
     andBodyParam:(NSString *)bodyparam
         callBack:(OneNETCallback)callback;


/**
 *  读取APIKey
 *
 *  @param param  请求参数 dev_id  key 都可选
 *  @param callback  请求回调
 *
 */
+(void)queryAPIKeyWithParam:(NSDictionary *)param
                   callBack:(OneNETCallback)callback;
/**
 *  精确查询APIKey
 *
 *  @param apikey  需要删除的key
 *  @param callback  请求回调
 *
 */

+(void)queryAPIKey:(NSString *)apikey
          callBack:(OneNETCallback)callback;
/**
 *  删除指定APIKey
 *
 *  @param apikey  需要删除的key
 *  @param callback  请求回调
 *
 */

+(void)deleteAPIKey:(NSString *)apikey
           callBack:(OneNETCallback)callback;

@end
