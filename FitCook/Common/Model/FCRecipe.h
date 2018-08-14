//
//  FCRecipe.h
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FCRecipe;
@class FCRecipeIngredient;
@class FCRecipeDosage;
@class FCRecipeNutrition;

@protocol FCRecipeProtocol <NSObject>

+ (NSArray<FCRecipe *> *)allRecipes;

+ (NSArray<FCRecipe *> *)recipesWithKeywords:(NSArray<NSString *> *)keywords;

+ (NSArray<FCRecipe *> *)predicateWithFilters:(NSArray<NSString *> *)filters;

+ (FCRecipe *)recipeWithIndex:(NSInteger)index;

+ (NSArray<FCRecipe *> *)recipesWithIndexs:(NSIndexSet *)indexs;

@end

@interface FCRecipe : NSObject<FCRecipeProtocol>

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, copy) NSString *classify;
@property (nonatomic, copy) NSString *filters;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, strong) NSArray<FCRecipeIngredient *> *ingredients;
@property (nonatomic, strong) NSArray<NSString *> *steps;
@property (nonatomic, strong) FCRecipeNutrition *nutrition;

@property (nonatomic, copy) NSString *imageName_1; //1154 x 443
@property (nonatomic, copy) NSString *imageName_2; //682 x 490
@property (nonatomic, copy) NSString *imageName_3; //339 x 339
@property (nonatomic, copy) NSString *imageName_4; //1125 x 675

@end

@interface FCRecipeIngredient : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, assign) BOOL isNeedCalculate;
@property (nonatomic, assign) BOOL isBuy;
@property (nonatomic, strong) FCRecipeDosage *dosage;

@end

@interface FCRecipeDosage : NSObject

@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, assign) NSInteger numerator;
@property (nonatomic, assign) NSInteger denominator;
@property (nonatomic, copy) NSString *unit;

// +
- (FCRecipeDosage *)addDosage:(FCRecipeDosage *)aDosage;
- (FCRecipeDosage *)addNumber:(NSInteger)aNumber;
// *
- (FCRecipeDosage *)mulDosage:(FCRecipeDosage *)aDosage;
- (FCRecipeDosage *)mulNumber:(NSInteger)aNumber;

@end

@interface FCRecipeNutrition : NSObject

@property (nonatomic, copy) NSString *calories;
@property (nonatomic, copy) NSString *protein;
@property (nonatomic, copy) NSString *fat;
@property (nonatomic, copy) NSString *carbohydrates;

@end
