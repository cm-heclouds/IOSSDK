//
//  TriggerInfoController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/28.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "TriggerInfoController.h"
#import "ONTriggerAPI.h"
#import "NSDictionary+on_addition.h"

@interface TriggerInfoController ()
@property(nonatomic,weak) IBOutlet UITextView *responseView;
@end

@implementation TriggerInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.triggerInfo[@"title"];
    [ONTriggerAPI queryTriggerWithTriggerId:self.triggerInfo[@"id"]
                                      callBack:^(NSDictionary *response, NSError *error) {
                                          if (!error) {
                                              self.responseView.text = [response on_jsonStringEncoded];
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
