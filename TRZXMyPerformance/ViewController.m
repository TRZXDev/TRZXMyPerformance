//
//  ViewController.m
//  TRZXMyPerformance
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "ViewController.h"
#import "CTMediator+MyPerformance.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *vc = [[CTMediator sharedInstance]MyPerformance_TRZXMyPerformanceViewController:@{@"title":@"我的业绩"}];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
