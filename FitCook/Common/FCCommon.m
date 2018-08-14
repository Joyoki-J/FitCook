//
//  FCCommon.m
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCCommon.h"

@implementation FCCommon

+ (NSString *)getCurrentVer
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString * version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    NSString * ret = [[NSString alloc]initWithFormat:@"%@", version];
    return ret;
}

@end
