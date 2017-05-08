//
//  TriggerListController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "TriggerListController.h"
#import "ONTriggerAPI.h"
#import "MJRefresh.h"
#import "TriggerInfoCell.h"
#import "TriggerInfoController.h"

@interface TriggerListController ()
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *triggerList;
@property(nonatomic,assign) int page;
@property(nonatomic,assign) int per_page;
@end

@implementation TriggerListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"触发器";
    [self.tableView registerNib:[UINib nibWithNibName:@"TriggerInfoCell" bundle:nil]
         forCellReuseIdentifier:@"kTriggerInfoCellIdentifier"];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                                    refreshingAction:@selector(loadData)];
    self.triggerList = [NSMutableArray array];
    [self refreshData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {
    self.page = 1;
    self.per_page = 20;
    [ONTriggerAPI queryTriggerWithParam:@{@"page":@(self.page),@"per_page":@(self.per_page)}
                               callBack:^(NSDictionary *response, NSError *error) {
                                       [self.tableView.mj_header endRefreshing];
                                       if (!error) {
                                           [self.triggerList removeAllObjects];
                                           [self handleDeviceResponse:response];
                                       }
                                   }];
}

- (void)loadData {
    self.page ++;
    [ONTriggerAPI queryTriggerWithParam:@{@"page":@(self.page),@"per_page":@(self.per_page)}
                                   callBack:^(NSDictionary *response, NSError *error) {
                                       if (!error) {
                                           [self handleDeviceResponse:response];
                                       }
                                   }];
}

- (void)handleDeviceResponse:(NSDictionary *)response {
    NSLog(@"%@",response);
    if ([[response objectForKey:@"errno"] integerValue] == 0) {
        NSDictionary *data = response[@"data"];
        NSArray *triggers = data[@"triggers"];
        [self.triggerList addObjectsFromArray:triggers];
        if (self.triggerList.count == [data[@"total_count"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.triggerList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TriggerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTriggerInfoCellIdentifier"
                                                           forIndexPath:indexPath];
    NSDictionary *dic = [self.triggerList objectAtIndex:indexPath.row];
    cell.triggerInfo = dic;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TriggerInfoController *info = [[TriggerInfoController alloc] init];
    info.triggerInfo = [self.triggerList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:info animated:YES];
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
