//
//  TRMyWorkDetailHeadView.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMyWorkDetailHeadView : UIView
@property (weak, nonatomic) IBOutlet UILabel *sellMoneyTitle;

@property (weak, nonatomic) IBOutlet UILabel *sellMoneyLabel;//销售佣金
@property (weak, nonatomic) IBOutlet UILabel *workMoney;//管理奖金
@property (weak, nonatomic) IBOutlet UILabel *workMoneyTitle;
@property (copy, nonatomic) void (^buttonClick)(NSInteger index);
@property (weak, nonatomic) IBOutlet UIView *leftSliderView;
@property (weak, nonatomic) IBOutlet UIView *rightSliderView;

@end
