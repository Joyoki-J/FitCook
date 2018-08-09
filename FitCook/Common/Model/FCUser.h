//
//  FCUser.h
//  FitCook
//
//  Created by Jay on 2018/8/9.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <Realm/Realm.h>

@interface FCUser : RLMObject

@property NSString *email;
@property NSString *password;
@property NSString *name;
@property NSData *image;

@property (readonly) RLMLinkingObjects *owners;

+ (NSString *)addUserWithEmail:(NSString *)email
                      password:(NSString *)password
                          name:(NSString *)name;

+ (NSString *)loginUserWithEmail:(NSString *)email
                        password:(NSString *)password;

+ (FCUser *)currentUser;

+ (void)logoutCurrentUser;

- (void)updateUserImage:(NSData *)image;

@end

RLM_ARRAY_TYPE(FCUser)
