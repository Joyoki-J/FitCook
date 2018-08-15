//
//  FCGuideViewController.h
//  FitCook
//
//  Created by shanshan on 2018/8/15.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseViewController.h"
#import "FCGuide.h"

@interface FCGuideViewController : FCBaseViewController

@property (nonatomic, strong) NSArray<FCGuide *> *guides;

- (void)showGuide:(void(^)(void))completion;

- (void)hideGuide:(void(^)(void))completion;

@end
