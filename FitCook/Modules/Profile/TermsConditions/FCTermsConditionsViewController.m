//
//  FCTermsConditionsViewController.m
//  FitCook
//
//  Created by shanshan on 2018/8/1.
//  Copyright © 2018年 shanshan. All rights reserved.
//

#import "FCTermsConditionsViewController.h"

@interface FCTermsConditionsViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *vContent;

@end

@implementation FCTermsConditionsViewController

+ (NSString *)storyboardName {
    return @"Profile";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Terms & Conditions";
    
    [self createTermsConditions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTermsConditions {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"termsConditions" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
    if (jsonObject && [jsonObject isKindOfClass:[NSArray class]]) {
        NSArray<NSString *> *arrData = (NSArray<NSString *> *)jsonObject;
        NSInteger count = arrData.count;
        __block UILabel *labLast;
        [arrData enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *lab = [[UILabel alloc] init];
            lab.textColor = [UIColor blackColor];
            lab.font = kFont_16;
            lab.textAlignment = idx == 0 ? NSTextAlignmentCenter : NSTextAlignmentLeft;
            lab.numberOfLines = 0;
            lab.text = obj;
            [self.vContent addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(14);
                make.right.mas_equalTo(-14);
                make.width.mas_equalTo(kSCREEN_WIDTH - 28);
                if (idx == 0) {
                    make.top.mas_equalTo(8);
                } else {
                    make.top.equalTo(labLast.mas_bottom).offset(8);
                }
                if (idx == count - 1) {
                    make.bottom.mas_equalTo(0);
                }
            }];
            
            labLast = lab;
        }];
    }
}

@end
