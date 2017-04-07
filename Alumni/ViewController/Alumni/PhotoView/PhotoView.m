//
//  PhotoView.m
//  Alumni
//
//  Created by Sun on 2017/2/10.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "PhotoView.h"

@implementation PhotoView{
    UIImageView *_headImageView;
    UILabel *_nameLabel;
    UIButton *_tapBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //头像
        UIImageView *headImageView = [[UIImageView alloc]init];
        headImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*4/5);
//        headImageView.backgroundColor = [UIColor yellowColor];
        _headImageView = headImageView;
        [self addSubview:_headImageView];
        //名字
        UILabel *nameLabel = [[UILabel alloc]init];
        nameLabel.frame = CGRectMake(0, frame.size.height*4/5, frame.size.width, frame.size.width/5);
        nameLabel.textAlignment = 1;
//        nameLabel.backgroundColor = [UIColor redColor];
        _nameLabel = nameLabel;
        [self addSubview:_nameLabel];
        
        UIButton *button = [[UIButton alloc]initWithFrame:frame];
        _tapBtn = button;
        [self addSubview:_tapBtn];
    }
    return self;
}
//设置图片
- (void)setHeadImage:(UIImageView *)headImageView {
    _headImageView.image = headImageView.image;
}
//设置名字
- (void)setNameText:(NSString *)nameText {
    _nameLabel.text = nameText;
}




@end
