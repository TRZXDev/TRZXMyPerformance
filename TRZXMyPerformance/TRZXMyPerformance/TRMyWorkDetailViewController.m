//
//  TRMyWorkDetailViewController.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRMyWorkDetailViewController.h"
#import "TRMyWorkDetailHeadView.h"
#import "TRMyWorkUserHeadView.h"
#import "TRMyWorkDetailListCell.h"
#import "TRZXMyPerformanceViewModel.h"
#import "TRMyWorkModel.h"
//#import "PersonalInformationVC.h"

#import "MyPerformanceHeader.h"

@interface TRMyWorkDetailNoListCell : UITableViewCell

@end

@implementation TRMyWorkDetailNoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    imageView.image = [UIImage imageNamed:@"列表无内容"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:imageView];
}


@end

@interface TRMyWorkDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong)NSMutableArray *userDataSource;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)NSInteger selectedIndex;

@property (nonatomic,copy)NSString *requestType;
@property (nonatomic,copy)NSString *rewardType;
@property (nonatomic,copy)NSString *totalPage;
@property (nonatomic,copy)NSString *pageNO;
@property (nonatomic,copy)NSString *one;
@property (nonatomic,copy)NSString *two;

@property (nonatomic,copy)NSString *mid;
@property (nonatomic,assign)BOOL first;
@property (nonatomic,assign)BOOL isloadUser;

@property (nonatomic,assign)CGPoint offset;//记录偏移量
@property (nonatomic,assign)NSInteger userHeaderSelected;//记录点击下标
@property (nonatomic,strong)NSIndexPath *userHeaderIndexPath;

@property (nonatomic,strong)TRMyWorkUserHeadView *headerView;
@property (nonatomic,strong)UIImageView *noneImageView;

@end

@implementation TRMyWorkDetailViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addUI];
    [self loadData];
}

- (void)addUI
{

    if (self.type == MyWorkDetailTypeDay) {
        self.title = @"本日收益详情";
        self.requestType = @"day";
    }else if (self.type == MyWorkDetailTypeWeek){
        self.title = @"本周收益详情";
        self.requestType = @"week";
    }else if (self.type == MyWorkDetailTypeMonth){
        self.title = @"本月收益详情";
        self.requestType = @"month";
    }else if (self.type == MyWorkDetailTypeYear){
        self.title = @"本年收益详情";
        self.requestType = @"year";
    }
    self.rewardType = @"sale";
    
//    self.navigationView.backgroundColor = TRZXMainColor;
//    self.titleColor = [UIColor whiteColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRMyWorkDetailListCell" bundle:nil] forCellReuseIdentifier:@"TRMyWorkDetailListCell"];
    [self.view addSubview:self.tableView];
    TRMyWorkDetailHeadView *headerView = [[[NSBundle mainBundle]loadNibNamed:@"TRMyWorkDetailHeadView" owner:self options:nil] firstObject];
    headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 102);
    __weak TRMyWorkDetailViewController *weakself = self;
    headerView.buttonClick = ^(NSInteger index){
        weakself.selectedIndex = index;
    };
    self.tableView.tableHeaderView = headerView;
    //上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.mid = nil;
        [self loadData];
    }];
}


