//
//  LeftSideViewController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/24.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "LeftSideViewController.h"
#import "UIViewController+MMDrawerController.h"

@interface LeftSideViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *controllerArray;
@end

@implementation LeftSideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"OneNET Resful SDK";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    UIColor * tableViewBackgroundColor;
    tableViewBackgroundColor = [UIColor colorWithRed:110.0/255.0
                                               green:113.0/255.0
                                                blue:115.0/255.0
                                               alpha:1.0];
    [self.tableView setBackgroundColor:tableViewBackgroundColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:66.0/255.0
                                                  green:69.0/255.0
                                                   blue:71.0/255.0
                                                  alpha:1.0]];
    
    UIColor * barColor = [UIColor colorWithRed:161.0/255.0
                                         green:164.0/255.0
                                          blue:166.0/255.0
                                         alpha:1.0];
    if([self.navigationController.navigationBar respondsToSelector:@selector(setBarTintColor:)]){
        [self.navigationController.navigationBar setBarTintColor:barColor];
    }
    else {
        [self.navigationController.navigationBar setTintColor:barColor];
    }
    
    
    NSDictionary *navBarTitleDict;
    UIColor * titleColor = [UIColor colorWithRed:55.0/255.0
                                           green:70.0/255.0
                                            blue:77.0/255.0
                                           alpha:1.0];
    navBarTitleDict = @{NSForegroundColorAttributeName:titleColor};
    [self.navigationController.navigationBar setTitleTextAttributes:navBarTitleDict];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    self.controllerArray = @[@{@"name":@"设备",@"class":@"DeviceListViewController",@"icon":@"图标"},
                             @{@"name":@"触发器",@"class":@"TriggerListController",@"icon":@"图标"},
                             @{@"name":@"在线调试",@"class":@"DebugToolsController",@"icon":@"图标"},
                             @{@"name":@"API测试",@"class":@"APITestViewController",@"icon":@"图标"},
                             @{@"name":@"修改Appkey",@"class":@"EditAPIKeyController",@"icon":@"图标"}];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kMyCellIdentifier"];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections-1)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)contentSizeDidChange:(NSString *)size{
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
    return self.controllerArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kMyCellIdentifier" forIndexPath:indexPath];
    NSDictionary *dic = [self.controllerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"右向箭头"]];
    cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    UIColor *backgroundColor = [UIColor colorWithRed:122.0/255.0
                                      green:126.0/255.0
                                       blue:128.0/255.0
                                      alpha:1.0];
    [cell setBackgroundColor:backgroundColor];
    
    [cell.textLabel setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor
                                  colorWithRed:230.0/255.0
                                  green:236.0/255.0
                                  blue:242.0/255.0
                                  alpha:1.0]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = self.controllerArray[indexPath.row];
    UIViewController *controller = [[NSClassFromString(item[@"class"]) alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self.mm_drawerController setCenterViewController:navigationController
                                   withCloseAnimation:YES
                                           completion:^(BOOL finished) {
                                               
                                           }];
    
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
