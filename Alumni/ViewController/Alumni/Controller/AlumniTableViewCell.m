//
//  AlumniTableViewCell.m
//  Alumni
//
//  Created by Sun on 2017/2/10.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "AlumniTableViewCell.h"
#import "PhotoView.h"
#import "UserModel.h"
@implementation AlumniTableViewCell{
    UIView *_lineView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - createUI
- (void)createUI {
    //创建三个photoView
    for (int index = 0; index < 3; index++) {
        PhotoView *photoView = [[PhotoView alloc]initWithFrame:CGRectMake(10 + index *(10 + PhotoImageW), 10, PhotoImageW, PhotoImageH)];
        photoView.hidden = YES;
        photoView.tag = 99 + index;
        [self addSubview: photoView];
    }
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_lineView];
}

//刷新数据
- (void)reloadData:(NSArray *)oneCellArray withFrame:(float)cellFrame cellIndex:(NSInteger)cellIndex{
    for (int index = 0; index < 3; index++) {
        PhotoView *photoView = [self viewWithTag:99 + index];
        if (index < oneCellArray.count) {
            UserModel *model = oneCellArray[index];
            photoView.hidden = NO;
            photoView.nameText = [NSString stringWithFormat:@"a=%ld,c=%ld",oneCellArray.count,(long)cellIndex];
            photoView.nameText = model.userNameStr;
            [photoView.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Http_Adress,model.userIconStr]] placeholderImage:[UIImage imageNamed:@"dzq.jpg"]];
            NSLog(@"tag = %ld",photoView.tag);
        }else{
            photoView.hidden = YES;
        }
    }
    _lineView.frame = CGRectMake(0, cellFrame - 1, VIEW_WIDTH, 0.5);
}

//点击事件
- (void)pushDetail:(UIButton *)btn {
    NSLog(@"tag = %ld",btn.tag);
}

@end
