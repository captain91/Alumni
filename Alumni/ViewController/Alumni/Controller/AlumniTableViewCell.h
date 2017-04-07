//
//  AlumniTableViewCell.h
//  Alumni
//
//  Created by Sun on 2017/2/10.
//  Copyright © 2017年 sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlumniTableViewCell : UITableViewCell
-(void)reloadData:(NSArray *)oneCellArray withFrame:(float)cellFrame cellIndex:(NSInteger)cellIndex;
@end
