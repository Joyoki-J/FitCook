//
//  FCSignUpViewController.h
//  FitCook
//
//  Created by Joyoki on 2018/8/6.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCBaseViewController.h"

@protocol FCSignUpViewControllerDelegate;

@interface FCSignUpViewController : FCBaseViewController

@property (nonatomic, weak) id <FCSignUpViewControllerDelegate> delegate;

@end


@protocol FCSignUpViewControllerDelegate <NSObject>

- (void)signUpViewController:(FCSignUpViewController *)vc
             signUpWithEmail:(NSString *)email
                    password:(NSString *)password;

@end
