//
//  MyTabBarViewController.m
//  Alumni
//
//  Created by Sun on 2017/2/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "MyTabBarViewController.h"

@interface MyTabBarViewController ()

@end

@implementation MyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.tintColor = BGColor(183, 10, 52);
    // Do any additional setup after loading the view.
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
