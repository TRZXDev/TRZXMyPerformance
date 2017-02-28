//
//  CTMediator+MyPerformance.m
//  TRZXMyPerformance
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CTMediator+MyPerformance.h"

@implementation CTMediator (MyPerformance)


NSString * const kMyPerformanceA = @"MyPerformance";

NSString * const kMyPerformanceViewController          = @"MyPerformance_TRZXMyPerformanceViewController";
NSString * const kMyPerformanceUserHomerController     = @"MyPerformance_TRZXUserHomeViewController";


- (UIViewController *)MyPerformance_TRZXMyPerformanceViewController:(NSDictionary *)parms{
    UIViewController *viewController = [self performTarget:kMyPerformanceA
                                                    action:kMyPerformanceViewController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (UIViewController *)MyPerformance_TRZXUserHomeViewController:(NSDictionary *)parms{
    
    UIViewController *viewController = [self performTarget:kMyPerformanceA
                                                    action:kMyPerformanceUserHomerController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}


@end
