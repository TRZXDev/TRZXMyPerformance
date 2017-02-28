//
//  TRMyWorkListCell.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  我的业绩
 */
@interface TRMyWorkListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *lookDetailButton;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
