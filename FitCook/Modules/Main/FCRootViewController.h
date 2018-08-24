//
//  FCRootViewController.h
//  FitCook
//
//  Created by shanshan on 2018/7/17.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseViewController.h"

@interface FCRootViewController : FCBaseViewController

+ (instancetype)shareViewController;

- (void)showLoginViewController;
- (void)hideLoginViewController;

@property (nonatomic, readonly) BOOL isShowSign;

@end
