//
//  APITestViewController+Device.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+Device.h"
#import "ONDeviceAPI.h"

@implementation APITestViewController (Device)
#pragma mark - Device

- (void)addDeviceAction {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
    [info setObject:@"Test Add iOS Device" forKey:@"title"];
    [info setObject:@"ios_auth_info" forKey:@"auth_info"];
    [ONDeviceAPI addDeviceWithInfo:[info on_jsonStringEncoded]
                          callBack:self.callback];
}

- (void)updateDeviceAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新设备"
                                                                   message:nil
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
                                                UITextField *textField = alert.textFields.firstObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"Test Update iOS Device" forKey:@"title"];
                                                [ONDeviceAPI editDeviceWithDeviceId:textField.text
                                                                           deviceInfo:[info on_jsonStringEncoded]
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

- (void)querySingeDeviceAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询设备"
                                                                   message:nil
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
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONDeviceAPI querySingleDeviceWithDeviceId:textField.text
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

- (void)fuzzyQueryDeviceAction {
    [ONDeviceAPI fuzzyQueryDevicesWithParam:@{}
                                   callBack:self.callback];
    
}

- (void)deleteDeviceAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除设备"
                                                                   message:nil
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
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONDeviceAPI deleteDeviceWithDeviceId:textField.text
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
