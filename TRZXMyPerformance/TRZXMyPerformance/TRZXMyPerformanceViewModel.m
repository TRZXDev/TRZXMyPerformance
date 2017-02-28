//
//  TRMyWorkViewModel.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRZXMyPerformanceViewModel.h"
#import <TRZXNetwork/TRZXNetwork.h>

@implementation TRZXMyPerformanceViewModel

/**
*  我的业绩
*
*  @param success ..
*  @param failure ..
*/
+ (void)myWorkListSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"gains",
                            @"requestType":@"MyAchievement_Api",
                            
                            };
    
    [TRZXNetwork configHttpHeaders:@{@"equipment":@"ios",
                                     @"token":@"9bfc515a2fc0ea364a4340f38f7f47ff",
                                     @"userId":@"60a121b25cb34088987041b3b7632098"}];
    
    [TRZXNetwork requestWithUrl:nil params:param method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {
        if (response) {
            success(response);
        }else{
            failure(error);
        }
    }];
}


/**
 我的业绩详情
 
 @param type       year , month ,week , day
 @param rewardType sale 销售   manage 管理, 不传默认销售
 @param page       页码
 @param success    成功回调
 @param failure    失败回调
 */

+ (void)myWorkType:(NSString *)type rewardType:(NSString *)rewardType page:(NSString *)page DetailSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *param = @{
                            @"apiType":@"gainsInfo",
                            @"requestType":@"MyAchievement_Api",
                            @"type":type?type:@"day",
                            @"rewardType":rewardType?rewardType:@"",
                            @"pageNo":page?page:@"1"
                            };
    [TRZXNetwork configHttpHeaders:@{@"equipment":@"ios",
                                     @"token":@"9bfc515a2fc0ea364a4340f38f7f47ff",
                                     @"userId":@"60a121b25cb34088987041b3b7632098"}];
    
    [TRZXNetwork requestWithUrl:nil params:param method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {
        if (response) {
            success(response);
        }else{
            failure(error);
        }
    }];
    
}

/**
 用户获取详情
 
 @param mid        mid
 @param type       year , month ,week , day
 @param rewardType sale 销售   manage 管理, 不传默认销售
 @param page       页码
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)myWorkUserDetailMid:(NSString *)mid Type:(NSString *)type rewardType:(NSString *)rewardType page:(NSString *)page success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    NSDictionary *param = @{
                            @"apiType":@"manageList",
                            @"requestType":@"MyAchievement_Api",
                            @"type":type?type:@"day",
                            @"rewardType":rewardType?rewardType:@"",
                            @"pageNo":page?page:@"1",
                            @"proId":mid?mid:@""
                            };
    [TRZXNetwork configHttpHeaders:@{@"equipment":@"ios",
                                     @"token":@"9bfc515a2fc0ea364a4340f38f7f47ff",
                                     @"userId":@"60a121b25cb34088987041b3b7632098"}];
    
    [TRZXNetwork requestWithUrl:nil params:param method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {
        if (response) {
            success(response);
        }else{
            failure(error);
        }
    }];
}

@end
