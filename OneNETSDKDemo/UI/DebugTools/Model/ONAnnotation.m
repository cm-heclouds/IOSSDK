//
//  ONAnnotation.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "ONAnnotation.h"

@implementation ONAnnotation
-(id)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                   title:(NSString *)paramTitle
                subTitle:(NSString *)paramSubitle
{
    self = [super init];
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubitle;
    }
    return self;
}
@end
