//
//  FirstViewController.m
//  Alumni
//
//  Created by Sun on 2017/2/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
/** 导航条View*/
@property(nonatomic, weak) UIView *navBarView;

@end

@implementation FirstViewController

-(UIView *)navBarView{
    if (!_navBarView) {
        UIView *navBarView = [[UIView alloc]init];
        navBarView.backgroundColor = BGColor(183, 10, 52);
        navBarView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
        [self.view addSubview:navBarView];
        self.navBarView = navBarView;
    }
    return _navBarView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

@end
