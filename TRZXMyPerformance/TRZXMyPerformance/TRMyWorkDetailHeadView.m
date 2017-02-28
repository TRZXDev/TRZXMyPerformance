//
//  TRMyWorkDetailHeadView.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#define buttonTag 90909
#import "TRMyWorkDetailHeadView.h"

#import "MyPerformanceHeader.h"

@interface TRMyWorkDetailHeadView()

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation TRMyWorkDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];

    self.leftSliderView.hidden = NO;
    self.rightSliderView.hidden = YES;
    self.sellMoneyLabel.textColor = TRZXMainColor;
    self.sellMoneyTitle.textColor = TRZXMainColor;
    self.workMoney.textColor = heizideColor;
    self.workMoneyTitle.textColor = zideColor;
}


- (IBAction)buttonClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSInteger index = btn.tag - buttonTag;
    switch (index) {
        case 0:
            //销售佣金
//            self.rightButton.backgroundColor = backColor;
//            self.leftButton.backgroundColor = [UIColor whiteColor];
            self.leftSliderView.hidden = NO;
            self.rightSliderView.hidden = YES;
            self.sellMoneyLabel.textColor = TRZXMainColor;
            self.sellMoneyTitle.textColor = TRZXMainColor;
            self.workMoney.textColor = heizideColor;
            self.workMoneyTitle.textColor = zideColor;
            break;
            
        default:
            //管理奖金
//            self.rightButton.backgroundColor = [UIColor whiteColor];
//            self.leftButton.backgroundColor = backColor;
            self.leftSliderView.hidden = YES;
            self.rightSliderView.hidden = NO;
            self.sellMoneyLabel.textColor = heizideColor;
            self.sellMoneyTitle.textColor = zideColor;
            self.workMoney.textColor = TRZXMainColor;
            self.workMoneyTitle.textColor = TRZXMainColor;
            
            break;
    }
    if (self.buttonClick) {
        self.buttonClick(index);
    }
    
}
@end
