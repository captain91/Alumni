//
//  AppDelegate.m
//  Alumni
//
//  Created by Sun on 2017/2/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "AppDelegate.h"
#import "AlumniViewController.h"
#import "UserCenterViewController.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) WelcomeView *introductionView;
@end

@implementation AppDelegate{
    UITabBarController *_tabBarController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置启动页停留2s
    [NSThread sleepForTimeInterval:2.0];

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //添加tabBarController
    [self addTabBarController];

    //判断是不是第一次登陆
    BOOL isFirstOpen = [[[NSUserDefaults standardUserDefaults] objectForKey:ISFIRSTOPEN] boolValue];
    if (!isFirstOpen) {
        //第一次打开
        [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:ISFIRSTOPEN];
        NSArray *coverImageName = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg",@"img_index_02bg",@"img_index_03bg"];
        self.introductionView = [[WelcomeView alloc]initWithCoverImageNames:coverImageName backgroundImageNames:backgroundImageNames];
        [self.window addSubview:self.introductionView];
        
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^{
            [weakSelf.introductionView removeFromSuperview];
            weakSelf.introductionView = nil;
        };
    }
    

    return YES;
}

#pragma mark - addTabBarController
- (void)addTabBarController {
    UINavigationController *alumniNa = [[UINavigationController alloc]initWithRootViewController:[AlumniViewController new]];
    UINavigationController *userCenterNa = [[UINavigationController alloc]initWithRootViewController:[UserCenterViewController new]];
    
    NSArray *tabBarTitleArray = [NSArray arrayWithObjects:@"同学录",@"个人中心", nil];
    NSArray *tabBarItemImageArray = [NSArray arrayWithObjects:@"Alumni",@"Mine", nil];
    NSArray *naArray = [NSArray arrayWithObjects:alumniNa,userCenterNa, nil];
    
    for (int tabIndex = 0; tabIndex < naArray.count; tabIndex++) {
        UITabBarItem *tabBarItem = [[UITabBarItem alloc]init];
        //设置文字
        [tabBarItem setTitle:tabBarTitleArray[tabIndex]];
        //设置图片
        UIImage *itemImage = [UIImage imageNamed:tabBarItemImageArray[tabIndex]];
        itemImage = [itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [tabBarItem setImage:itemImage];
        [tabBarItem setSelectedImage:[UIImage imageNamed:tabBarItemImageArray[tabIndex]]];
        //设置navigationcontroller对应的tabbarItem
        [naArray[tabIndex] setTabBarItem:tabBarItem];
    }
    //设置tabbarcontroller的controller
    _tabBarController = [[UITabBarController alloc]init];
    _tabBarController.viewControllers = naArray;
    _tabBarController.tabBar.tintColor = TabBarTintColor;
    
    //设置NavBarTitle字体颜色
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTintColor:[UIColor whiteColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.window.rootViewController = _tabBarController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
