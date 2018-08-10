//
//  FCRecipesDetailViewController.h
//  FitCook
//
//  Created by Joyoki on 2018/7/31.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseViewController.h"

@interface FCRecipesDetailViewController : FCBaseViewController

+ (instancetype)viewControllerFromStoryboardWithRecipe:(FCRecipe *)recipe;

@end