#pragma mark - 数据请求------------------------
- (void)loadData
{
    self.pageNO = @"1";
    self.tableView.mj_footer.hidden = YES;
    
    [self removerNoneImageView];
    
    
    if (self.mid == nil) {

        [TRZXMyPerformanceViewModel myWorkType:self.requestType rewardType:self.rewardType page:self.pageNO DetailSuccess:^(id json) {
            
            NSDictionary *dict = json;
            if ([dict[@"status_code"] isEqualToString:@"200"]) {
                
                if (self.dataSource.count > 0) {
                    [self.dataSource removeAllObjects];
                }
                
                self.totalPage = dict[@"totalPage"];
                self.one = dict[@"one"];
                self.two = dict[@"two"];
                TRMyWorkDetailHeadView *headerView = (TRMyWorkDetailHeadView *)self.tableView.tableHeaderView;
                headerView.sellMoneyLabel.text = self.one;
                headerView.workMoney.text = self.two;
                
                [self paseDataWithDict:dict];
                
                NSArray *dataArray = dict[@"commissions"];
                if ( dataArray.count < 1) {
                    
//                    if ([self.rewardType isEqualToString:@"sale"]) {
//                        [self.tableView addSubview:self.noneImageView];
//                    }else{
                        [self.tableView addSubview:self.noneImageView];
//                    }
                    self.tableView.mj_footer.hidden = YES;
                }else{
                    [self removerNoneImageView];
                    self.tableView.mj_footer.hidden = NO;
                }
                
                
            }
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            
        }];
    }else{
        //////////点击用户
        [TRZXMyPerformanceViewModel myWorkUserDetailMid:self.mid Type:self.requestType rewardType:self.rewardType page:self.pageNO success:^(id json) {
            NSDictionary *dict = json;
            if ([dict[@"status_code"] isEqualToString:@"200"]) {
                
                if (self.dataSource.count > 0) {
                    [self.dataSource removeAllObjects];
                }
                NSArray *dataArray = dict[@"commissions"];
                NSArray *modelArray = [TRMyWorkModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.dataSource addObjectsFromArray:modelArray];
                if ( dataArray.count < 1) {
                    [self.tableView addSubview:self.noneImageView];
                    self.tableView.mj_footer.hidden = YES;
                }else{
                    [self.noneImageView removeFromSuperview];
                    _noneImageView = nil;
                    self.tableView.mj_footer.hidden = NO;
                }
            }
            
            [self.tableView.mj_header endRefreshing];
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:0];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }];
        
    }

}
- (void)removerNoneImageView{
    [self.noneImageView removeFromSuperview];
    _noneImageView = nil;
//    [self.noneImageListView removeFromSuperview];
//    _noneImageListView = nil;
    
}
- (void)addNoneImageViewWithArray:(NSArray *)array{
   
//    if (array.count > 0) {
//        return;
//    }
//    
//    if ([self.rewardType isEqualToString:@"sale"]) {
//        [self.tableView addSubview:self.noneImageListView];
//    }else{
//        [self.tableView addSubview:self.noneImageView];
//    }
//    
}

- (void)loadMoreData{
    
    NSInteger page =  [self.pageNO integerValue];
    page ++;
    
    if (page > [self.totalPage integerValue]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    self.pageNO = [NSString stringWithFormat:@"%ld",(long)page];
    
    if (self.mid == nil) {
    
        /////////////////
        [TRZXMyPerformanceViewModel myWorkType:self.requestType rewardType:self.requestType page:self.pageNO DetailSuccess:^(id json) {
            
            NSDictionary *dict = json;
            if ([dict[@"status_code"] isEqualToString:@"200"]) {
                [self paseDataWithDict:dict];
            }
            [self.tableView.mj_header endRefreshing];
        
            [self.tableView reloadData];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            
        }];
    }else{
        
        //////////////点击了用户
        [TRZXMyPerformanceViewModel myWorkUserDetailMid:self.mid Type:self.requestType rewardType:self.rewardType page:self.pageNO success:^(id json) {
            
            NSDictionary *dict = json;
            if ([dict[@"status_code"] isEqualToString:@"200"]) {
                
                NSArray *dataArray = dict[@"commissions"];
                NSArray *modelArray = [TRMyWorkModel mj_objectArrayWithKeyValuesArray:dataArray];
                [self.dataSource addObjectsFromArray:modelArray];
                
            }
            [self.tableView.mj_header endRefreshing];
            self.tableView.mj_footer.hidden = NO;
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
            [self.tableView reloadSections:indexSet withRowAnimation:0];
            
        } failure:^(NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }];
    }
    
}

/**
 设置头视图数据

 @param dict ,,
 */
- (void)setHeaderDataWithData:(NSDictionary *)dict{
    if (!self.first) {
        self.totalPage = dict[@"totalPage"];
        self.one = dict[@"one"];
        self.two = dict[@"two"];
        TRMyWorkDetailHeadView *headerView = (TRMyWorkDetailHeadView *)self.tableView.tableHeaderView;
        headerView.sellMoneyLabel.text = self.one;
        headerView.workMoney.text = self.two;
        self.first = YES;
    }
}
- (void)setUserDataWithData:(NSDictionary *)dict{
    if (!self.isloadUser) {

        self.isloadUser = YES;
    }
}



- (void)paseDataWithDict:(NSDictionary *)dict{
    
    NSArray *dataArray = dict[@"commissions"];
    
//    [self addNoneImageViewWithArray:dataArray];
    
    NSArray *modelArray = [TRMyWorkModel mj_objectArrayWithKeyValuesArray:dataArray];
    [self.dataSource addObjectsFromArray:modelArray];
    if ([self.rewardType isEqualToString:@"manage"]) {
        NSArray *array = dict[@"users"];
        if (self.userDataSource.count > 0) {
            [self.userDataSource removeAllObjects];
        }
        NSArray *modelArr = [TRMyWorkModel mj_objectArrayWithKeyValuesArray:array];
        [self.userDataSource addObjectsFromArray:modelArr];
    }
}

//////点击了全部
- (void)allButtonClick:(UIButton *)button{
    self.mid = nil;
    [self.dataSource removeAllObjects];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:0];
    [self loadData];
}
///////点击头像请求数据
- (void)loadUserOfWorkDataWithIndex:(NSInteger)index{
    TRMyWorkModel *model = self.userDataSource[index];
    self.mid = model.mid;
    [self.dataSource removeAllObjects];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:0];
    [self loadData];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if (self.selectedIndex == 1) {
        if (section == 0) {
            TRMyWorkUserHeadView *sectionHeader = [[[NSBundle mainBundle]loadNibNamed:@"TRMyWorkUserHeadView" owner:self options:nil] firstObject];
            sectionHeader.dataSource = [self.userDataSource copy];
            __weak TRMyWorkDetailViewController *weakself = self;
            sectionHeader.userHeadCallBack = ^(NSIndexPath *index,CGPoint offset){
                [weakself loadUserOfWorkDataWithIndex:index.row];
                weakself.offset = offset;
                weakself.userHeaderIndexPath = index;
            };
            [sectionHeader.allButton addTarget:self action:@selector(allButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//            [sectionHeader changeOffsetWithIndexPath:self.userHeaderIndexPath];
            return  sectionHeader;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.selectedIndex == 1) {
        if (section == 0) {
            return 78;
        }
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 0) {
            return 1;
        }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [UITableViewCell new];
    }

    TRMyWorkDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRMyWorkDetailListCell" forIndexPath:indexPath];
    TRMyWorkModel *model = self.dataSource[indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:[UIImage imageNamed:@"展位图"]];
    cell.timeLabel.text = model.time;
    cell.nameLabel.text = model.userName;
    cell.subTitleLabel.text = model.abs;
    cell.countLabel.text = model.amount;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 0;
    }

    return 65;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataSource.count == 0) {
        return;
    }
    if (indexPath.section != 0) {
        TRMyWorkModel *model = self.dataSource[indexPath.row];
        [self transToPersonalWithMid:model.userId];
    }
}



