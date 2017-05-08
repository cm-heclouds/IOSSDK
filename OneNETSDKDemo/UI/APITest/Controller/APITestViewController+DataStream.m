//
//  APITestViewController+DataStream.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APITestViewController+DataStream.h"
#import "ONDataStreamAPI.h"

@implementation APITestViewController (DataStream)
#pragma mark - DataStream

- (void)addDataStreamAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增数据流"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"数据流ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                UITextField *streamIdField = alert.textFields.lastObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:streamIdField.text forKey:@"id"];
                                                [info setObject:@"TestUnit" forKey:@"unit"];
                                                [info setObject:@"TestSymbol" forKey:@"unit_symbol"];
                                                [ONDataStreamAPI addDataStreamWithDeviceId:deviceField.text
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

- (void)updateDataStreamAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新数据流"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"数据流ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                UITextField *streamIdField = alert.textFields.lastObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"TestUnit" forKey:@"unit"];
                                                [info setObject:@"TestSymbol" forKey:@"unit_symbol"];
                                                [ONDataStreamAPI editDataStreamWithDeviceId:deviceField.text
                                                                               dataStreamId:streamIdField.text
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

- (void)querySingeDataStreamAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询数据流"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"数据流ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                UITextField *streamIdField = alert.textFields.lastObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"TestUnit" forKey:@"unit"];
                                                [info setObject:@"TestSymbol" forKey:@"unit_symbol"];
                                                [ONDataStreamAPI querySingleDataStreamWithDeviceId:deviceField.text
                                                                                     dataStreamId:streamIdField.text
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

- (void)queryMoreDataStreamAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"查询数据流"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"数据流ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                UITextField *streamIdField = alert.textFields.lastObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"TestUnit" forKey:@"unit"];
                                                [info setObject:@"TestSymbol" forKey:@"unit_symbol"];
                                                [ONDataStreamAPI queryMultiDataStreamsWithDeviceId:deviceField.text
                                                                                     dataStreamIds:@[streamIdField.text]
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

- (void)deleteDataStreamAction {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除数据流"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"设备ID";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(alertTextFieldDidChange:)
                                                     name:UITextFieldTextDidChangeNotification
                                                   object:textField];
        textField.placeholder = @"数据流ID";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
                                                UITextField *deviceField = alert.textFields.firstObject;
                                                UITextField *streamIdField = alert.textFields.lastObject;
                                                NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
                                                [info setObject:@"TestUnit" forKey:@"unit"];
                                                [info setObject:@"TestSymbol" forKey:@"unit_symbol"];
                                                [ONDataStreamAPI deleteDataStreamWithDeviceId:deviceField.text
                                                                                 dataStreamId:streamIdField.text
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
