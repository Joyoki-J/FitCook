//
//  FCImageManager.h
//  FitCook
//
//  Created by shanshan on 2018/8/11.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCImageManager : NSObject

+ (instancetype)shareManager;

- (void)getImageWithKey:(NSString *)key completion:(void (^)(NSString *key, UIImage *img))completion;

@end
