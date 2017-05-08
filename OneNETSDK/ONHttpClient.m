//
//  ONHttpClient.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/18.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONHttpClient.h"
#import "ONAFHTTPClient.h"
#import "ONAFJSONRequestOperation.h"

#define default_BaseURL @"http://api.heclouds.com"

typedef void(^SuccessBlock)(NSDictionary *responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface ONHttpClient()
@property(nonatomic,strong)ONAFHTTPClient *client;
@end

@implementation ONHttpClient
+(ONHttpClient *)sharedInstance
{
    static dispatch_once_t once;
    static ONHttpClient *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.baseURL = default_BaseURL;
    });
    return sharedInstance;
}

- (void)fetchWithURL:(NSString *)url
              params:(id)params
         requestType:(ONHttpType)methodType
            callback:(OneNETCallback)callback {
    
    SuccessBlock success = ^(id responseObject) {
        callback([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil],nil);
    };
    FailureBlock failure = ^(NSError *error) {
        callback(nil,error);
    };
    if ([params isKindOfClass:[NSData class]]) {
        [self fetchWithURL:url
                    method:methodType
                      data:params
                   success:success
                   failure:failure];
        return;
    }
    [self.client setDefaultHeader:@"api-key" value:self.apikey];
    switch (methodType) {
        case ONHttpGET:
            [self getWithURL:url
                      params:params
                     success:success
                     failure:failure];
            break;
        case ONHttpPOST:
            [self postWithURL:url
                       params:params
                      success:success
                      failure:failure];
            break;
        case ONHttpPUT:
            [self putWithURL:url
                      params:params
                     success:success
                     failure:failure];
            break;
        case ONHttpDELETE:
            [self deleteWithURL:url
                         params:params
                        success:success
                        failure:failure];
            break;
            
        default:
            break;
    }
}

- (void)getWithURL:(NSString *)url
            params:(id)params
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure {
    [self.client getPath:url
              parameters:params
                 success:^(ONAFHTTPRequestOperation *operation, id responseObject) {
                     success(responseObject);
                 }
                 failure:^(ONAFHTTPRequestOperation *operation, NSError *error) {
                     failure(error);
                 }];
}

- (void)postWithURL:(NSString *)url
             params:(id)params
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure {
    [self.client postPath:url
              parameters:params
                 success:^(ONAFHTTPRequestOperation *operation, id responseObject) {
                     success(responseObject);
                 }
                 failure:^(ONAFHTTPRequestOperation *operation, NSError *error) {
                     failure(error);
                 }];
}

- (void)fetchWithURL:(NSString *)url
              method:(ONHttpType)methodtype
               data:(NSData *)data
            success:(void (^)(id))success
            failure:(void (^)(NSError *))failure {
    NSString *method = @"POST";
    switch (methodtype) {
        case ONHttpGET:
            method = @"GET";
            break;
        case ONHttpPOST:
            method = @"POST";
            break;
        case ONHttpPUT:
            method = @"PUT";
            break;
        case ONHttpDELETE:
            method = @"DELETE";
            break;
            
        default:
            break;
    }
    NSURLRequest *request = [self.client requestWithMethod:method path:url data:data];
    ONAFHTTPRequestOperation *operation = [self.client HTTPRequestOperationWithRequest:request
                                         success:^(ONAFHTTPRequestOperation *operation, id responseObject) {
                                             success(responseObject);
                                         }
                                         failure:^(ONAFHTTPRequestOperation *operation, NSError *error) {
                                              failure(error);
                                         }];
    [self.client enqueueHTTPRequestOperation:operation];
}


- (void)putWithURL:(NSString *)url
            params:(id)params
           success:(void (^)(id))success
           failure:(void (^)(NSError *))failure {
    [self.client putPath:url
              parameters:params
                 success:^(ONAFHTTPRequestOperation *operation, id responseObject) {
                     success(responseObject);
                 }
                 failure:^(ONAFHTTPRequestOperation *operation, NSError *error) {
                     failure(error);
                 }];
}

- (void)deleteWithURL:(NSString *)url
               params:(id)params
              success:(void (^)(id))success
              failure:(void (^)(NSError *))failure {
    [self.client deletePath:url
               parameters:params
                  success:^(ONAFHTTPRequestOperation *operation, id responseObject) {
                      success(responseObject);
                  }
                  failure:^(ONAFHTTPRequestOperation *operation, NSError *error) {
                      failure(error);
                  }];
}

-(ONAFHTTPClient *)client {
    if (!_client) {
        NSURL *url = [NSURL URLWithString:self.baseURL];
        _client = [ONAFHTTPClient clientWithBaseURL:url];
        
        //最大并发请求数 10
        _client.operationQueue.maxConcurrentOperationCount = 10;
        
        [_client registerHTTPOperationClass:[ONAFJSONRequestOperation class]];
        [_client setParameterEncoding:ONAFFormURLParameterEncoding];
    }
    return _client;
}

- (void)setBaseURL:(NSString *)baseURL {
    if (baseURL != _baseURL) {
        _baseURL = [baseURL copy];
        _client = nil;
    }

}

@end
