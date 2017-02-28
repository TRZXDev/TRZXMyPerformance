//
//  TRMyWorkUserHeadView.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMyWorkUserHeadView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (copy, nonatomic) void (^userHeadCallBack)(NSIndexPath *indexPath,CGPoint offset);
@property (strong,nonatomic) NSArray *dataSource;

@property (nonatomic,assign)CGPoint contentOffset;//记录偏移量
@property (nonatomic,assign)NSInteger userHeaderSelected;//记录点击下标


- (void)changeOffsetWithOffset:(CGPoint)offset;
- (void)changeOffsetWithIndexPath:(NSIndexPath *)indexPath;


@end
