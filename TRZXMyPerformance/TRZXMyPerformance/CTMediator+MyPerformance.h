//
//  CTMediator+MyPerformance.h
//  TRZXMyPerformance
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

@interface CTMediator (MyPerformance)



- (UIViewController *)MyPerformance_TRZXMyPerformanceViewController:(NSDictionary *)parms;


/**
 个人主页
 
 @param parms @{@"title":@"",@"mid":@""}
 @return ..
 */
- (UIViewController *)MyPerformance_TRZXUserHomeViewController:(NSDictionary *)parms;


@end
