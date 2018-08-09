//
//  FCApp.m
//  FitCook
//
//  Created by Jay on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCApp.h"
#import <Realm/Realm.h>
#import "FCCommon.h"

static BOOL IsAppFirstLaunch = NO;
static BOOL IsAppInstalledByUpdate = NO;

@implementation FCApp

+ (NSString *)primaryKey {
    return @"appId";
}

+ (NSArray *)indexedProperties {
    return @[@"appId"];
}

+ (void)initialized {
    RLMResults<FCApp *> *apps = [FCApp allObjects];
    if (apps.count < 1) {
        IsAppFirstLaunch = YES;
        FCApp *app = [[FCApp alloc] init];
        app.lastLauchedVersion = [FCCommon getCurrentVer];
        app.appId = apps.count;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:app];
        }];
    } else {
        FCApp *app = [apps firstObject];
        if (![app.lastLauchedVersion isEqualToString:[FCCommon getCurrentVer]]) {
            IsAppFirstLaunch = YES;
            if (app.lastLauchedVersion) {
                IsAppInstalledByUpdate = YES;
            }
        }
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            app.lastLauchedVersion = [FCCommon getCurrentVer];
        }];
    }
}

+ (BOOL)isFirstLaunch {
    return IsAppFirstLaunch;
}

+ (BOOL)isInstalledByUpdate {
    return IsAppInstalledByUpdate;
}

+ (FCApp *)app {
    return [[FCApp allObjects] firstObject];
}

@end
