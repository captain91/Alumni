//
//  PhotoView.h
//  Alumni
//
//  Created by Sun on 2017/2/10.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView
//设置image
@property(nonatomic,strong) UIImageView *headImageView;

//设置名字
@property(nonatomic,copy) NSString *nameText;
@end
