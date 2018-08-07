//
//  FCToast.h
//  FitCook
//
//  Created by Jay on 2018/8/7.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCToast : UIView

+ (void)showText:(NSString *)text;

+ (void)showErrorText:(NSString *)text;

@end
