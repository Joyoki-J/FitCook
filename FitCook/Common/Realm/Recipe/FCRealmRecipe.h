//
//  FCRealmRecipe.h
//  FitCook
//
//  Created by Jay on 2018/8/8.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <Realm/Realm.h>
#import "RLMObject.h"
#import "FCRealmRecipeIngredient.h"
#import "FCRealmRecipeNutrition.h"

@interface FCRealmRecipe : RLMObject

@property NSInteger recipeId;
@property NSString *name;
@property NSString *time;
@property NSInteger weight;
@property NSString *classify; 
@property NSString *filters;
@property NSString *keywords;
@property RLMArray<FCRealmRecipeIngredient *><FCRealmRecipeIngredient> *ingredients;
@property RLMArray<RLMString> *steps;
@property FCRealmRecipeNutrition *nutrition;

@property NSData *image_1; //1154 x 443
@property NSData *image_2; //682 x 490
@property NSData *image_3; //339 x 339
@property NSData *image_4; //1125 x 675

@end
