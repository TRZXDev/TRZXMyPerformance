//
//  TRMyWorkUserHeadView.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRMyWorkUserHeadView.h"
#import "TRUserHeadCollectionViewCell.h"
#import "TRMyWorkModel.h"

#import "MyPerformanceHeader.h"

@implementation TRMyWorkUserHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)rawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TRUserHeadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TRUserHeadCollectionViewCell"];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    [self changeOffsetWithIndexPath:indexPath];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

#pragma mark collection data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRUserHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRUserHeadCollectionViewCell" forIndexPath:indexPath];
    TRMyWorkModel *model = self.dataSource[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"展位图"]];
    cell.nameLabel.text = model.userName;
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(61, 78);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.userHeadCallBack) {
        self.contentOffset = collectionView.contentOffset;
        self.userHeadCallBack(indexPath,self.contentOffset);
    }
}


- (void)changeOffsetWithOffset:(CGPoint)offset{
//    selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;
    [self.collectionView setContentOffset:offset animated:YES];
}

- (void)changeOffsetWithIndexPath:(NSIndexPath *)indexPath{
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
}

@end
