//
//  APIDebugController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "APIDebugController.h"
#import "ONHttpClient.h"
#import "NSDictionary+on_addition.h"

@interface APIDebugController () <UIActionSheetDelegate>
@property(nonatomic,weak) IBOutlet UITextField *urlField;
@property(nonatomic,weak) IBOutlet UITextField *typeField;
@property(nonatomic,weak) IBOutlet UITextField *paramField;
@property(nonatomic,weak) IBOutlet UITextView *bodyView;
@property(nonatomic,weak) IBOutlet UITextView *resultView;
@property(nonatomic,assign) ONHttpType httpType;
@end

@implementation APIDebugController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.httpType = ONHttpPOST;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)reqeustAction {
    NSString *url = self.urlField.text;
    if (self.paramField.text.length) {
        url = [NSString stringWithFormat:@"%@?%@",url,self.paramField.text];
    }
    NSData *body = nil;
    if (self.bodyView.text.length) {
        body = [self.bodyView.text dataUsingEncoding:NSUTF8StringEncoding];
    }
    [[ONHttpClient sharedInstance] fetchWithURL:url
                                         params:body
                                    requestType:self.httpType
                                       callback:^(NSDictionary *response, NSError *error) {
                                           NSLog(@"%@",response);
                                           if (!error) {
                                               self.resultView.text = [response on_jsonStringEncoded];
                                           }
                                       }];
}

- (IBAction)chooseTypeAction {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"GET",@"POST",@"PUT",@"DELETE", nil];
    [actionSheet showInView:self.parentViewController.view];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            self.httpType = ONHttpGET;
            self.typeField.text = @"GET";
            break;
        }
        case 1:
        {
            self.httpType = ONHttpPOST;
            self.typeField.text = @"POST";
            break;
        }
        case 2:
        {
            self.httpType = ONHttpPUT;
            self.typeField.text = @"PUT";
            break;
        }
        case 3:
        {
            self.httpType = ONHttpDELETE;
            self.typeField.text = @"DELETE";
            break;
        }
        default:
            break;
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
