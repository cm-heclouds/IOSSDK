//
//  ONBinaryAPI.h
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OneNETSDK.h"

/**
 *  二进制数据 API 详情链接http://open.iot.10086.cn/doc/art258.html#68
 */
@interface ONBinaryAPI : NSObject
/**
 *  上传二进制
 *
 *  @param data   二进制
 *  @param device_id  必填
 *  @param datastream_id  必填
 *  @param callback  请求回调
 *
 */
+(void)uploadBindataWithBindata:(NSData *)data
                       deviceId:(NSString *)device_id
                   datastreamId:(NSString *)datastream_id
                       callBack:(OneNETCallback)callback;

/**
 *  读取二进制数据的内容。若查询没有该数据返回HTTP 404,并在返回内容中指定
 *
 *  @param index  该数据在设备云中的索引
 *  @param callback  请求回调
 */
+(void)queryBindataWithBindataIndex:(NSString *)index
                           callBack:(OneNETCallback)callback;
@end
