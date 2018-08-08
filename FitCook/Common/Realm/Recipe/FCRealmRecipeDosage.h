//
//  FCRealmRecipeDosage.h
//  FitCook
//
//  Created by Jay on 2018/8/8.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "RLMObject.h"

@interface FCRealmRecipeDosage : RLMObject

@property NSInteger integer;
@property NSInteger numerator;
@property NSInteger denominator;
@property NSString *unit;


@end
