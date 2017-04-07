//
//  AlumniViewController.m
//  Alumni
//
//  Created by Sun on 2017/2/9.
//  Copyright © 2017年 sun. All rights reserved.
//

#import "AlumniViewController.h"
#import "AlumniTableViewCell.h"
#import "UserModel.h"
@interface AlumniViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AlumniViewController{
    UITableView *_mainTableView;
    
    //存数据的数组
    NSMutableArray *_allDataArray;
    
    NSMutableArray *_oneCellArray;
    
    NSInteger _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigation];
    
    [self initData];
    
    [self createTableView];
    
    [self requestDataWithPage:_page];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - customNavigation
- (void)customNavigation {
    self.navigationItem.title = @"同学录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"引导页" style:UIBarButtonItemStyleDone target:self action:@selector(showIntroductionView)];
}
- (void)showIntroductionView {
    [[NSUserDefaults standardUserDefaults]setObject:@"NO" forKey:ISFIRSTOPEN];
}
- (void)initData {
    _allDataArray = [[NSMutableArray alloc]init];
    _oneCellArray = [[NSMutableArray alloc]init];
    _page = 0;
}

#pragma mark - TableView
- (void)createTableView {
    _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATION_H, VIEW_WIDTH, VIEW_HEIGHT-NAVIGATION_H-49) style:UITableViewStylePlain];
    _mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    
    //添加刷新
    //刷新
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 0;
        [_oneCellArray removeAllObjects];
        [self requestDataWithPage:_page];
    }];
    
    //加载数据
    _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [self requestDataWithPage:_page];
    }];
}
-(void)endRefreshing{
    [_mainTableView.mj_header endRefreshing];
    [_mainTableView.mj_footer endRefreshing];
}
#pragma mark - requestData
- (void)requestDataWithPage:(NSInteger )page{
    NSString *urlStr = [NSString stringWithFormat:StudentsList_Https,page];
    
    [HttpRequest GET:urlStr params:nil succeed:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"error"] integerValue]==0) {
            [self analyData:responseObject[@"rows"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self endRefreshing];
    }];
    NSLog(@"数据整理完毕");
}

-(void)analyData:(NSArray *)dictArray {
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= dictArray.count; i++) {
        UserModel *model = [[UserModel alloc]initDataModelWithDictionary:dictArray[i-1]];
        [tempArray addObject:model];
        if (i == dictArray.count) {
            [_oneCellArray addObject:tempArray];
            break;
        }
        if (i%3==0) {
            NSArray *tArray = [NSArray arrayWithArray:tempArray];
            [_oneCellArray addObject:tArray];
            [tempArray removeAllObjects];
        }
    }
    //去掉动画效果
    [self endRefreshing];
    [_mainTableView reloadData];
}
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _oneCellArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"alumniCell";
    AlumniTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[AlumniTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell reloadData:_oneCellArray[indexPath.row] withFrame:PhotoImageH + 11 cellIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PhotoImageH + 11;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"");
    AlumniTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSArray *tempArray =[NSArray arrayWithArray:_oneCellArray[indexPath.row]];
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
