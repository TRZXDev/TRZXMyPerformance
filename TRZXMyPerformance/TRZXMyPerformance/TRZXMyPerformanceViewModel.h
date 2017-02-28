//
//  TRMyWorkViewModel.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZXMyPerformanceViewModel : NSObject


/**
 *  我的业绩
 *
 *  @param success ..
 *  @param failure ..
 */

+ (void)myWorkListSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;



/**
 我的业绩详情

 @param type       year , month ,week , day
 @param rewardType sale 销售   manage 管理, 不传默认销售
 @param page       页码
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)myWorkType:(NSString *)type rewardType:(NSString *)rewardType page:(NSString *)page DetailSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 用户获取详情

 @param mid        mid
 @param type       year , month ,week , day
 @param rewardType sale 销售   manage 管理, 不传默认销售
 @param page       页码
 @param success    成功回调
 @param failure    失败回调
 */
+ (void)myWorkUserDetailMid:(NSString *)mid Type:(NSString *)type rewardType:(NSString *)rewardType page:(NSString *)page success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@end
