//
//  FCSearchScanViewController.h
//  FitCook
//
//  Created by shanshan on 2018/8/3.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseViewController.h"

@protocol FCSearchScanViewControllerDelegate;

@interface FCSearchScanViewController : FCBaseViewController

@property (nonatomic, weak) id <FCSearchScanViewControllerDelegate> deleagte;

@end

@protocol FCSearchScanViewControllerDelegate <NSObject>

- (void)searchScanViewController:(FCSearchScanViewController *)vc didSearchFoodWithName:(NSString *)foodName;

@end
