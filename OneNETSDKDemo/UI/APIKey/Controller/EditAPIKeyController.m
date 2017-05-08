//
//  EditAPIKeyController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "EditAPIKeyController.h"
#import "OneNETSDK.h"

@interface EditAPIKeyController ()
@property(nonatomic,weak) IBOutlet UITextField *apikeyField;
@end

@implementation EditAPIKeyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *apikey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apikey"];
    self.apikeyField.text = apikey;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveAction:(id)sender {
    if (self.apikeyField.text.length) {
        [OneNETSDK setAPIKey:self.apikeyField.text];
        [[NSUserDefaults standardUserDefaults] setObject:self.apikeyField.text forKey:@"apikey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
