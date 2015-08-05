//
//  SDK.h
//  SDK
//
//  Created by ZHJ on 15/8/3.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDK : NSObject
+(id)share;
//用户登录
-(NSDictionary *)userLogin:(NSString *)userName andPWD:(NSString *)pwd;

#pragma mark 设备 -----------start
/**
 *  在OneNET中新增加一个设备
 *
 *  @param apikey 登录成功时,获取的api_key
 *  @param param  请求参数以JSON字符串形式。形如：@"{\"title\":\"%@\"}"
 *
 *  @return 请求结果
 */
-(NSDictionary *)addDeviceRequestKey:(NSString *)apikey andRequestParam:(NSString *)param;

/**
 *  对设备信息进行编辑修改。
 *
 *  @param apikey 登录成功时,获取的api_key
 *  @param deviceId 当前设备的ID
 *  @param param  请求参数以JSON字符串形式。形如：@"{\"title\":\"%@\"}"
 *
 *  @return 请求结果
 */
-(NSDictionary *)editDeviceRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andRequestParam:(NSString *)param;

/**
 *  读取单个设备详细数据
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备的ID
 *
 *  @return 请求结果
 */
-(NSDictionary *)getSingleDeviceRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId;

/**
 *  读取多个设备详细数据
 *
 *  @param apikey  登录成功时,获取的api_key
 *  @param page    当前的页数
 *  @param perpage 每页显示多少条数据
 *  @param param   请求参数 提供多种筛选方式（key_words-关键字;tag-搜索标签;online-特殊协议使用 true 或者 false）
 *                 private-暂不使用 true 或者 false 全部为可选参数
 *  @return 请求结果
 */
-(NSDictionary *)getMoreDeviceRequestKey:(NSString *)apikey andPage:(int)page andPerPage:(int)perpage andRequestParam:(NSString *)param;

/**
 *  删除设备（删除设备后将删除 所有 数据信息，谨慎处理）
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *
 *  @return 请求结果
 */
-(NSDictionary *)deleteDeviceRequsetKey:(NSString *)apikey andDeviceId:(NSString *)deviceId;
#pragma mark  设备 -----------end

#pragma mark 数据流 -------------start

/**
 *  为设备增加一条数据流，用于存储和展现数据。(数据上报需要上报到具体的一条数据流）
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param param    请求参数 形如：@"{\"title\":\"%@\"}"
 *
 *  @return 请求结果
 */

-(NSDictionary *)addDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;

/**
 *  编辑数据流信息（数据流ID不能修改）
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *  @param param    请求参数
 *
 *  @return 请求结果
 */
-(NSDictionary *)editDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId andParam:(NSString *)param;

/**
 *  读取单个数据流
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *
 *  @return 请求结果
 */
-(NSDictionary *)readSingleDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId;

/**
 *  读取多个设备数据流
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param param   请求参数 为datastream_ids=dataStringID1,dataStringId2   @"{\"datastream_ids\":\"id1,id2\"}"
 *
 *  @return 请求结果
 */
-(NSDictionary *)readMoreDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;

/**
 *  删除数据流（删除数据流将删除所有数据）
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param streamId 数据流ID
 *
 *  @return 请求结果
 */
-(NSDictionary *)deleteDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId;

#pragma mark  数据流 ------------end


#pragma mark 数据点   -------------start
/**
 *  向指定设备下一条或多条数据流上报数据。
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId 当前设备ID
 *  @param param    请求参数 特定数据格式 {"lon":33.2,"lat":23,"ele":222}
 *
 *  @return 请求结果
 */
-(NSDictionary *)reportDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;

/**
 *  从数据流中读取指定搜索条件的数据，支持分页。
 *
 *  @param apikey
 *  @param deviceId 登录成功时,获取的api_key
 *  @param param    请求参数
 *
 *  @return 请求结果
 */
-(NSDictionary *)readDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;


-(NSDictionary *)deleteDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;

#pragma mark  数据点 -----------------end

#pragma mark 二进制数据 -------start
/**
 *  上传二进制
 *
 *  @param apiKey 登录成功时,获取的api_key
 *  @param data   二进制
 *  @param param  请求参数 可选
 *
 *  @return 请求结果
 */
-(NSDictionary *)uploadBindataRequestKey:(NSString *)apiKey andBindata:(NSData *)data andPrama:(NSString *)param;

/**
 *  读取二进制数据的内容。若查询没有该数据返回HTTP 404,并在返回内容中指定
 *
 *  @param apiKey 登录成功时,获取的api_key
 *  @param index  该数据在设备云中的索引
 *
 *  @return 请求结果
 */
-(NSDictionary *)readBindataRequestKey:(NSString *)apiKey andBindataIndex:(NSString *)index;
-(NSDictionary *)deleteBindataRequestKey:(NSString *)apiKey andBindataIndex:(NSString *)index;

#pragma mark 二进制数据 ------end



#pragma mark  触发器   -----------start
/**
 *  添加触发器
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param deviceId  设备ID
 *  @param streamId  数据流ID
 *  @param param    请求参数
 *
 *  @return 请求结果
 */
-(NSDictionary *)addTriggerRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId andParam:(NSString *)param;

/**
 *  编辑触发器
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param triggerId  触发器ID
 *  @param param    请求参数
 *
 *  @return 请求结果
 */
-(NSDictionary *)editTriggerRequestKey:(NSString *)apikey andTriggerId:(NSString *)triggerId andParam:(NSString *)param;

/**
 *  删除触发器
 *
 *  @param apikey   登录成功时,获取的api_key
 *  @param triggerId  触发器ID
 *  @return 请求结果
 */
-(NSDictionary *)deleteTriggerRequestKey:(NSString *)apikey andTriggerId:(NSString *)triggerId;

#pragma mark 触发器 ----------end


#pragma mark APIKey  ------------start

/**
 *  创建拥有一定权限的ApiKey
 *
 *  @param apikey 必须masterkey
 *  @param param  参数是为支持更多协议而设置，如不太清楚可不填写。
 *
 *  @return 请求结果
 */
-(NSDictionary *)addAPIKeyRequestKey:(NSString *)apikey andParam:(NSString *)param;

/**
 *  编辑APIKey
 *
 *  @param apikey 注：只能是用户master-key
 *  @param param  参数是为支持更多协议而设置，如不太清楚可不填写。
 *
 *  @return 请求结果
 */
-(NSDictionary *)editAPIKeyRequestkey:(NSString *)apikey andAPIKeyId:(NSString *)apikeyId andParam:(NSString *)param;


/**
 *  读取APIKey
 *
 *  @param apikey 注：必须是用户master-key
 *  @param param  请求参数 dev_id  key 都可选
 *
 *  @return 请求结果
 */
-(NSDictionary *)readAPIKeyRequestKey:(NSString *)apikey andParam:(NSString *)param;
/**
 *  删除指定APIkEY
 *
 *  @param apikey  需要删除的key
 *
 *  @return 请求结果
 */

-(NSDictionary *)deleteAPIKeyRequestKey:(NSString *)apikey;

#pragma mark  APIKey -----------end


#pragma mark 其他
/**
 *  <#Description#>
 *
 *  @param apikey   通过RestFul协议接口，将数据发送到使用EDP协议的设备
 *  @param deviceId
 *  @param param    自定义请求参数
 *
 *  @return 请求结果
 */
-(NSDictionary *)sentDataReqestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param;

-(NSDictionary *)queryDataRequestKey:(NSString *)apikey andParam:(NSString *)param;


//保存信息到沙箱目录
+(NSString *)saveSandbox:(NSString *)sandPath;

@end
