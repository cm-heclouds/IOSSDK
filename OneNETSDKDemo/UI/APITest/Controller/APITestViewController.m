//
//  APITestViewController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/26.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController.h"
#import "ONDeviceAPI.h"
#import "ONDataStreamAPI.h"
#import "ONDataPointAPI.h"
#import "ONTriggerAPI.h"
#import "ONBinaryAPI.h"
#import "ONCommandAPI.h"
#import "ONMqttAPI.h"
#import "ONAPIKeyAPI.h"
#import "NSDictionary+on_addition.h"
#import "APIResponseController.h"

@interface APITestViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray             *dataSource;
    NSMutableArray      *stateArray;
}
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@end

@implementation APITestViewController

- (void)initDataSource
{
    NSArray *devices = @[@{@"title":@"Add device",@"action":@"addDeviceAction"},
                         @{@"title":@"Edit device",@"action":@"updateDeviceAction"},
                         @{@"title":@"Query singe device",@"action":@"querySingeDeviceAction"},
                         @{@"title":@"Fuzzy query devices",@"action":@"fuzzyQueryDeviceAction"},
                         @{@"title":@"Delete device",@"action":@"deleteDeviceAction"}];
    NSArray *dataStream = @[@{@"title":@"Add dataStream",@"action":@"addDataStreamAction"},
                         @{@"title":@"Edit dataStream",@"action":@"updateDataStreamAction"},
                         @{@"title":@"Query singe dataStream",@"action":@"querySingeDataStreamAction"},
                         @{@"title":@"Query muti dataStream",@"action":@"queryMoreDataStreamAction"},
                         @{@"title":@"Delete dataStream",@"action":@"deleteDataStreamAction"}];
    NSArray *datapoint = @[@{@"title":@"Add datapoint",@"action":@"addDataPointAction"},
                         @{@"title":@"Query datapoint",@"action":@"queryDataPointAction"}];
    NSArray *trigger = @[@{@"title":@"Add trigger",@"action":@"addTriggerAction"},
                         @{@"title":@"Edit trigger",@"action":@"updateTriggerAction"},
                         @{@"title":@"Query singe trigger",@"action":@"querySingeTriggerAction"},
                         @{@"title":@"Fuzzy query triggers",@"action":@"fuzzyQueryTriggerAction"},
                         @{@"title":@"Delete trigger",@"action":@"deleteTriggerAction"}];
    NSArray *binary = @[@{@"title":@"Add binary",@"action":@"addBinaryAction"},
                         @{@"title":@"Query binary",@"action":@"queryBinaryAction"}];
    NSArray *command = @[@{@"title":@"Send command",@"action":@"sendCommandAction"},
                         @{@"title":@"Query command status",@"action":@"queryCommandStatusAction"},
                         @{@"title":@"Query command response",@"action":@"queryCommandResponseAction"}];
    NSArray *mqtt = @[@{@"title":@"Send command by topic",@"action":@"sendCommandByTopicAction"},
                         @{@"title":@"Query devices by topic",@"action":@"queryDeviceByTopicAction"},
                         @{@"title":@"Query device topics",@"action":@"queryTopicByDeviceAction"},
                         @{@"title":@"Add product topic",@"action":@"addTopicAction"},
                         @{@"title":@"Delete product topic",@"action":@"deleteTopicAction"},
                         @{@"title":@"Query product topics",@"action":@"queryTopics"}];
    NSArray *apikey = @[@{@"title":@"Add apikey",@"action":@"addAPIKeyAction"},
                      @{@"title":@"Edit apikey",@"action":@"updateAPIKeyAction"},
                      @{@"title":@"Query apikeys",@"action":@"queryAPIKeyAction"},
                      @{@"title":@"Delete apikey",@"action":@"deleteAPIKeyAction"}];
    
    dataSource = @[@{@"title":@"devices",@"data":devices},
                   @{@"title":@"dataStream",@"data":dataStream},
                   @{@"title":@"datapoint",@"data":datapoint},
                   @{@"title":@"trigger",@"data":trigger},
                   @{@"title":@"binary",@"data":binary},
                   @{@"title":@"command",@"data":command},
                   @{@"title":@"mqtt",@"data":mqtt},
                   @{@"title":@"apikey",@"data":apikey}];
    stateArray = [NSMutableArray array];
    
    for (int i = 0; i < dataSource.count; i++)
    {
        //所有的分区都是闭合
        [stateArray addObject:@"0"];
    }
}
- (void)viewDidLoad {
    self.title = @"APITest";
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initDataSource];
    
    __weak __typeof__(self) weakSelf = self;
    self.callback = ^(NSDictionary *response, NSError *error) {
        NSLog(@"%@",response);
        APIResponseController *responseController = [[APIResponseController alloc] init];
        responseController.response = [response on_jsonStringEncoded];
        [weakSelf.navigationController pushViewController:responseController animated:YES];
    };
}
#pragma mark -
#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSDictionary *item = dataSource[section];
        NSArray *array = item[@"data"];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    NSDictionary *item = dataSource[indexPath.section];
    NSArray *array = item[@"data"];
    NSDictionary *childItem = array[indexPath.row];
    cell.textLabel.text = childItem[@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *item = dataSource[section];
    return item[@"title"];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [button addSubview:line];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (44-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:18]];
    NSDictionary *item = dataSource[section];
    tlabel.text = item[@"title"];
    [button addSubview:tlabel];
    return button;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = dataSource[indexPath.section];
    NSArray *array = item[@"data"];
    NSDictionary *childItem = array[indexPath.row];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(childItem[@"action"]) withObject:nil];
#pragma clang diagnostic pop
}

//headButton点击
- (void)buttonPress:(UIButton *)sender {
    //判断状态值
    if ([stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1]
                  withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark -- Notification
- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *firtst = alertController.textFields.firstObject;
        if (alertController.textFields.count > 1) {
            UITextField *last = alertController.textFields.lastObject;
            UIAlertAction *okAction = alertController.actions.firstObject;
            okAction.enabled = firtst.text.length && last.text.length;
            
        }else {
            UIAlertAction *okAction = alertController.actions.firstObject;
            okAction.enabled = firtst.text.length > 0;
        }
       
    }
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
