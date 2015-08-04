//
//  SVProgressHUD.h
//
//  Created by Sam Vermette on 27.03.11.
//  Copyright 2011 Sam Vermette. All rights reserved.
//
//  https://github.com/samvermette/SVProgressHUD
//

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

enum {
    MySVProgressHUDMaskTypeNone = 1, // allow user interactions while HUD is displayed
    MySVProgressHUDMaskTypeClear, // don't allow
    MySVProgressHUDMaskTypeBlack, // don't allow and dim the UI in the back of the HUD
    MySVProgressHUDMaskTypeGradient // don't allow and dim the UI with a a-la-alert-view bg gradient
};

typedef NSUInteger MySVProgressHUDMaskType;

@interface MySVProgressHUD : UIView

+ (void)show;
+ (void)showWithStatus:(NSString*)status;
+ (void)showWithStatus:(NSString*)status maskType:(MySVProgressHUDMaskType)maskType;
+ (void)showWithMaskType:(MySVProgressHUDMaskType)maskType;

+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString *)string duration:(NSTimeInterval)duration;
+ (void)showErrorWithStatus:(NSString *)string;
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration;

+ (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

+ (void)dismiss; // simply dismiss the HUD with a fade+scale out animation
+ (void)dismissWithSuccess:(NSString*)successString; // also displays the success icon image
+ (void)dismissWithSuccess:(NSString*)successString afterDelay:(NSTimeInterval)seconds;
+ (void)dismissWithError:(NSString*)errorString; // also displays the error icon image
+ (void)dismissWithError:(NSString*)errorString afterDelay:(NSTimeInterval)seconds;

+ (BOOL)isVisible;

@end
