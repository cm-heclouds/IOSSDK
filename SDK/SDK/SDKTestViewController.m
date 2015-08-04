//
//  SDKTestViewController.m
//  SDK
//
//  Created by ZHJ on 15/8/4.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import "SDKTestViewController.h"
#import "SDK.h"
#import "SDKTestResultViewController.h"

@interface SDKTestViewController (){
    NSString *requestKey;
    NSDictionary *dict;
    NSString *deviceID;
}
@property(nonatomic,strong)NSDictionary *userLoginMsg;

@end

@implementation SDKTestViewController
@synthesize userLoginMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     userLoginMsg=[[NSDictionary alloc]initWithContentsOfFile:[SDK saveSandbox:@"userLoginMsg"]];
    requestKey=[[userLoginMsg valueForKey:@"data"] valueForKey:@"api_key"];
}

#pragma mark  设备
-(IBAction)deviceAction:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1:{//添加设备
            dict=[[SDK share]addDeviceRequestKey:requestKey andRequestParam:@"{\"title\":\"test\"}"];
            deviceID=dict[@"data"][@"device_id"];
        }
            break;
        case 2:{//获取设备列表
            
            dict=[[SDK share] getMoreDeviceRequestKey:requestKey andPage:1 andPerPage:5 andRequestParam:nil];
        }
            break;
        case 3:{//获取单个设备
            if (deviceID.length==0) {
               UIAlertView *alert =  [[UIAlertView alloc]initWithTitle:nil message:@"请添加设备" delegate:nil
                                cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                return;
            }
            dict=[[SDK share] getSingleDeviceRequestKey:requestKey andDeviceId:deviceID];
        }
            break;
        case 4:{//编辑设备
            dict=[[SDK share]editDeviceRequestKey:requestKey andDeviceId:deviceID andRequestParam:@"{\"title\":\"test\"}"];
        }
            break;
        case 5:{//删除设备
            dict=[[SDK share]deleteDeviceRequsetKey:requestKey andDeviceId:deviceID];
            deviceID=@"";
        }
            break;
        default:
            break;
    }
    
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
    
}

#pragma mark 数据流
-(IBAction)datastreamAction:(UIButton *)btn{
    if (deviceID.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请先添加设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    switch (btn.tag) {
        case 1:{//添加数据流
            dict=[[SDK share]addDataPointRequestKey:requestKey andDeviceId:deviceID andParam:@"{}"];
        }
            break;
        case 2:{//读取数据流
            dict=[[SDK share]readSingleDataPointRequestKey:requestKey andDeviceId:deviceID andDataStreamId:@""];
        }
            break;
        case 3:{//读取数量列表
            dict=[[SDK share] readMoreDataPointRequestKey:requestKey andDeviceId:deviceID andParam:@"{}"];
        }
            break;
        case 4:{//编辑数据流
            dict=[[SDK share] editDataPointRequestKey:requestKey andDeviceId:deviceID andDataStreamId:@"" andParam:@"{}"];
        }
            break;
        case 5:{//删除数据流
            dict=[[SDK share]deleteDataPointRequestKey:requestKey andDeviceId:deviceID andDataStreamId:@""];
        }
            break;
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

#pragma mark 触发器
-(IBAction)triggerAction:(UIButton *)btn{
    if (deviceID.length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"请先添加设备" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }

    switch (btn.tag) {
        case 1:{//新增触发器
            dict=[[SDK share] addTriggerRequestKey:requestKey andDeviceId:deviceID andDataStreamId:@"" andParam:@"{}"];
        }
            break;
        case 2:{//编辑触发器
            dict=[[SDK share]editTriggerRequestKey:requestKey andTriggerId:deviceID andParam:@"{}"];
        }
            break;
        case 3:{//删除触发器
            dict=[[SDK share]deleteTriggerRequestKey:requestKey andTriggerId:@""];
        }
            break;
        
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

#pragma mark apikey
-(IBAction)apikeyAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{//新增APIKEY
            dict=[[SDK share]addAPIKeyRequestKey:requestKey andParam:@"{}"];
        }
            break;
        case 2:{//编辑APIKEY
            dict=[[SDK share]editAPIKeyRequestkey:requestKey andAPIKeyId:@"" andParam:@"{}"];
        }
            break;
        case 3:{//读取APIKEY
            dict=[[SDK share]readAPIKeyRequestKey:requestKey andParam:@"{}"];
        }
            break;
            
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"sdkresult"]) {
        SDKTestResultViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.title=@"请求结果";
        destinationViewController.dict=dict;
    }
}


@end
