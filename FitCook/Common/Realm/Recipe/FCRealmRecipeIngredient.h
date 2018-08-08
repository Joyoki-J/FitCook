//
//  FCRealmRecipeIngredient.h
//  FitCook
//
//  Created by Jay on 2018/8/8.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "RLMObject.h"
#import "FCRealmRecipeDosage.h"

@interface FCRealmRecipeIngredient : RLMObject

@property NSString *name;
@property NSString *category;
@property BOOL isNeedCalculate;
@property FCRealmRecipeDosage *dosage;

@end

RLM_ARRAY_TYPE(FCRealmRecipeIngredient);
