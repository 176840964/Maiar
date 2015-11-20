//
//  AppDelegate.m
//  MaiYa
//
//  Created by zxl on 15/8/12.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate () <WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    UIImage *image = [[UIImage imageNamed:@"naviBg"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:20], NSFontAttributeName, nil]];
//    [UINavigationBar appearance].barTintColor = [UIColor blackColor];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    [WXApi registerApp:WeChat_APP_ID withDescription:@"MaiYa"];
    
    [UserConfigManager shareManager].isLaunching = YES;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [[UserConfigManager shareManager] updatingLocation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    NSLog(@"%s, sourceApplication:%@", __func__, sourceApplication);
    
    if ([sourceApplication containsString:@"alipay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        return YES;
    } else {
        return  [WXApi handleOpenURL:url delegate:self];
    }
    
}

#pragma mark - WXApiDelegate
-(void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[PayResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationForWechatPaySuccess" object:nil];
                [[HintView getInstance] presentMessage:@"支付成功" isAutoDismiss:YES dismissBlock:^{
                }];
            }
                break;
                
            default:
            {
                NSString *strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [[HintView getInstance] presentMessage:strMsg isAutoDismiss:NO dismissBlock:nil];
            }
                break;
        }
    }
}

@end
