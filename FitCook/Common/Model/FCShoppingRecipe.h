//
//  FCShoppingRecipe.h
//  FitCook
//
//  Created by Jay on 2018/8/14.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "RLMObject.h"

@class FCRecipe;

@interface FCShoppingDosage: RLMObject

@property NSInteger integer;
@property NSInteger numerator;
@property NSInteger denominator;
@property NSString *unit;

@end

@interface FCShoppingIngredient: RLMObject

@property BOOL isBuy;
@property NSString *name;
@property NSString *category;
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

@end

RLM_ARRAY_TYPE(FCShoppingRecipe)
