//
//  FCShoppingRecipe.h
//  FitCook
//
//  Created by shanshan on 2018/8/14.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "RLMObject.h"

@class FCRecipe;
@class FCRecipeDosage;

@interface FCShoppingDosage: RLMObject

@property NSInteger integer;
@property NSInteger numerator;
@property NSInteger denominator;
@property NSString *unit;

- (FCRecipeDosage *)getDosage;

@end

@interface FCShoppingIngredient: RLMObject

@property BOOL isBuy;
@property NSString *name;
@property NSString *category;
@property NSInteger weight;
@property BOOL isNeedCalculate;
@property FCShoppingDosage *dosage;

@end

RLM_ARRAY_TYPE(FCShoppingIngredient)

@interface FCShoppingRecipe: RLMObject

- (instancetype)initWithRecipe:(FCRecipe *)recipe count:(NSInteger)count;

@property NSInteger count;
@property NSInteger index;
@property NSString *name;
@property NSInteger weight;
@property RLMArray<FCShoppingIngredient *><FCShoppingIngredient> *ingredients;

@property NSString *imageName_1; //1154 x 443
@property NSString *imageName_3; //339 x 339

- (NSInteger)HowManyIngredentsMissing;

@end

RLM_ARRAY_TYPE(FCShoppingRecipe)
