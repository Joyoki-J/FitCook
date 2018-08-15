//
//  FCApp.h
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <Realm/Realm.h>
#import "FCUser.h"

@interface FCApp : RLMObject

@property NSInteger appId;
@property NSString *lastLauchedVersion;
@property NSString *lastUserName;
@property FCUser *currentUser;
@property RLMArray<FCUser *><FCUser> *users;

@property BOOL hasShowGuideRecipe;
@property BOOL hasShowGuideSearch;
@property BOOL hasShowGuideFavourites;

+ (void)initialized;

+ (BOOL)isFirstLaunch;

+ (BOOL)isInstalledByUpdate;

+ (FCApp *)app;

@end

RLM_ARRAY_TYPE(FCApp)
