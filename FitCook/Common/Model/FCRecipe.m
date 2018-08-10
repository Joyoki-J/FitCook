//
//  FCRecipe.m
//  FitCook
//
//  Created by Jay on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRecipe.h"

@implementation FCRecipe

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"ingredients":@"FCRecipeIngredient"};
}

#pragma mark - FCRecipeProtocol
+ (NSArray<FCRecipe *> *)allRecipes {
    static NSArray *recipes = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"json"]];
        NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        recipes = [FCRecipe mj_objectArrayWithKeyValuesArray:dataArray];
    });
    return recipes;
}

+ (NSArray<FCRecipe *> *)recipesWithKeywords:(NSArray<NSString *> *)keywords {
    NSPredicate *predicate = [self predicateWithKeys:keywords format:@"keywords LIKE '*%@*'" isAnd:NO];
    if (predicate) {
        return [[self allRecipes] filteredArrayUsingPredicate:predicate];
    } else {
        return nil;
    }
}

+ (NSArray<FCRecipe *> *)predicateWithFilters:(NSArray<NSString *> *)filters {
    NSPredicate *predicate = [self predicateWithKeys:filters format:@"filters LIKE '*%@,*'" isAnd:YES];
    if (predicate) {
        return [[self allRecipes] filteredArrayUsingPredicate:predicate];
    } else {
        return nil;
    }
}

+ (NSPredicate *)predicateWithKeys:(NSArray<NSString *> *)keys format:(NSString *)format isAnd:(BOOL)isAnd {
    if (keys.count > 0) {
        NSMutableArray *predicates = [NSMutableArray array];
        for (NSString *key in keys) {
            NSPredicate *p = [NSPredicate predicateWithFormat:[NSString stringWithFormat:format,key]];
            [predicates addObject:p];
        }
        if (isAnd) {
            return [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
        } else {
            return [NSCompoundPredicate orPredicateWithSubpredicates:predicates];
        }
    } else {
        return nil;
    }
}

+ (FCRecipe *)recipeWithIndex:(NSInteger)index {
    return [[self allRecipes] objectAtIndex:index];
}

+ (NSArray<FCRecipe *> *)recipesWithIndexs:(NSIndexSet *)indexs {
    return [[self allRecipes] objectsAtIndexes:indexs];
}

@end

@implementation FCRecipeIngredient

@end

@implementation FCRecipeDosage

@end

@implementation FCRecipeNutrition

@end
