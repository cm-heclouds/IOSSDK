//
//  SDKTestResultViewController.m
//  SDK
//
//  Created by ZHJ on 15/8/4.
//  Copyright (c) 2015年 CMCC. All rights reserved.
//

#import "SDKTestResultViewController.h"
#import "NSString+HXAddtions.h"

@interface SDKTestResultViewController ()

@end

@implementation SDKTestResultViewController
@synthesize dict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *jsonStr = [NSString jsonStringWithDictionary:dict];
    UITextView *textview=[[UITextView alloc]initWithFrame:self.view.frame];
    textview.text=jsonStr;
    textview.userInteractionEnabled=NO;
    [self.view addSubview:textview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
