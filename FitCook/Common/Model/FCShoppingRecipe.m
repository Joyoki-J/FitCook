//
//  FCShoppingRecipe.m
//  FitCook
//
//  Created by shanshan on 2018/8/14.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCShoppingRecipe.h"
#import "FCRecipe.h"

@implementation FCShoppingDosage

- (instancetype)initWithRecipeDosage:(FCRecipeDosage *)dosage {
    self = [super init];
    if (self) {
        _integer = dosage.integer;
        _numerator = dosage.numerator;
        _denominator = dosage.denominator;
        _unit = dosage.unit;
    }
    return self;
}

- (FCRecipeDosage *)getDosage {
    FCRecipeDosage *d = [[FCRecipeDosage alloc] init];
    d.integer = self.integer;
    d.numerator = self.numerator;
    d.denominator = self.denominator;
    d.unit = self.unit;
    return d;
}

@end

@implementation FCShoppingIngredient

- (instancetype)initWithRecipeIngredient:(FCRecipeIngredient *)ingredient {
    self = [super init];
    if (self) {
        _isBuy = NO;
        _name = ingredient.name;
        _category = ingredient.category;
        _isNeedCalculate = ingredient.isNeedCalculate;
        _weight = ingredient.weight;
        _dosage = [[FCShoppingDosage alloc] initWithRecipeDosage:ingredient.dosage];
    }
    return self;
}

@end

@implementation FCShoppingRecipe

- (instancetype)initWithRecipe:(FCRecipe *)recipe count:(NSInteger)count {
    self = [super init];
    if (self) {
        _count = count;
        _index = recipe.index;
        _name = recipe.name;
        _weight = recipe.weight;
        _imageName_1 = recipe.imageName_1;
        _imageName_3 = recipe.imageName_3;
        _ingredients = [[RLMArray<FCShoppingIngredient> alloc] initWithObjectClassName:[FCShoppingIngredient className]];
        [_ingredients addObjects:[self getDefaultIngredients:recipe.ingredients]];
    }
    return self;
}

- (NSArray<FCShoppingIngredient *> *)getDefaultIngredients:(NSArray<FCRecipeIngredient *> *)ingredients {
    NSMutableArray *array = [NSMutableArray array];
    [ingredients enumerateObjectsUsingBlock:^(FCRecipeIngredient * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[[FCShoppingIngredient alloc] initWithRecipeIngredient:obj]];
    }];
    return array;
}

- (NSInteger)HowManyIngredentsMissing {
    __block NSInteger count = 0;
    
    for (NSInteger i = 0; i < self.ingredients.count; i++) {
        if (![self.ingredients objectAtIndex:i].isBuy) {
            count++;
        }
    }
    return count;
}

@end
