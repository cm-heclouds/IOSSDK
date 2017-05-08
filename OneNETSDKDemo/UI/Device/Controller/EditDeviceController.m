//
//  EditDeviceController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "EditDeviceController.h"
#import "ONDeviceAPI.h"
#import "NSDictionary+on_addition.h"

@interface EditDeviceController ()
@property(nonatomic,weak) IBOutlet UITextField *devicenameField;
@property(nonatomic,weak) IBOutlet UITextField *authInfoField;
@property(nonatomic,weak) IBOutlet UISegmentedControl *privateSegment;
@property(nonatomic,weak) IBOutlet UITextView *resultTextView;
@end

@implementation EditDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.devicenameField.text = self.deviceInfo[@"title"];
    self.authInfoField.text = self.deviceInfo[@"auth_info"];
    if ([self.deviceInfo[@"private"] boolValue]) {
        self.privateSegment.selectedSegmentIndex = 0;
    }else {
        self.privateSegment.selectedSegmentIndex = 1;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(updateAction)];
    
}

-(void)updateAction {
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:3];
    [info setObject:self.devicenameField.text forKey:@"title"];
    [info setObject:self.authInfoField.text forKey:@"auth_info"];
    BOOL private = !self.privateSegment.selectedSegmentIndex;
    [info setObject:@(private) forKey:@"private"];
    [ONDeviceAPI editDeviceWithDeviceId:self.deviceInfo[@"id"]
                               deviceInfo:[info on_jsonStringEncoded]
                                 callBack:^(NSDictionary *response, NSError *error) {
                                     if (!error) {
                                         self.resultTextView.text = [response on_jsonStringEncoded];
                                     }
                                 }];
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
