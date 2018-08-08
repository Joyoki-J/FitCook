//
//  FCRealm.m
//  FitCook
//
//  Created by Joyoki on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRealm.h"

@implementation FCRealm

+ (RLMRealm *)defaultRealm {
    static RLMRealmConfiguration *confi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        confi = [RLMRealmConfiguration defaultConfiguration];
        confi.fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"realm"]];
    });
    return [RLMRealm realmWithConfiguration:confi error:nil];
}

@end
