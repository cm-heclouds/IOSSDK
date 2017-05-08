//
//  MapSimController.m
//  OneNETSDK
//
//  Created by houwenjie on 2017/4/27.
//  Copyright © 2017年 iot. All rights reserved.
//

#import "MapSimController.h"
#import <MapKit/MapKit.h>
#import "ONAnnotation.h"
#import "ONDataPointAPI.h"
#import "NSDictionary+on_addition.h"
#import "SVProgressHUD.h"
#import "JZLocationConverter.h"

@interface MapSimController () <MKMapViewDelegate>
@property(nonatomic,weak) IBOutlet MKMapView *mapView;
@property(nonatomic,weak) IBOutlet UITextField *deviceField;
@property(nonatomic,weak) IBOutlet UITextField *datastreamField;
@property(nonatomic,weak) IBOutlet UILabel *coordinateLabel;
@property(nonatomic,weak) IBOutlet UITextView *resultTextView;
@property(nonatomic,assign) CLLocationCoordinate2D currentCoordinate;
@end

@implementation MapSimController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化地图中心点
    self.currentCoordinate = CLLocationCoordinate2DMake(29.555938711936, 106.54504782021999);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.currentCoordinate, 250, 250);
    [self.mapView setRegion:region animated:YES];
    //增加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mTapPress:)];
    [self.mapView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击地图事件
- (void)mTapPress:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];//这里touchPoint是点击的某点在地图控件中的位置
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];//这里touchMapCoordinate就是该点的经纬度了
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(touchMapCoordinate, 250, 250);
    [self.mapView setRegion:region animated:YES];
    self.currentCoordinate = touchMapCoordinate;
}

- (void)setCurrentCoordinate:(CLLocationCoordinate2D)currentCoordinate {
    _currentCoordinate = currentCoordinate;
    self.coordinateLabel.text = [NSString stringWithFormat:@"lat:%f,lon:%f",currentCoordinate.latitude,currentCoordinate.longitude];
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = currentCoordinate;
    [self.mapView addAnnotation:annotationPoint];
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
    [SVProgressHUD showWithStatus:@"Sending Request。。。"];
    //平台使用的是百度地图，需要将获得的坐标进行转换
    CLLocationCoordinate2D bdPt = [JZLocationConverter gcj02ToWgs84:self.currentCoordinate];
    NSDictionary *loc = @{@"lat":@(bdPt.latitude),@"lon":@(bdPt.longitude)};
    NSDictionary *info = @{@"datastreams":@[@{@"id":self.datastreamField.text,@"datapoints": @[@{@"value":loc}]}]};
    [ONDataPointAPI reportDataPointWithDeviceId:self.deviceField.text
                                   andBodyParam:[info on_jsonStringEncoded]
                                       callBack:^(NSDictionary *response, NSError *error) {
                                           [SVProgressHUD dismiss];
                                           NSLog(@"%@",response);
                                           if (!error) {
                                               self.resultTextView.text = [response on_jsonStringEncoded];
                                           }
                                       }];

    
}

#pragma mark - MapView

//MapView委托方法，当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [mapView setShowsUserLocation:NO];
    CLLocationCoordinate2D loc = [userLocation coordinate];
    //放大地图到自身的经纬度位置。
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 250, 250);
    [self.mapView setRegion:region animated:YES];
    self.currentCoordinate = loc;
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
