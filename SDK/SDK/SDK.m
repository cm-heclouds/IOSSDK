//
//  SmartDataSDK.m
//  SmartDataSDK
//
//  Created by ZHJ on 15/7/28.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import "SDK.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"
#import "SBJson.h"

#define baseURL @"http://appapi.heclouds.com"


@implementation SDK
static SDK * static_self=nil;
+(id)share{
    if (static_self==nil) {
        static_self=[[SDK alloc]init];
    }
    return static_self;
}

#pragma mark 用户登录
-(NSDictionary *)userLogin:(NSString *)userName andPWD:(NSString *)pwd{
    
    NSMutableString *param=[[NSMutableString alloc]init];
    [param appendString:[NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}",userName,pwd]];
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/login",baseURL]]];
    [request setRequestMethod:@"POST"];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request setStringEncoding:NSUTF8StringEncoding];
    [request buildPostBody];
    [request setDownloadCache:[ASIDownloadCache sharedCache]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}


#pragma mark  添加设备
-(NSDictionary *)addDeviceRequestKey:(NSString *)apikey andRequestParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices",baseURL]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 编辑设备
-(NSDictionary *)editDeviceRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andRequestParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@",baseURL,deviceId]]];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 读取单个设备详细数据
-(NSDictionary *)getSingleDeviceRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@",baseURL,deviceId]]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 读取多个设备
-(NSDictionary *)getMoreDeviceRequestKey:(NSString *)apikey andPage:(int)page andPerPage:(int)perpage andRequestParam:(NSString *)param{
    //@"{\"title\":\"%@\"}"
    NSString *str=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    NSString *requestStr;
    if (str4.length>0) {
        requestStr=[NSString stringWithFormat:@"%@/devices?page=%i&per_page=%i&%@",baseURL,page,perpage,str4];
    }else{
        requestStr=[NSString stringWithFormat:@"%@/devices?page=%i&per_page=%i",baseURL,page,perpage];
    }
    
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestStr]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 删除设备
-(NSDictionary *)deleteDeviceRequsetKey:(NSString *)apikey andDeviceId:(NSString *)deviceId{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@",baseURL,deviceId]]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 添加数据流
-(NSDictionary *)addDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datastreams",baseURL,deviceId]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 编辑数据流
-(NSDictionary *)editDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datastreams/%@",baseURL,deviceId,streamId]]];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 读取单个设备数据流
-(NSDictionary *)readSingleDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datastreams/%@",baseURL,deviceId,streamId]]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
    
}

#pragma mark  读取多个设备数据流
-(NSDictionary *)readMoreDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    NSString *str1=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *requeststr;
    if (str4.length>0) {
        requeststr=[NSString stringWithFormat:@"%@/devices/%@/datastreams?%@",baseURL,deviceId,requeststr];
    }else{
        requeststr=[NSString stringWithFormat:@"%@/devices/%@/datastreams",baseURL,deviceId];
    }
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requeststr]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}


