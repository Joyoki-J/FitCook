//
//  FCCreateRecipeRealm.m
//  FitCook
//
//  Created by Jay on 2018/8/8.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCCreateRecipeRealm.h"
#import "FCRealmRecipe.h"

@implementation FCCreateRecipeRealm

+ (void)createRecipeRealm {
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
    
//    [self createRecipe];
    
    // 复制压缩realm
        [self copyRealm];
}

+ (void)createRecipe {
    NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"recipe" ofType:@"json"]];
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"=======================\n");
    RLMArray<FCRealmRecipe *> *recipes = [[RLMArray alloc] initWithObjectClassName:FCRealmRecipe.className];
    for (NSInteger i = 0; i < dataArray.count; i++) {
        FCRealmRecipe *recipe = [FCRealmRecipe mj_objectWithKeyValues:dataArray[i]];
        recipe.recipeId = 100 + i;
        recipe.image_1 = UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld_1",recipe.weight]]);
        recipe.image_2 = UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld_2",recipe.weight]]);
        recipe.image_3 = UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld_3",recipe.weight]]);
        recipe.image_4 = UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"%ld_4",recipe.weight]]);
        [recipes addObject:recipe];
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjects:recipes];
    }];
}

+ (void)copyRealm {
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *url = [NSURL URLWithString:[path stringByAppendingString:@"/recipe.realm"]];
    [realm writeCopyToURL:url encryptionKey:nil error:nil];
}

@end
