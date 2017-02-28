//
//  MyPerformanceHeader.h
//  TRZXMyPerformance
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#ifndef MyPerformanceHeader_h
#define MyPerformanceHeader_h

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 取色值相关的方法
#define RGB(r,g,b)          [UIColor colorWithRed:(r)/255.f \
green:(g)/255.f \
blue:(b)/255.f \
alpha:1.f]

/** 主题颜色 */
#define TRZXMainColor [UIColor colorWithRed:215.0/255.0 green:0/255.0 blue:15.0/255.0 alpha:1]
#define backColor [UIColor colorWithRed:240.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1]
#define zideColor [UIColor colorWithRed:179.0/255.0 green:179.0/255.0 blue:179.0/255.0 alpha:1]
#define heizideColor [UIColor colorWithRed:90.0/255.0 green:90.0/255.0 blue:90.0/255.0 alpha:1]



#import "MJExtension.h"
#import "TRZXKit.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

#endif /* MyPerformanceHeader_h */
