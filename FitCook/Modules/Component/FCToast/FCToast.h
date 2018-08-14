//
//  FCToast.h
//  FitCook
//
//  Created by shanshan on 2018/8/7.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCToast : UIView

+ (void)showText:(NSString *)text;

+ (void)showErrorText:(NSString *)text;

@end
