//
//  FCRecipesDetailViewController.h
//  FitCook
//
//  Created by shanshan on 2018/7/31.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCBaseViewController.h"

@interface FCRecipesDetailViewController : FCBaseViewController

+ (instancetype)viewControllerFromStoryboardWithRecipe:(FCRecipe *)recipe;

@end
