//
//  APITestViewController+Command.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+Command.h"
#import "ONCommandAPI.h"

@implementation APITestViewController (Command)
#pragma mark - Command

- (void)sendCommandAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送命令"
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
                                                [ONCommandAPI sentCmdWithDeviceId:textField.text
                                                                     andBodyParam:@"Test Send Command"
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

- (void)queryCommandStatusAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询命令"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"commandId";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONCommandAPI queryStatueWithCmdId:textField.text
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

- (void)queryCommandResponseAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询命令"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"commandId";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONCommandAPI queryCmdResponseWithCmdId:textField.text
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
