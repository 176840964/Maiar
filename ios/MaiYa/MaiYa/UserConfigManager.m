//
//  UserConfigManager.m
//  MaiYa
//
//  Created by zxl on 15/8/21.
//  Copyright (c) 2015年 zhongqinglongtu. All rights reserved.
//

#import "UserConfigManager.h"
#import <CoreLocation/CoreLocation.h>

@interface UserConfigManager ()<CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation UserConfigManager

+ (NSString *)pathOfDataFile {
    static NSString *s_pathOfDataFile = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_pathOfDataFile = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"UserConfigManager.data"];
    });
    
    return s_pathOfDataFile;
}

+ (instancetype)shareManager {
    static UserConfigManager *s_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @try {
            s_instance = [NSKeyedUnarchiver unarchiveObjectWithFile:[self pathOfDataFile]];
        }
        @catch (NSException *exception) {
            [[NSFileManager defaultManager] removeItemAtPath:[self pathOfDataFile] error:nil];
        }
        @finally {
            if (nil == s_instance) {
                s_instance = [[UserConfigManager alloc] init];
                s_instance.lonStr = @"0";
                s_instance.latStr = @"0";
            }
        }
    });
    
    return s_instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isLogin = NO;
    }
    
    return self;
}

- (CreateOrderViewModel *)createOrderViewModel {
    if (nil == _createOrderViewModel) {
        _createOrderViewModel = [[CreateOrderViewModel alloc] init];
    }
    
    return _createOrderViewModel;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (!_isLogin) {
        self.userInfo = nil;
    } else {
        [self updatingLocation];//登录成功后，更新地址信息
    }
    
    [self synchronize];
}

- (CLLocationManager *)locationManager {
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return _locationManager;
}

- (void)synchronize {
    [NSKeyedArchiver archiveRootObject:self toFile:[self.class pathOfDataFile]];
}

- (void)updatingLocation {
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {//ios8
        [self.locationManager requestWhenInUseAuthorization];//使用中授权
    }
    [self.locationManager startUpdatingLocation];
}

- (void)clearCreateOrderInfo {
    [self.createOrderViewModel clear];
}

#pragma mark - networking
- (void)updateUserCoordinate {
    [[NetworkingManager shareManager] networkingWithGetMethodPath:@"coordinate" params:@{@"uid": self.userInfo.uidStr, @"longitude": self.lonStr, @"latitude": self.latStr} success:^(id responseObject) {
    }];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userInfo forKey:@"userInfo"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.userInfo = [aDecoder decodeObjectForKey:@"userInfo"];
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        
        self.lonStr = @"0";
        self.latStr = @"0";
        
        [self updatingLocation];
    }
    
    return self;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [manager stopUpdatingLocation];
    CLLocation *location = locations.firstObject;
    NSString *lon = [NSString stringWithFormat:@"%f" ,location.coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f" ,location.coordinate.latitude];
    NSLog(@"经度:%@, 纬度:%@", lat, lon);
    
    self.lonStr = lon;
    self.latStr = lat;
    
    if (self.isLogin) {
        [self updateUserCoordinate];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager startUpdatingLocation];
}

@end
