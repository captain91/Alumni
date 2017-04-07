//
//  FunctionFast.m
//  Alumni
//
//  Created by Sun on 2017/2/11.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "FunctionFast.h"

@implementation FunctionFast
+ (id)objectIsNull:(id)obj {
    if (obj == [NSNull null] || obj == nil) {
        return @"0";
    }else{
        if ([obj isKindOfClass:[NSNumber class]]) {
            obj = [NSString stringWithFormat:@"%@",obj];
        }
        return obj;
    }
}
@end
