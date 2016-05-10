//
//  AppDelegate+LocationMonitor.m
//  LocationMonitorDemo
//
//  Created by daikiZhou on 2016/04/11.
//  Copyright © 2016年 daikiZhou. All rights reserved.
//

#import "AppDelegate.h"

#import <CoreLocation/CoreLocation.h>

typedef NS_ENUM(NSUInteger, LMMonitorMode) {
    LMMonitorModeNone       = 0,
    LMMonitorModeBackground = 1<<0,
    LMMonitorModeForeground = 1<<1,
    LMMonitorModeAllTime    = LMMonitorModeBackground|LMMonitorModeForeground
};

typedef NS_ENUM(NSUInteger, LMHandlerType) {
    LMHandlerTypeNone                = 0,
    LMHandlerTypeNotificationOnEntry = 1<<0,
    LMHandlerTypeNotificationOnExit  = 1<<1,
    LMHandlerTypeNotificationBoth    = LMHandlerTypeNotificationOnEntry|LMHandlerTypeNotificationOnExit,
    LMHandlerTypeBlockOnEntry        = 1<<2,
    LMHandlerTypeBlockOnExit         = 1<<3,
    LMHandlerTypeBlockBoth           = LMHandlerTypeBlockOnEntry|LMHandlerTypeBlockOnExit
};

typedef void(^LMEnterRegionHandler)(CLLocation *location, NSString *identifier);
typedef void(^LMExitRegionHandler)(CLLocation *location, NSString *identifier);

@interface AppDelegate (LocationMonitor)<CLLocationManagerDelegate>

@property /*(nonatomic, strong)*/ CLLocationManager *lmLocationManager;
@property /*(nonatomic, assign)*/ LMMonitorMode lmMonitorMode;
@property /*(nonatomic, assign)*/ LMHandlerType lmHandlerType;

@property /*(nonatomic, copy  )*/ LMEnterRegionHandler lmEntryRegionHandler;
@property /*(nonatomic, copy  )*/ LMExitRegionHandler lmExitRegionHandler;
@property /*(nonatomic, strong)*/ UILocalNotification *lmEntryRegionNotification;
@property /*(nonatomic, strong)*/ UILocalNotification *lmExitRegionNotification;

@property /*(nonatomic, strong)*/ NSMutableSet *lmRegionsToMonitor;

@property /*(nonatomic, assign)*/(readonly) BOOL locationMonitorEnabled;

- (void)createDefaultLocationMonitorInMode:(LMMonitorMode)mode lmHandlerType:(LMHandlerType)type;
- (BOOL)addMonitoringLocationsDictionary:(NSDictionary *)locations
                        monitoringRadius:(CGFloat)radius;
- (BOOL)addMonitoringLocation:(CLLocation *)location
             monitoringRadius:(CGFloat)radius
                   identifier:(NSString *)identifier;
- (BOOL)addMonitoringRegion:(CLRegion *)region;

- (void)enableLocationMonitor;
- (void)disableLocationMonitor;

@end
