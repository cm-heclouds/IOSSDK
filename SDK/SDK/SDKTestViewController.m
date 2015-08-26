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

/**
 *  1所有方法需要RequestKey的参数都是 登录成功时，从登录结果返回获取的 APIKEY参数
 *  2所有需要传递参数的RequestParam 形式都如同 @"{\"title\":\"test\"}"
 *  3所有需要DeviceID的参数的都是当前设备的设备ID
 */

@interface SDKTestViewController (){
    NSDictionary *dict;
}
@property(nonatomic,strong)NSDictionary *userLoginMsg;

@end

@implementation SDKTestViewController
@synthesize userLoginMsg;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSDictionary *result=[[SDK share] sentDataReqestKey:@"b77a30acf8368345c72c55172fbb352f" andDeviceId:@"143217" andParam:@"123"];
    NSLog(@"result==%@",result);

//     Do any additional setup after loading the view.
//     userLoginMsg=[[NSDictionary alloc]initWithContentsOfFile:[SDK saveSandbox:@"userLoginMsg"]];
//    requestKey=[[userLoginMsg valueForKey:@"data"] valueForKey:@"api_key"];
}

#pragma mark  设备相关方法-------------
-(IBAction)deviceAction:(UIButton *)btn{
    
    switch (btn.tag) {
        case 1:{//添加设备
            dict=[[SDK share]addDeviceRequestKey:@"c860c74d093db0ef739fecdbc81d2dab" andRequestParam:@"{\"title\":\"test001\"}"];
            NSLog(@"dict==%@",dict);
            
        }
            break;
        case 2:{//获取设备列表
            
            dict=[[SDK share] getMoreDeviceRequestKey:@"<填入登录时获取的APIKey>" andPage:1 andPerPage:5 andRequestParam:nil];
        }
            break;
        case 3:{//获取单个设备
           
            dict=[[SDK share] getSingleDeviceRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>"];
        }
            break;
        case 4:{//编辑设备
            dict=[[SDK share]editDeviceRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>" andRequestParam:@"{\"title\":\"test\"}"];
        }
            break;
        case 5:{//删除设备
            dict=[[SDK share]deleteDeviceRequsetKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>"];
          
        }
            break;
        default:
            break;
    }
    
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
    
}

#pragma mark 数据流相关方法-----------
-(IBAction)datastreamAction:(UIButton *)btn{
  
    switch (btn.tag) {
        case 1:{//添加数据流
            dict=[[SDK share]addDataPointRequestKey:@"c860c74d093db0ef739fecdbc81d2dab" andDeviceId:@"143217" andParam:@"{\"id\":\"23\"}"];
            NSLog(@"dict==%@",dict);
        }
            break;
        case 2:{//读取数据流
            dict=[[SDK share]readSingleDataPointRequestKey:@"c860c74d093db0ef739fecdbc81d2dab" andDeviceId:@"143217" andDataStreamId:@""];
            NSLog(@"dict==%@",dict);
        }
            break;
        case 3:{//读取数量列表
            dict=[[SDK share] readMoreDataPointRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>" andParam:@"{}"];
        }
            break;
        case 4:{//编辑数据流
            dict=[[SDK share] editDataPointRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>" andDataStreamId:@"" andParam:@"{}"];
        }
            break;
        case 5:{//删除数据流
            dict=[[SDK share]deleteDataPointRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>" andDataStreamId:@""];
        }
            break;
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

#pragma mark 触发器相关方法 ------------
-(IBAction)triggerAction:(UIButton *)btn{
   

    switch (btn.tag) {
        case 1:{//新增触发器
            dict=[[SDK share] addTriggerRequestKey:@"<填入登录时获取的APIKey>" andDeviceId:@"<当前设备对应的设备ID>" andDataStreamId:@"<当前数据流ID>" andParam:@"{}"];
        }
            break;
        case 2:{//编辑触发器
            dict=[[SDK share]editTriggerRequestKey:@"<填入登录时获取的APIKey>" andTriggerId:@"<当前触发器ID>" andParam:@"{}"];
        }
            break;
        case 3:{//删除触发器
            dict=[[SDK share]deleteTriggerRequestKey:@"<填入登录时获取的APIKey>" andTriggerId:@"<要删除触发器的ID>"];
        }
            break;
        
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

#pragma mark apikey相关方法--------
-(IBAction)apikeyAction:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{//新增APIKEY
            dict=[[SDK share]addAPIKeyRequestKey:@"<填入登录时获取的APIKey>" andParam:@"{}"];
        }
            break;
        case 2:{//编辑APIKEY
            dict=[[SDK share]editAPIKeyRequestkey:@"<填入登录时获取的APIKey>" andAPIKeyId:@"<当前APIKey ID>" andParam:@"{}"];
        }
            break;
        case 3:{//读取APIKEY
            dict=[[SDK share]readAPIKeyRequestKey:@"<填入登录时获取的APIKey>" andParam:@"{}"];
        }
            break;
            
        default:
            break;
    }
     [self performSegueWithIdentifier:@"sdkresult" sender:self];
}

#pragma mark 二进制相关---------
-(IBAction)Bindata:(UIButton *)btn{
    switch (btn.tag) {
        case 1:{//添加二进制
            
            dict=[[SDK share] uploadBindataRequestKey:@"<填入登录时获取的APIKey>" andBindata:[NSData data] andPrama:@"{}"];
        }
            break;
        case 2:{//读取二进制
            dict=[[SDK share]readBindataRequestKey:@"<填入登录时获取的APIKey>" andBindataIndex:@"<二进制索引>"];
        }
            break;
        case 3:{//删除二进制
            dict=[[SDK share]deleteBindataRequestKey:@"<填入登录时获取的APIKey>" andBindataIndex:@"<二进制索引>"];
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
