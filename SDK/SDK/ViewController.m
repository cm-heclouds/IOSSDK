//
//  ViewController.m
//  SDK
//
//  Created by ZHJ on 15/8/3.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import "ViewController.h"
#import "SVProgressHUD.h"
#import "SDK.h"
@interface ViewController ()
@property(nonatomic,strong)UITextField *username;
@property(nonatomic,strong)UITextField *pwd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)loginAction:(UIButton *)btn{
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *JSON=[[SDK share]userLogin:@"mzjmzj" andPWD:@"123456"];
        [JSON writeToFile:[SDK saveSandbox:@"userLoginMsg"] atomically:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if ([[JSON valueForKey:@"errno"] intValue]==0&&JSON!=nil) {//请求成功
                [self performSegueWithIdentifier:@"sdktest" sender:self];
            }else if(JSON==nil){
                [SVProgressHUD showErrorWithStatus:@"网络错误"];
            }else{
                [SVProgressHUD showErrorWithStatus:[JSON valueForKey:@"error"]];
            }
        });
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
