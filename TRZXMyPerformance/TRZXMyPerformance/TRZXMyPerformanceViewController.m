//
//  TRMyPerformanceViewController.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#define DetailButton 90033
#import "TRZXMyPerformanceViewController.h"
#import "TRMyWorkDetailViewController.h"

#import "TRMyWorkListCell.h"
#import "TRZXMyPerformanceViewModel.h"

#import "MyPerformanceHeader.h"


@interface TRMyPerformanceUIModel:NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *money;
@property (nonatomic,strong)UIColor *color;

@end

@implementation TRMyPerformanceUIModel

- (instancetype)initWithTitle:(NSString *)title money:(NSString *)money color:(UIColor *)color{
    if (self = [super init]) {
        self.title = title;
        self.money = money;
        self.color = color;
    }
    return self;
}
@end

@interface TRZXMyPerformanceViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray *dataSource;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,copy)NSString *day;
@property (nonatomic,copy)NSString *week;
@property (nonatomic,copy)NSString *month;
@property (nonatomic,copy)NSString *year;

@end

@implementation TRZXMyPerformanceViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addUI];
}

- (void)addUI
{
     self.title = self.titleString;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRMyWorkListCell" bundle:nil] forCellReuseIdentifier:@"TRMyWorkListCell"];
    [self.view addSubview:self.tableView];
   
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestLoadData];
    }];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - 数据请求------------------------
- (void)loadData
{
    TRMyPerformanceUIModel *UIModel1 = [[TRMyPerformanceUIModel alloc]initWithTitle:@"本日收益" money:[NSString stringWithFormat:@"%@ 元",self.day] color:RGB(250, 204, 0)];
    TRMyPerformanceUIModel *UIModel2 = [[TRMyPerformanceUIModel alloc]initWithTitle:@"本周收益" money:[NSString stringWithFormat:@"%@ 元",self.week] color:RGB(255, 162, 0)];
     TRMyPerformanceUIModel *UIModel3 = [[TRMyPerformanceUIModel alloc]initWithTitle:@"本月收益" money:[NSString stringWithFormat:@"%@ 元",self.month] color:RGB(255, 120, 0)];
     TRMyPerformanceUIModel *UIModel4 = [[TRMyPerformanceUIModel alloc]initWithTitle:@"本年收益" money:[NSString stringWithFormat:@"%@ 元",self.year] color:RGB(255, 6, 0)];
    self.dataSource = @[UIModel1,UIModel2,UIModel3,UIModel4];
}

- (void)requestLoadData{
    
    [TRZXMyPerformanceViewModel myWorkListSuccess:^(id json) {
        
        NSDictionary *dict = json;
        if ([dict[@"status_code"] isEqualToString:@"200"]) {
            self.day = dict[@"day"];
            self.week = dict[@"week"];
            self.month = dict[@"month"];
            self.year = dict[@"year"];
           
        }else{
            self.day = @"0";
            self.week = @"0";
            self.month = @"0";
            self.year = @"0";
        }
        [self loadData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRMyWorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TRMyWorkListCell" forIndexPath:indexPath];
    TRMyPerformanceUIModel *UIModel = self.dataSource[indexPath.row];
    cell.titleLabel.text = UIModel.title;
    cell.moneyLabel.text = UIModel.money;
    cell.bgView.backgroundColor = [UIColor whiteColor];
    cell.lookDetailButton.tag = DetailButton + indexPath.row;
    [cell.lookDetailButton addTarget:self action:@selector(lookDetail:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //行被选中后，自动变回反选状态的方法
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger index = indexPath.row;
    TRMyWorkDetailViewController *myWorkDetailView  = [[TRMyWorkDetailViewController alloc]init];
    myWorkDetailView.type = index;
    [self.navigationController pushViewController:myWorkDetailView animated:YES];
}
- (void)lookDetail:(UIButton *)button{
    NSInteger index = button.tag - DetailButton;
    TRMyWorkDetailViewController *myWorkDetailView  = [[TRMyWorkDetailViewController alloc]init];
    myWorkDetailView.type = index;
    [self.navigationController pushViewController:myWorkDetailView animated:YES];
}

- (void)dealloc{
    
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
        _tableView.rowHeight = (SCREEN_HEIGHT-62)/4 - 1.5;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionIndexBackgroundColor=[UIColor clearColor];
        _tableView.sectionIndexColor = [UIColor blackColor];
    }
    return _tableView;
}
//- (NSMutableArray *)dataSource
//{
//    if (_dataSource == nil) {
//        _dataSource = [[NSMutableArray alloc]init];
//    }
//    return _dataSource;
//}


@end
