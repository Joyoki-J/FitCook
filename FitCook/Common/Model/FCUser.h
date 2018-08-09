//
//  FCUser.h
//  FitCook
//
//  Created by Jay on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <Realm/Realm.h>

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

@end

RLM_ARRAY_TYPE(FCUser)
