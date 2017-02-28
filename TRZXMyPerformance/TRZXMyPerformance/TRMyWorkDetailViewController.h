//
//  TRMyWorkDetailViewController.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  我的业绩详情页面
 */

typedef NS_ENUM(NSInteger, MyWorkDetailType) {
    MyWorkDetailTypeDay,
    MyWorkDetailTypeWeek,
    MyWorkDetailTypeMonth,
    MyWorkDetailTypeYear
};

@interface TRMyWorkDetailViewController : UIViewController

@property (nonatomic,assign)MyWorkDetailType type;

@end
