//
//  ONAPIKeyAPI.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/21.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONAPIKeyAPI.h"
#import "ONHttpClient.h"

@implementation ONAPIKeyAPI
+(void)addAPIKeyWithBodyParam:(NSString *)bodyparam
                     callBack:(OneNETCallback)callback {
    [[ONHttpClient sharedInstance] fetchWithURL:@"keys"
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPOST
                                       callback:callback];
}

+(void)editAPIKey:(NSString *)apikey
     andBodyParam:(NSString *)bodyparam
         callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"keys/%@",apikey];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:[bodyparam dataUsingEncoding:NSUTF8StringEncoding]
                                    requestType:ONHttpPUT
                                       callback:callback];
}

+(void)queryAPIKeyWithParam:(NSDictionary *)param
                   callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"keys"];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:param
                                    requestType:ONHttpGET
                                       callback:callback];
}

+(void)deleteAPIKey:(NSString *)apikey
           callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"keys/%@",apikey];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpDELETE
                                       callback:callback];
}
+(void)queryAPIKey:(NSString *)apikey
          callBack:(OneNETCallback)callback {
    NSString *path = [NSString stringWithFormat:@"keys/%@",apikey];
    [[ONHttpClient sharedInstance] fetchWithURL:path
                                         params:nil
                                    requestType:ONHttpGET
                                       callback:callback];
}
@end
