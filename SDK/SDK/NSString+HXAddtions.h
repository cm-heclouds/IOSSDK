//
//  NSString+HXAddtions.h
//  SDK
//
//  Created by ZHJ on 15/8/4.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;

+(NSString *) jsonStringWithArray:(NSArray *)array;

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString *) jsonStringWithObject:(id) object;

+(void) jsonTest;
@end
