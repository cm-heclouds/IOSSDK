//
//  APITestViewController+Trigger.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+Trigger.h"
#import "ONTriggerAPI.h"

@implementation APITestViewController (Trigger)
#pragma mark - Trigger

- (void)addTriggerAction {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
    [info setObject:@"Test Add iOS Trigger" forKey:@"title"];
    [info setObject:@"TestDataStream" forKey:@"ds_id"];
    [info setObject:@">" forKey:@"type"];
    [info setObject:@"http://www.abc.com" forKey:@"url"];
    [info setObject:@(100) forKey:@"threshold"];
    [ONTriggerAPI addTriggerWithBodyParam:[info on_jsonStringEncoded]
                                 callBack:self.callback];
}

- (void)updateTriggerAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新触发器"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"触发器ID";
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"Test Update iOS Trigger" forKey:@"title"];
                                                [ONTriggerAPI editTriggerWithTriggerId:textField.text
                                                                             bodyParam:[info on_jsonStringEncoded]
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

- (void)querySingeTriggerAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询触发器"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
         textField.placeholder = @"触发器ID";
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONTriggerAPI queryTriggerWithTriggerId:textField.text
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

- (void)fuzzyQueryTriggerAction {
    [ONTriggerAPI queryTriggerWithParam:@{}
                               callBack:self.callback];
    
}

- (void)deleteTriggerAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除触发器"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
         textField.placeholder = @"触发器ID";
        
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONTriggerAPI deleteTriggerWithTriggerId:textField.text
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
