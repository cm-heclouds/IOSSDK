//
//  ONHttpClient.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/18.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 * 请求方式
 */
typedef NS_ENUM(NSUInteger, ONHttpType) {
    /** GET */
    ONHttpGET = 0,
    /** POST */
    ONHttpPOST,
    /** PUT */
    ONHttpPUT,
    /** DELETE */
    ONHttpDELETE
};

/**
 *  ONENET请求Client
 */
@interface ONHttpClient : NSObject
/**
 * 获取的apikey
 */
@property(nonatomic,copy) NSString *apikey;
/**
 * SDK访问的服务器地址,默认为http://api.heclouds.com
 */
@property(nonatomic,copy) NSString *baseURL;

/**
 * Client的请求单例
 *
 * @return 单例对象
 */
+(ONHttpClient *)sharedInstance;
/**
 * http请求
 *
 * @param url     请求路径
 * @param type    请求方式
 * @param params  请求参数
 * @param callback 请求后的回调
 */
- (void)fetchWithURL:(NSString *)url
              params:(id)params
         requestType:(ONHttpType)type
            callback:(OneNETCallback)callback;
@end
