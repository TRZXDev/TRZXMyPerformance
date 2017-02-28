
//
//  TRMyWorkListCell.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRMyWorkListCell.h"

@implementation TRMyWorkListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setRadius:10 view:self.bgView];
}

-(void)setRadius:(CGFloat)cornerRadius view:(UIView *)view{
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
    
    // 栅格化 - 提高性能
    // 设置栅格化后，图层会被渲染成图片，并且缓存，再次使用时，不会重新渲染
    view.layer.rasterizationScale = [UIScreen mainScreen].scale;
    view.layer.shouldRasterize = YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
