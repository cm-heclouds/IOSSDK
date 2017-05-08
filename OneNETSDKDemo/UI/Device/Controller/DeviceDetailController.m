//
//  DeviceDetailController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "DeviceDetailController.h"
#import "ONDeviceAPI.h"
#import "NSDictionary+on_addition.h"
#import "ONCommandAPI.h"
#import "EditDeviceController.h"

@interface DeviceDetailController ()
@property(nonatomic,weak) IBOutlet UITextView *descView;
@property(nonatomic,weak) IBOutlet UIButton *commandButton;
@end

@implementation DeviceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.deviceInfo[@"title"];
    if ([self.deviceInfo[@"protocol"] isEqualToString:@"HTTP"]
        || [self.deviceInfo[@"protocol"] isEqualToString:@"JTEXT"]) {
        self.commandButton.hidden = YES;
    }
    [ONDeviceAPI querySingleDeviceWithDeviceId:self.deviceInfo[@"id"]
                                      callBack:^(NSDictionary *response, NSError *error) {
                                          if (!error) {
                                              self.descView.text = [response on_jsonStringEncoded];
                                          }
                                      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editDevice:(id)sender {
    EditDeviceController *info = [[EditDeviceController alloc] init];
    info.deviceInfo = self.deviceInfo;
    [self.navigationController pushViewController:info animated:YES];

}

- (IBAction)deleteDevice:(id)sender {
    [ONDeviceAPI deleteDeviceWithDeviceId:self.deviceInfo[@"id"]
                                 callBack:^(NSDictionary *response, NSError *error) {
                                     if (!error) {
                                         [self.navigationController popViewControllerAnimated:YES];
                                     }
                                 }];
    
}

- (IBAction)sendCommand:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发送命令"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"命令内容";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * _Nonnull action) {
                                                UITextField *textField = alert.textFields.firstObject;
                                                [ONCommandAPI sentCmdWithDeviceId:self.deviceInfo[@"id"]
                                                                     andBodyParam:textField.text
                                                                         callBack:^(NSDictionary *response, NSError *error) {
                                                                             NSLog(@"%@",response);
                                                                         }];
                                                
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
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
