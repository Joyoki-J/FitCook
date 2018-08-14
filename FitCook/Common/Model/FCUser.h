//
//  FCUser.h
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <Realm/Realm.h>
#import "FCShoppingRecipe.h"

#define kUserUpdateFavouriteNotificationKey @"kUserUpdateFavouriteNotificationKey"
#define kUserUpdateShoppingNotificationKey @"kUserUpdateShoppingNotificationKey"

@class FCRecipe;

@interface FCFavourite: RLMObject

@property NSNumber<RLMBool> *isFavourite;

@end

RLM_ARRAY_TYPE(FCFavourite)

@interface FCUser : RLMObject

@property NSString *email;
@property NSString *password;
@property NSString *name;
@property NSData *image;
@property RLMArray<FCFavourite *><FCFavourite> *favourites;
@property RLMArray<FCShoppingRecipe *><FCShoppingRecipe> *shoppingList;

@property (readonly) RLMLinkingObjects *owners;

+ (NSString *)addUserWithEmail:(NSString *)email
                      password:(NSString *)password
                          name:(NSString *)name;

+ (NSString *)loginUserWithEmail:(NSString *)email
                        password:(NSString *)password;

+ (FCUser *)currentUser;

+ (void)logoutCurrentUser;

- (void)updateUserImage:(NSData *)image;

- (BOOL)isFavouriteRecipe:(FCRecipe *)recipe;

- (void)updateRecipe:(FCRecipe *)recipe isFavourite:(BOOL)isFavourite;

- (BOOL)isAddedShoppingRecipe:(FCRecipe *)recipe;

- (void)addRecipeToShoppingList:(FCRecipe *)recipe withCount:(NSInteger)count;

- (void)deleteRecipeFromShoppingList:(FCShoppingRecipe *)recipe;

- (NSArray<FCShoppingRecipe *> *)getShoppingList;

@end

RLM_ARRAY_TYPE(FCUser)
