//
//  SecondViewController.h
//  Alumni
//
//  Created by Sun on 2017/2/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <UIKit/UIKit.h>
/** BGImageH*/
#define  imageH [UIScreen mainScreen].bounds.size.width

@interface SecondViewController : UIViewController
//透明的ViewController
/** tableView */
@property (nonatomic, strong) UITableView *tableView;

/** 头部图片*/
@property (nonatomic, strong) UIImageView *headerImage;

/** 标题 */
@property (nonatomic, copy) NSString *titleName;
@end
