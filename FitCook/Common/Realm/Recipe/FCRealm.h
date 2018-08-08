//
//  FCRealm.h
//  FitCook
//
//  Created by Joyoki on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "FCRealmRecipe.h"

@interface FCRealm : NSObject

+ (RLMRealm *)defaultRealm;

@end
