//
//  FCSearchFilterViewController.h
//  FitCook
//
//  Created by Joyoki on 2018/8/2.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseViewController.h"

@protocol FCSearchFilterViewControllerDelegate;

@interface FCSearchFilterViewController : FCBaseViewController

@property (nonatomic, weak) id <FCSearchFilterViewControllerDelegate> delegate;

+ (instancetype)viewControllerWithCustomTransition;
- (void)close;

@end


@protocol FCSearchFilterViewControllerDelegate <NSObject>

- (void)searchFilterViewControllerWillClose:(FCSearchFilterViewController *)vc;

@end