#pragma mark  删除数据流
-(NSDictionary *)deleteDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datastreams/%@",baseURL,deviceId,streamId]]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 上报数据
-(NSDictionary *)reportDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datapoints",baseURL,deviceId]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 读取数据
-(NSDictionary *)readDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    NSString *str=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    NSString *requestStr;
    if (str4.length>0) {
        requestStr=[NSString stringWithFormat:@"%@/devices/%@/datapoints?%@",baseURL,deviceId,str4];
    }else{
        requestStr=[NSString stringWithFormat:@"%@/devices/%@/datapoints",baseURL,deviceId];
    }
    
    
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestStr]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark  删除数据
-(NSDictionary *)deleteDataPointRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    
    NSString *str=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    NSString *requestStr;
    if (str4.length>0) {
        requestStr=[NSString stringWithFormat:@"%@/devices/%@/datapoints?%@",baseURL,deviceId,str4];
    }else{
        requestStr=[NSString stringWithFormat:@"%@/devices/%@/datapoints",baseURL,deviceId];
    }
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestStr]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark  上传二进制
-(NSDictionary *)uploadBindataRequestKey:(NSString *)apiKey andBindata:(NSData *)data andPrama:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/bindata",baseURL]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apiKey];
    [request setPostBody:[[NSMutableData alloc]initWithData:data]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark  读取二进制
-(NSDictionary *)readBindataRequestKey:(NSString *)apiKey andBindataIndex:(NSString *)index{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/bindata/%@",baseURL,index]]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apiKey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 删除二进制
-(NSDictionary *)deleteBindataRequestKey:(NSString *)apiKey andBindataIndex:(NSString *)index{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/bindata/%@",baseURL,index]]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apiKey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 新增触发器
-(NSDictionary *)addTriggerRequestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andDataStreamId:(NSString *)streamId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/devices/%@/datastreams/%@/triggers",baseURL,deviceId,streamId]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 编辑触发器
-(NSDictionary *)editTriggerRequestKey:(NSString *)apikey andTriggerId:(NSString *)triggerId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/triggers/%@",baseURL,triggerId]]];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark  删除触发器
-(NSDictionary *)deleteTriggerRequestKey:(NSString *)apikey andTriggerId:(NSString *)triggerId{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/triggers/%@",baseURL,triggerId]]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 新增APIKEY
-(NSDictionary *)addAPIKeyRequestKey:(NSString *)apikey andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/keys",baseURL]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 编辑APIKey
-(NSDictionary *)editAPIKeyRequestkey:(NSString *)apikey andAPIKeyId:(NSString *)apikeyId andParam:(NSString *)param{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/keys/%@",baseURL,apikeyId]]];
    [request setRequestMethod:@"PUT"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark  读取APIKey
-(NSDictionary *)readAPIKeyRequestKey:(NSString *)apikey andParam:(NSString *)param{
    NSString *str=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    NSString *requestStr;
    if (str4.length>0) {
        requestStr=[NSString stringWithFormat:@"%@/keys?%@",baseURL,str4];
    }else{
        requestStr=[NSString stringWithFormat:@"%@/keys",baseURL];
    }
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestStr]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

-(NSDictionary *)deleteAPIKeyRequestKey:(NSString *)apikey{
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/keys/%@",baseURL,apikey]]];
    [request setRequestMethod:@"DELETE"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}

#pragma mark 发送数据到EDP设备
-(NSDictionary *)sentDataReqestKey:(NSString *)apikey andDeviceId:(NSString *)deviceId andParam:(NSString *)param{
    if ([deviceId stringByReplacingOccurrencesOfString:@" " withString:@""].length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"设备号不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return nil;
    }
    if ([[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]].length/1024>64) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"数据文件不能超过64K" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return nil;
    }
    
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/cmds/?device_id=%@",baseURL,deviceId]]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request setPostBody:[[NSMutableData alloc]initWithData:[param dataUsingEncoding:NSUTF8StringEncoding]]];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}


#pragma mark 历史数据查询
-(NSDictionary *)queryDataRequestKey:(NSString *)apikey andParam:(NSString *)param{
    NSString *str=[param stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *str3=[str2 stringByReplacingOccurrencesOfString:@":" withString:@"="];
    NSString *str4=[str3 stringByReplacingOccurrencesOfString:@"," withString:@"&"];
    NSString *requestStr;
    if (str4.length>0) {
        requestStr=[NSString stringWithFormat:@"%@/datapoints?%@",baseURL,str4];
    }else{
        requestStr=[NSString stringWithFormat:@"%@/datapoints",baseURL];
    }
    
    
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:requestStr]];
    [request setRequestMethod:@"GET"];
    [request addRequestHeader:@"api-key" value:apikey];
    [request startSynchronous];
    if (request.responseStatusCode!=200) {
        return nil;
    }
    return [self parserRequestData:request.responseString];
}












#pragma mark 解析数据
-(NSDictionary *)parserRequestData:(NSString *)requestStr{
    SBJsonParser *parser=[[SBJsonParser alloc]init];
    NSDictionary *JSON=[parser objectWithString:requestStr];
    return JSON;
}

#pragma mark 保存信息到沙箱目录
+(NSString *)saveSandbox:(NSString *)sandPath{
    NSArray  *paths= NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.txt",sandPath]];
    return filePath;
}



@end
