//
//  FCUser.m
//  FitCook
//
//  Created by shanshan on 2018/8/9.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCUser.h"
#import "FCApp.h"

@implementation FCFavourite

+ (NSDictionary *)defaultPropertyValues {
    return @{@"isFavourite":@NO};
}

@end

@implementation FCUser

- (instancetype)init
{
    self = [super init];
    if (self) {
        _favourites = [[RLMArray<FCFavourite> alloc] initWithObjectClassName:[FCFavourite className]];
        [_favourites addObjects:[self getDefaultFavourites]];
        _shoppingList = [[RLMArray<FCShoppingRecipe> alloc] initWithObjectClassName:[FCShoppingRecipe className]];
    }
    return self;
}

- (NSArray<FCFavourite *> *)getDefaultFavourites {
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++) {
        [array addObject:[[FCFavourite alloc] init]];
    }
    return array;
}

+ (NSString *)primaryKey {
    return @"email";
}

+ (NSArray *)requiredProperties {
    return @[@"email"];
}

+ (NSArray *)indexedProperties {
    return @[@"email"];
}

// Define "owners" as the inverse relationship
+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"owners": [RLMPropertyDescriptor descriptorWithClass:FCApp.class propertyName:@"users"]
             };
}

+ (NSString *)addUserWithEmail:(NSString *)email
                      password:(NSString *)password
                          name:(NSString *)name {
    
    if (!(email && email.length > 0)) {
        return @"The email is invalid.";
    }
    
    if (![self isValidateEmail:email]) {
        return @"The email is invalid.";
    }
    
    if (!(name && name.length > 0)) {
        return @"Knock,Knock!Who is there?";
    }
    
    if (!(password && password.length >= 8)) {
        return @"Make sure it contains at least 8 characters.";
    }
    
    FCApp *app = [FCApp app];
    
    RLMResults<FCUser *> *users = [app.users objectsWhere:@"email = %@", email];
    if (users.count > 0) {
        return @"The email is invalid.";
    }
    
    FCUser *user = [[FCUser alloc] init];
    user.email = email;
    user.password = password;
    user.name = name;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [app.users addObject:user];
    }];
    
    return nil;
}

+ (NSString *)loginUserWithEmail:(NSString *)email password:(NSString *)password {
    FCApp *app = [FCApp app];
    RLMResults<FCUser *> *users = [app.users objectsWhere:@"email = %@", email];
    if (!(users.count > 0)) {
        return @"The email is invalid.";
    }
    
    FCUser *user = [users firstObject];
    if (![user.password isEqualToString:password]) {
        return @"Username and password combination doesn't match.";
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        app.currentUser = user;
        app.lastUserName = user.name;
    }];
    
    return nil;
}

+ (FCUser *)currentUser {
    return [FCApp app].currentUser;
}

+ (void)logoutCurrentUser {
    RLMRealm *realm = [RLMRealm defaultRealm];
    FCApp *app = [FCApp app];
    [realm transactionWithBlock:^{
        app.currentUser = nil;
        app.lastUserName = nil;
    }];
}

- (void)updateUserImage:(NSData *)image {
    if (!image) {
        return;
    }
    FCUser *user = [[self class] currentUser];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        user.image = image;
    }];
}

- (BOOL)isFavouriteRecipe:(FCRecipe *)recipe {
    return [[[[[self class] currentUser].favourites objectAtIndex:recipe.index] isFavourite] boolValue];
}

- (void)updateRecipe:(FCRecipe *)recipe isFavourite:(BOOL)isFavourite {
    RLMRealm *realm = [RLMRealm defaultRealm];
    FCUser *user = [[self class] currentUser];
    [realm transactionWithBlock:^{
        user.favourites[recipe.index].isFavourite = @(isFavourite);
    }];
}

+ (BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)isAddedShoppingRecipe:(FCRecipe *)recipe {
    FCUser *user = [[self class] currentUser];
    RLMResults *result = [user.shoppingList objectsWhere:@"index = %ld", recipe.index];
    return result.count > 0;
}

- (void)addRecipeToShoppingList:(FCRecipe *)recipe withCount:(NSInteger)count {
    FCShoppingRecipe *shoppingRecipe = [[FCShoppingRecipe alloc] initWithRecipe:recipe count:count];
    RLMArray<FCShoppingRecipe *> *shoppingList = [[self class] currentUser].shoppingList;
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [shoppingList addObject:shoppingRecipe];
    }];
}

- (void)deleteRecipeFromShoppingList:(FCShoppingRecipe *)recipe {
    RLMArray<FCShoppingRecipe *> *shoppingList = [[self class] currentUser].shoppingList;
    FCShoppingRecipe *shoppingRecipe = [shoppingList objectsWhere:@"index = %ld", recipe.index][0];
    NSUInteger index = [shoppingList indexOfObject:shoppingRecipe];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [shoppingList removeObjectAtIndex:index];
        [realm deleteObject:shoppingRecipe];
    }];
}

- (NSArray<FCShoppingRecipe *> *)getShoppingList {
    NSMutableArray<FCShoppingRecipe *> *arr = [NSMutableArray array];
    RLMArray<FCShoppingRecipe *> *shoppingList = [[self class] currentUser].shoppingList;
    for (NSInteger i = 0; i < shoppingList.count; i++) {
        [arr addObject:shoppingList[i]];
    }
    
    [arr sortUsingComparator:^NSComparisonResult(FCShoppingRecipe * _Nonnull obj1, FCShoppingRecipe *  _Nonnull obj2) {
        return obj1.weight > obj2.weight;
    }];
    
    return arr;
}

@end
