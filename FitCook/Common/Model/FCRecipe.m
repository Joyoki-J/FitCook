//
//  FCRecipe.m
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
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

@interface FCRecipeDosage()<NSCopying>

@end

@implementation FCRecipeDosage

- (instancetype)initWithInteger:(NSInteger)integer numerator:(NSInteger)numerator denominator:(NSInteger)denominator unit:(NSString *)unit {
    self = [super init];
    if (self) {
        _integer = integer;
        _numerator = numerator;
        _denominator = denominator;
        _unit = [unit copy];
    }
    return self;
}

- (BOOL)check:(FCRecipeDosage *)aDosage {
    if (!(self && aDosage && [aDosage isKindOfClass:[self class]])) {
        return NO;
    }
    
    if (!((!self.unit && !aDosage.unit) || (self.unit && aDosage.unit && [self.unit isEqualToString:aDosage.unit]))) {
        return NO;
    }
    
    if (self.integer == 0 && self.numerator == 0 && self.denominator == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)isZero {
    if (self.integer == 0 && self.numerator == 0 && self.denominator == 0) {
        return YES;
    } else {
        return NO;
    }
}

- (instancetype)copyWithZone:(NSZone *)zone {
    FCRecipeDosage *aDosage = [[FCRecipeDosage alloc] initWithInteger:self.integer
                                                            numerator:self.numerator
                                                          denominator:self.denominator
                                                                 unit:self.unit];
    return aDosage;
}

// +
- (FCRecipeDosage *)addDosage:(FCRecipeDosage *)aDosage {
    
    if (![self check:aDosage]) {
        return nil;
    }
    
    if ([self isZero]) {
        return [aDosage copy];
    }
    
    if ([aDosage isZero]) {
        return [self copy];
    }
    
    NSInteger sInteger = self.integer > 0 ? self.integer : 1;
    NSInteger aInteger = aDosage.integer > 0 ? aDosage.integer : 1;
    
    NSInteger sNumerator = 1, sDenominator = 1;
    NSInteger aNumerator = 1, aDenominator = 1;
    
    if (self.numerator > 0 && self.denominator > 0) {
        sNumerator = self.numerator;
        sDenominator = self.denominator;
    }
    
    if (aDosage.numerator > 0 && aDosage.denominator > 0) {
        aNumerator = aDosage.numerator;
        aDenominator = aDosage.denominator;
    }
    
    FCRecipeDosage *dosage = [[FCRecipeDosage alloc] init];
    dosage.numerator = sInteger * sNumerator * aDenominator + aInteger * aNumerator * sDenominator;
    dosage.denominator = sDenominator * aDenominator;
    dosage.unit = self.unit;
    [dosage reduce];
    NSInteger remainder = dosage.numerator % dosage.denominator;
    dosage.integer = dosage.numerator / dosage.denominator;
    if (remainder == 0) {
        dosage.numerator = 0;
        dosage.denominator = 0;
    } else {
        dosage.numerator = remainder;
    }
    return dosage;
}

- (FCRecipeDosage *)addNumber:(NSInteger)aNumber {
    FCRecipeDosage *aDosage = [[FCRecipeDosage alloc] initWithInteger:aNumber
                                                            numerator:1
                                                          denominator:1
                                                                 unit:self.unit];
    return [self addDosage:aDosage];
}

// *
- (FCRecipeDosage *)mulDosage:(FCRecipeDosage *)aDosage {
    if (![self check:aDosage] || [self isZero] || [aDosage isZero]) {
        return nil;
    }
    
    NSInteger sInteger = self.integer > 0 ? self.integer : 1;
    NSInteger aInteger = aDosage.integer > 0 ? aDosage.integer : 1;
    
    NSInteger sNumerator = 1, sDenominator = 1;
    NSInteger aNumerator = 1, aDenominator = 1;
    
    if (self.numerator > 0 && self.denominator > 0) {
        sNumerator = self.numerator;
        sDenominator = self.denominator;
    }
    
    if (aDosage.numerator > 0 && aDosage.denominator > 0) {
        aNumerator = aDosage.numerator;
        aDenominator = aDosage.denominator;
    }
    
    FCRecipeDosage *dosage = [[FCRecipeDosage alloc] init];
    dosage.numerator = sInteger * sNumerator * aInteger * aNumerator;
    dosage.denominator = sDenominator * aDenominator;
    dosage.unit = self.unit;
    [dosage reduce];
    NSInteger remainder = dosage.numerator % dosage.denominator;
    dosage.integer = dosage.numerator / dosage.denominator;
    if (remainder == 0) {
        dosage.numerator = 0;
        dosage.denominator = 0;
    } else {
        dosage.numerator = remainder;
    }
    return dosage;
}

- (FCRecipeDosage *)mulNumber:(NSInteger)aNumber {
    if (aNumber == 0) {
        return nil;
    }
    FCRecipeDosage *aDosage = [[FCRecipeDosage alloc] initWithInteger:aNumber
                                                            numerator:1
                                                          denominator:1
                                                                 unit:self.unit];
    return [self mulDosage:aDosage];
}

- (void)reduce {
    NSInteger n = _numerator;
    
    NSInteger d = _denominator;
    
    while (d) {
        
        NSInteger temp = n%d;
        
        n = d;
        
        d = temp;
        
    }
    
    _numerator /= n;
    
    _denominator /= n;
}

@end

@implementation FCRecipeNutrition

@end
