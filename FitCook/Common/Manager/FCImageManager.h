//
//  FCImageManager.h
//  FitCook
//
//  Created by Joyoki on 2018/8/11.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCImageManager : NSObject

+ (instancetype)shareManager;

- (void)getImageWithKey:(NSString *)key completion:(void (^)(NSString *key, UIImage *img))completion;

@end
