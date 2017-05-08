//
//  NSString+on_addition.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "NSDictionary+on_addition.h"

@implementation NSDictionary (on_addition)
- (NSString *)on_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:0
                                                             error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData
                                               encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}
@end
