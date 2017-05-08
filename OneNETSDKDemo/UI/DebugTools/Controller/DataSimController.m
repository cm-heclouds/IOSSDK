//
//  DataSimController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "DataSimController.h"
#import "ONDataPointAPI.h"
#import "NSDictionary+on_addition.h"
#import "SVProgressHUD.h"

@interface DataSimController ()
{
    NSTimer *repeatTimer;
}
@property(nonatomic,weak) IBOutlet UITextField *deviceField;
@property(nonatomic,weak) IBOutlet UITextField *datastreamField;
@property(nonatomic,weak) IBOutlet UITextField *minField;
@property(nonatomic,weak) IBOutlet UITextField *maxField;
@property(nonatomic,weak) IBOutlet UITextField *timeField;
@property(nonatomic,weak) IBOutlet UIButton *requestButton;
@property(nonatomic,weak) IBOutlet UITextView *resultTextView;
@property(nonatomic,weak) IBOutlet UILabel *timeLabel;
@end

@implementation DataSimController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestAction:(id)sender {
    if (!self.deviceField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入设备ID"];
        return;
    }
    if (!self.datastreamField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入DataStream"];
        return;
    }
    int from = self.minField.text.intValue;
    int to = self.maxField.text.intValue;
    if (from > to) {
        return;
    }
    [self requestTask];
 }

- (IBAction)repeatRequestAction:(UIButton *)sender {
    if (sender.selected) {
        if (repeatTimer) {
            [repeatTimer invalidate];
            repeatTimer = nil;
        }
        sender.selected = NO;
         [self enableUserTouch:!sender.selected];
        return;
    }
    if (!self.deviceField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入设备ID"];
        return;
    }
    if (!self.datastreamField.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入DataStream"];
        return;
    }
    int from = self.minField.text.intValue;
    int to = self.maxField.text.intValue;
    if (from > to) {
        [SVProgressHUD showErrorWithStatus:@"结束值必须大于起始值"];
        return;
    }
    double time = self.timeField.text.doubleValue;
    if (time <= 0) {
        [SVProgressHUD showErrorWithStatus:@"间隔时间必须大于0"];
        return;
    }
    sender.selected = YES;
    [self enableUserTouch:!sender.selected];
    repeatTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                                      target:self
                                                    selector:@selector(requestTask)
                                                    userInfo:nil
                                                     repeats:YES];
    [self requestTask];
}

- (void)enableUserTouch:(BOOL)enable {
    self.deviceField.userInteractionEnabled = enable;
    self.datastreamField.userInteractionEnabled = enable;
    self.minField.userInteractionEnabled = enable;
    self.maxField.userInteractionEnabled = enable;
    self.timeField.userInteractionEnabled = enable;
    self.requestButton.userInteractionEnabled = enable;
}

- (void)requestTask {
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[NSDate date]];
    int from = self.minField.text.intValue;
    int to = self.maxField.text.intValue;
    int value = [self getRandomNumber:from to:to];
    NSDictionary *info = @{@"datastreams":@[@{@"id":self.datastreamField.text,@"datapoints": @[@{@"value":@(value)}]}]};
    [ONDataPointAPI reportDataPointWithDeviceId:self.deviceField.text
                                   andBodyParam:[info on_jsonStringEncoded]
                                       callBack:^(NSDictionary *response, NSError *error) {
                                           NSLog(@"%@",response);
                                           if (!error) {
                                               self.resultTextView.text = [response on_jsonStringEncoded];
                                           }
                                       }];

}

//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
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
