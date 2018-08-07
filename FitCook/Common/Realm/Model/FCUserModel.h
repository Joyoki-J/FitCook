//
//  FCUserModel.h
//  FitCook
//
//  Created by Joyoki on 2018/8/7.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "RLMObject.h"

@interface FCUserModel : RLMObject

@property NSInteger userId;
@property NSString *email;
@property NSString *password;
@property NSData *data;

@end
