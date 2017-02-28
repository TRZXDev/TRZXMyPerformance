//
//  Target_MyPerformance.m
//  TRZXMyPerformance
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "Target_MyPerformance.h"
#import "TRZXMyPerformanceViewController.h"

@implementation Target_MyPerformance


/**
 我的业绩
 
 @param params ..
 @return ..
 */
- (UIViewController *)Action_MyPerformance_TRZXMyPerformanceViewController:(NSDictionary *)params{
    TRZXMyPerformanceViewController *myVc = [[TRZXMyPerformanceViewController alloc]init];
    myVc.titleString = params[@"title"];
    return myVc;
}


/**
 个人详情
 
 @param params ..
 @return ..
 */
- (UIViewController *)Action_MyPerformance_TRZXUserHomeViewController:(NSDictionary *)params{
    TRZXMyPerformanceViewController *myVc = [[TRZXMyPerformanceViewController alloc]init];
    myVc.titleString = params[@"title"];
    return myVc;
}



@end
