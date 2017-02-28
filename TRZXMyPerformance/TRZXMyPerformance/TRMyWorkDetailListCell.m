//
//  TRMyWorkDetailListCell.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRMyWorkDetailListCell.h"

@implementation TRMyWorkDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImage.layer.cornerRadius = 4;
    self.headImage.layer.masksToBounds = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
