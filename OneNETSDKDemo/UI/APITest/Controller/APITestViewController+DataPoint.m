//
//  APITestViewController+DataPoint.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+DataPoint.h"
#import "ONDataPointAPI.h"

@implementation APITestViewController (DataPoint)
#pragma mark - DataPoint

- (void)addDataPointAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增数据点"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                NSDictionary *info = @{@"datastreams":@[@{@"id":@"TestDataStream",@"datapoints": @[@{@"value":@1}]}]};
                                                [ONDataPointAPI reportDataPointWithDeviceId:deviceField.text
                                                                               andBodyParam:[info on_jsonStringEncoded]
                                                                                   callBack:self.callback];
                                                
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    UIAlertAction *okAction = alert.actions.firstObject;
    okAction.enabled = false;
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

- (void)queryDataPointAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询数据点"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@(rand()) forKey:@"TestDataStream"];
                                                [ONDataPointAPI queryDataPointWithDeviceId:deviceField.text
                                                                                  andParam:@{}
                                                                                  callBack:self.callback];
                                                
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    UIAlertAction *okAction = alert.actions.firstObject;
    okAction.enabled = false;
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}
@end
