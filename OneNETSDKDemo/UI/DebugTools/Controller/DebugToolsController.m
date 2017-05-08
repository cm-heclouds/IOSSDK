//
//  DebugToolsController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/25.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "DebugToolsController.h"
#import "MapSimController.h"
#import "APIDebugController.h"
#import "DataSimController.h"
#import "Masonry.h"

@interface DebugToolsController () <UITabBarDelegate>
@property(nonatomic,weak) IBOutlet UITabBar *tabBar;
@property(nonatomic,weak) IBOutlet UIView *containerView;
@property(nonatomic,strong) UIViewController *currentController;
@property(nonatomic,strong) MapSimController *mapSimController;
@property(nonatomic,strong) APIDebugController *apiDebugController;
@property(nonatomic,strong) DataSimController *dataSimController;
@end

@implementation DebugToolsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"在线调试";
    
    self.tabBar.selectedItem = self.tabBar.items[0];
    
    self.mapSimController = [[MapSimController alloc] init];
    [self addChildViewController:self.mapSimController];
    
    self.dataSimController = [[DataSimController alloc] init];
    [self addChildViewController:self.dataSimController];
    
    self.apiDebugController = [[APIDebugController alloc] init];
    [self addChildViewController:self.apiDebugController];
    
    [self.containerView addSubview:self.mapSimController.view];
    self.currentController = self.mapSimController;
    [self.currentController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if (item.tag == 0) {
        [self replaceController:self.currentController newController:self.mapSimController];
    }else if (item.tag == 1) {
        [self replaceController:self.currentController newController:self.dataSimController];
    }else if (item.tag == 2) {
        [self replaceController:self.currentController newController:self.apiDebugController];
    }
}

//  切换各个标签内容
- (void)replaceController:(UIViewController *)oldController
            newController:(UIViewController *)newController
{
    self.tabBar.userInteractionEnabled = NO;
    [self transitionFromViewController:oldController
                      toViewController:newController duration:0.35f
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                [newController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                                    make.edges.equalTo(self.containerView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
                                }];
                                
                            }
                            completion:^(BOOL finished) {
        if (finished) {
            self.tabBar.userInteractionEnabled = YES;
            self.currentController = newController;
        }else{
            self.currentController = oldController;
        }
    }];
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
