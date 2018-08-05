//
//  FCSearchFilterViewController.m
//  FitCook
//
//  Created by Joyoki on 2018/8/2.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import "FCSearchFilterViewController.h"
#import "FCModalTransition.h"

@interface FCSearchFilterViewController ()

@property (nonatomic, strong) FCModalTransition *transition;

@end

@implementation FCSearchFilterViewController

+ (NSString *)storyboardName {
    return @"Search";
}

+ (instancetype)viewControllerWithCustomTransition {
    FCModalTransition *transition = [[FCModalTransition alloc] init];
    FCSearchFilterViewController *vc = [[self class] viewControllerFromStoryboard];
    vc.transition = transition;
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = transition;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