- (void)dealloc{
    
}

#pragma mark - 跳转个人主页

- (void)transToPersonalWithMid:(NSString *)mid
{
//
//    if (![NSObject showCertificationTip:self]) {
//
//        
//        PersonalInformationVC * studentPersonal=[[PersonalInformationVC alloc]init];
//        studentPersonal.midStrr = mid;
//        studentPersonal.otherStr = @"1";
//        [self.navigationController pushViewController:studentPersonal animated:true];
//
//    }


    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - setter/getter------------------------------------------------------------------------
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = backColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 65;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexBackgroundColor=[UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor blackColor];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}
- (NSMutableArray *)userDataSource
{
    if (_userDataSource == nil) {
        _userDataSource = [[NSMutableArray alloc]init];
    }
    return _userDataSource;
}
- (UIImageView *)noneImageView{
    if (_noneImageView == nil) {
//        if(iPHone5){
//            _noneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-self.view.frame.size.width)/2, self.view.frame.size.width, self.view.frame.size.width)];
//        }else{
            _noneImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, (self.view.frame.size.height-self.view.frame.size.width)/2, self.view.frame.size.width, self.view.frame.size.width)];
//        }
        _noneImageView.image = [UIImage imageNamed:@"列表无内容"];
        _noneImageView.contentMode = UIViewContentModeScaleAspectFill;
        _noneImageView.layer.masksToBounds = YES;
        _noneImageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noneImageViewClick:)];
//        [_noneImageView addGestureRecognizer:tap];
    }
    return _noneImageView;
}
//- (UIImageView *)noneListImageView{
//    if (_noneImageListView == nil) {
//        if(iPHone5){
//            _noneImageListView  = [[UIImageView alloc]initWithFrame:CGRectMake(0,64+102, SCREEN_WIDTH, SCREEN_HEIGHT-64-102)];
//        }else{
//            _noneImageListView  = [[UIImageView alloc]initWithFrame:CGRectMake(0,64+102, SCREEN_WIDTH, SCREEN_HEIGHT-64-102)];
//        }
//        _noneImageListView.image = [UIImage imageNamed:@"列表无内容.gif"];
//        _noneImageListView.contentMode = UIViewContentModeScaleAspectFill;
//        _noneImageListView.layer.masksToBounds = YES;
//        _noneImageListView.userInteractionEnabled = YES;
//        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(noneImageViewClick:)];
//        //        [_noneImageView addGestureRecognizer:tap];
//    }
//    return _noneImageListView;
//}

- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self.dataSource removeAllObjects];
    [self.userDataSource removeAllObjects];
    [self.tableView reloadData];
    if (selectedIndex == 0) {
        self.rewardType = @"sale";
    }else{
        self.rewardType = @"manage";
    }
    self.mid = nil;
    [self loadData];
}

@end
