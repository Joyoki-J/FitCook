//
//  FCUser.m
//  FitCook
//
//  Created by Jay on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
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

@end
