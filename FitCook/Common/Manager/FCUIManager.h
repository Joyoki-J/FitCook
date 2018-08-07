//
//  FCUIManager.h
//  FitCook
//
//  Created by Jay on 2018/7/16.
//  Copyright © 2018年 Joyoki. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define kSCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define kNAVBAR_HEIGHT   (IS_SS_IPHONE_X ? 88.0f : 64.0f)
#define kTABBAR_HEIGHT   (IS_SS_IPHONE_X ? 83.0f : 49.0f)
#define kSTATBAR_HEIGHT  (IS_SS_IPHONE_X ? 44.0f : 20.0f)
#define kONEPIXEL_WIDTH  (1.0 / [UIScreen mainScreen].scale)

#define RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a/100.f]
#define RGB(r,g,b)        RGBA(r,g,b,100.f)

#define kCOLOR_RANDOM                       RGB(random() % 256,random() % 256,random() % 256)
#define kCOLOR_TAB_BAR_ITEM_TITLE           RGB(116.0f,116.0f,129.0f)
#define kCOLOR_TAB_BAR_ITEM_TITLE_SELECTED  RGB(80.0f,99.0f,216.0f)

#define kCOLOR_GRAY_BARITEM                 RGB(245.0f,165.0f,162.0f)
#define kCOLOR_GRAY_TITLE                   RGB(74.0f,74.0f,74.0f)
#define kCOLOR_GRAY_BORDER                  RGB(238.0f,238.0f,238.0f)
#define kCOLOR_GRAY_142_142_142             RGB(142.0f,142.0f,142.0f)


#define kCOLOR_BLUE_BORDER                  RGB(61.0f,124.0f,252.0f)

#define kFont(size)       [FCUIManager fontOfSize:(size) bold:NO]
#define kBoldFont(size)   [FCUIManager fontOfSize:(size) bold:YES]

#define kFont_21 kFont(21)
#define kFont_20 kFont(20)
#define kFont_19 kFont(19)
#define kFont_18 kFont(18)
#define kFont_17 kFont(17)
#define kFont_16 kFont(16)
#define kFont_15 kFont(15)
#define kFont_14 kFont(14)
#define kFont_13 kFont(13)
#define kFont_12 kFont(12)
#define kFont_11 kFont(11)
#define kFont_10 kFont(10)

typedef NS_ENUM(NSInteger, FCScreenSize) {
    FCS_None,
    //2x
    FCS_ScreenSize_3_5, //3.5, 4,4s
    FCS_ScreenSize_4_0, //4.0, 5,5s,5e
    FCS_ScreenSize_4_7, //4.7, 6,6s,7
    //3x
    FCS_ScreenSize_5_5, //5.5, 6p,6sp,7p
    FCS_ScreenSize_5_8, //5.8, x
};

#define kCurrent_SS [FCUIManager currentScreenSize]

#define IS_SS_IPHONE_4   kCurrent_SS == FCS_ScreenSize_3_5  //iphone 4,4s
#define IS_SS_IPHONE_5   kCurrent_SS == FCS_ScreenSize_4_0  //iphone 5,5s,5e
#define IS_SS_IPHONE_6   kCurrent_SS == FCS_ScreenSize_4_7  //iphone 6,6s,7,8
#define IS_SS_IPHONE_P   kCurrent_SS == FCS_ScreenSize_5_5  //iphone 6p,6sp,7p,8p
#define IS_SS_IPHONE_X   kCurrent_SS == FCS_ScreenSize_5_8  //iphone x

@interface FCUIManager : NSObject

+ (FCScreenSize)currentScreenSize;

+ (UIFont *)fontOfSize:(CGFloat)size bold:(BOOL)bold;

@end
