//
//  ONBinaryAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONBinaryAPI.h"
#import "ONHttpClient.h"

@implementation ONBinaryAPI
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
                       callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"bindata?device_id=%@&datastream_id=%@",device_id,datastream_id];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:data
                                    requestType:ONHttpPOST
                                       callback:callback];
}

/**
 *  读取二进制数据的内容。若查询没有该数据返回HTTP 404,并在返回内容中指定
 *
 *  @param index  该数据在设备云中的索引
 *  @param callback  请求回调
 */
+(void)queryBindataWithBindataIndex:(NSString *)index
                           callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"bindata/%@",index];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];

}
@end
