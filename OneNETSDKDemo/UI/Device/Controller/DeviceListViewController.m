//
//  DeviceListViewController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "DeviceListViewController.h"
#import "DeviceInfoCell.h"
#import "ONDeviceAPI.h"
#import "MJRefresh.h"
#import "DeviceDetailController.h"

@interface DeviceListViewController ()
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *deviceList;
@property(nonatomic,assign) int page;
@property(nonatomic,assign) int per_page;
@end

@implementation DeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Device";
    [self.tableView registerNib:[UINib nibWithNibName:@"DeviceInfoCell" bundle:nil]
         forCellReuseIdentifier:@"kDeviceInfoCellIdentifier"];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(refreshData)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self
                                                          refreshingAction:@selector(loadData)];
    self.deviceList = [NSMutableArray array];
    [self refreshData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData {
    self.page = 1;
    self.per_page = 20;
    [ONDeviceAPI fuzzyQueryDevicesWithParam:@{@"page":@(self.page),@"per_page":@(self.per_page)}
                                   callBack:^(NSDictionary *response, NSError *error) {
                                       [self.tableView.mj_header endRefreshing];
                                       if (!error) {
                                           [self.deviceList removeAllObjects];
                                           [self handleDeviceResponse:response];
                                       }
                                   }];
}

- (void)loadData {
    self.page ++;
    [ONDeviceAPI fuzzyQueryDevicesWithParam:@{@"page":@(self.page),@"per_page":@(self.per_page)}
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
        NSArray *devices = data[@"devices"];
        [self.deviceList addObjectsFromArray:devices];
        if (self.deviceList.count == [data[@"total_count"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.deviceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeviceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kDeviceInfoCellIdentifier"
                                                           forIndexPath:indexPath];
    NSDictionary *dic = [self.deviceList objectAtIndex:indexPath.row];
    cell.deviceInfo = dic;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DeviceDetailController *info = [[DeviceDetailController alloc] init];
    info.deviceInfo = [self.deviceList objectAtIndex:indexPath.row];
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
