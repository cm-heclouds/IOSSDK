//
//  APITestViewController+APIKey.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+APIKey.h"
#import "ONAPIKeyAPI.h"

@implementation APITestViewController (APIKey)
#pragma mark - APIKey

- (void)addAPIKeyAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询APIKey"
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
                                                [info setObject:textField.text forKey:@"dev_id"];
                                                [info setObject:@"TestAddApiKey" forKey:@"title"];
                                                NSDictionary *permission = @{@"resources":@[],@"access_methods":@[@"get",@"post"]};
                                                [info setObject:@[permission] forKey:@"permission"];
                                                
                                                [ONAPIKeyAPI addAPIKeyWithBodyParam:[info on_jsonStringEncoded]
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

- (void)updateAPIKeyAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询APIKey"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"APIKey";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"TestUpdateApiKey" forKey:@"title"];
                                                NSDictionary *permission = @{@"resources":@[],@"access_methods":@[@"get",@"post"]};
                                                [info setObject:@[permission] forKey:@"permission"];
                                                
                                                [ONAPIKeyAPI editAPIKey:textField.text
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

- (void)queryAPIKeyAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询APIKey"
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
                                                NSDictionary *param = @{};
                                                if (textField.text.length) {
                                                    param = @{@"device_id":textField.text};
                                                }
                                                [ONAPIKeyAPI queryAPIKeyWithParam:param
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

- (void)deleteAPIKeyAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除APIKey"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"APIKey";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONAPIKeyAPI deleteAPIKey:textField.text
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
