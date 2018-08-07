//
//  FCRealmManager.m
//  FitCook
//
//  Created by Jay on 2018/8/7.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCRealmManager.h"
#import <Realm/Realm.h>
#import "FCUserModel.h"
@implementation FCRealmManager

+ (void)test {
    
//    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
//
//    NSData *data = UIImagePNGRepresentation([UIImage imageNamed:@"foot_photo3"]);
//
//
//
//    FCUserModel *user = [[FCUserModel alloc] init];
//    user.email = @"jiangshiqi";
//    user.userId = 11101;
//    user.password = @"1111112222";
//    user.data = data;
//
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm transactionWithBlock:^{
//        [realm addObject:user];
//    }];
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *url = [NSURL URLWithString:[path stringByAppendingString:@"/recipe.realm"]];
    [realm writeCopyToURL:url encryptionKey:nil error:nil];
    
}

+ (UIImage *)image {
    FCUserModel *user = [FCUserModel allObjects].firstObject;
    return [UIImage imageWithData:user.data];
}

@end
