//
//  FCRealmRecipe.m
//  FitCook
//
//  Created by Jay on 2018/8/8.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRealmRecipe.h"

@implementation FCRealmRecipe

+ (NSString *)primaryKey {
    return @"recipeId";
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"ingredients":@"FCRealmRecipeIngredient"};
}

@end
