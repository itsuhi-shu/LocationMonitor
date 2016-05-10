//
//  AppDelegate+LocationMonitor.m
//  LocationMonitorDemo
//
//  Created by daikiZhou on 2016/04/11.
//  Copyright © 2016年 daikiZhou. All rights reserved.
//

#import "AppDelegate+LocationMonitor.h"

#import <objc/runtime.h>

#define LMBACKGROUNDQUEUELABEL "lmBackgroundQueueLabel"
static const NSString *LMBackgroundQueueKey  = @"lmBackgroundQueue";

static const NSString *LMBackgroundTaskName  = @"lmBackgroundTaskName";
static const NSString *LMBackgroundTaskKey   = @"lmBackgroundTask";

static const NSString *LMFirstTimeStateCount = @"lmFirstTimeStateCount";

@implementation AppDelegate (LocationMonitor)


#pragma mark - Create Monitor

- (void)createDefaultLocationMonitorInMode:(LMMonitorMode)mode lmHandlerType:(LMHandlerType)type {
    if (!self.lmLocationManager) {
        CLLocationManager *lmLocationManager = [[CLLocationManager alloc] init];
        [lmLocationManager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
        [lmLocationManager setDelegate:self];
        [lmLocationManager setDistanceFilter:1.0f];
//        [lmLocationManager requestAlwaysAuthorization];
        self.lmLocationManager = lmLocationManager;
    }
    self.lmMonitorMode = mode;
    self.lmHandlerType = type;
}

- (void)makeDefaultEntryNotification {
    self.lmEntryRegionNotification = [[UILocalNotification alloc] init];
    self.lmEntryRegionNotification.timeZone = [NSTimeZone defaultTimeZone];
    self.lmEntryRegionNotification.soundName = UILocalNotificationDefaultSoundName;
    self.lmEntryRegionNotification.alertTitle = @"Entry";
    self.lmEntryRegionNotification.applicationIconBadgeNumber = 0;
}

- (void)makeDefaultExitNotification {
    self.lmExitRegionNotification = [[UILocalNotification alloc] init];
    self.lmExitRegionNotification.timeZone = [NSTimeZone defaultTimeZone];
    self.lmExitRegionNotification.soundName = UILocalNotificationDefaultSoundName;
    self.lmExitRegionNotification.alertTitle = @"Exit";
    self.lmExitRegionNotification.applicationIconBadgeNumber = 0;
}

#pragma mark - Properties Getter / Setter

- (CLLocationManager *)lmLocationManager {
    return objc_getAssociatedObject(self, @selector(lmLocationManager));
}

- (void)setLmLocationManager:(CLLocationManager *)lmLocationManager {
    if (self.locationMonitorEnabled) {
        NSLog(@"1.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmLocationManager), lmLocationManager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LMMonitorMode)lmMonitorMode {
    NSNumber *number = objc_getAssociatedObject(self, @selector(lmMonitorMode));
    return [number unsignedIntegerValue];
}

- (void)setLmMonitorMode:(LMMonitorMode)lmMonitorMode {
    if (self.locationMonitorEnabled) {
        NSLog(@"2.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    NSNumber *number = [NSNumber numberWithUnsignedInteger:lmMonitorMode];
    objc_setAssociatedObject(self, @selector(lmMonitorMode), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LMHandlerType)lmHandlerType {
    NSNumber *number = objc_getAssociatedObject(self, @selector(lmHandlerType));
    return [number unsignedIntegerValue];
}

- (void)setLmHandlerType:(LMHandlerType)lmHandlerType {
    if (self.locationMonitorEnabled) {
        NSLog(@"3.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    NSNumber *number = [NSNumber numberWithUnsignedInteger:lmHandlerType];
    objc_setAssociatedObject(self, @selector(lmHandlerType), number, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMEnterRegionHandler)lmEntryRegionHandler {
    return objc_getAssociatedObject(self, @selector(lmEntryRegionHandler));
}

- (void)setLmEntryRegionHandler:(LMEnterRegionHandler)lmEntryRegionHandler {
    if (self.locationMonitorEnabled) {
        NSLog(@"4.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmEntryRegionHandler), lmEntryRegionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LMExitRegionHandler)lmExitRegionHandler {
    return objc_getAssociatedObject(self, @selector(lmExitRegionHandler));
}

- (void)setLmExitRegionHandler:(LMExitRegionHandler)lmExitRegionHandler {
    if (self.locationMonitorEnabled) {
        NSLog(@"5.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmExitRegionHandler), lmExitRegionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILocalNotification *)lmEntryRegionNotification {
    return objc_getAssociatedObject(self, @selector(lmEntryRegionNotification));
}

- (void)setLmEntryRegionNotification:(UILocalNotification *)lmEntryRegionNotification {
    if (self.locationMonitorEnabled) {
        NSLog(@"6.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmEntryRegionNotification), lmEntryRegionNotification, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UILocalNotification *)lmExitRegionNotification {
    return objc_getAssociatedObject(self, @selector(lmExitRegionNotification));
}

- (void)setLmExitRegionNotification:(UILocalNotification *)lmExitRegionNotification {
    if (self.locationMonitorEnabled) {
        NSLog(@"7.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmExitRegionNotification), lmExitRegionNotification, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableSet *)lmRegionsToMonitor {
    return objc_getAssociatedObject(self, @selector(lmRegionsToMonitor));
}

- (void)setLmRegionsToMonitor:(NSMutableSet *)lmRegionsToMonitor {
    if (self.locationMonitorEnabled) {
        NSLog(@"8.DISABLE LocationMonitor before making changes to properties");
        return;
    }

    objc_setAssociatedObject(self, @selector(lmRegionsToMonitor), lmRegionsToMonitor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)locationMonitorEnabled {
    NSNumber *number = objc_getAssociatedObject(self, @selector(locationMonitorEnabled));
    return [number boolValue];
}

//- (void)setLocationMonitorEnabled:(BOOL)locationMonitorEnabled {
//    NSAssert(YES, @"DO NOT use setter for locationMonitorEnabled property. It is supposed to be readonly.\n use - enableLocationMonitor/disableLocationMonitor instead");
//}

- (UIBackgroundTaskIdentifier)getBackgroundTaskIdentifier {
    NSNumber *number = objc_getAssociatedObject(self, &LMBackgroundTaskKey);
    return [number unsignedIntegerValue];
}

- (void)setBackgroundTaskIdentifier:(UIBackgroundTaskIdentifier)identifier {
    NSNumber *number = [NSNumber numberWithUnsignedInteger:identifier];
    objc_setAssociatedObject(self, &LMBackgroundTaskKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)getFirstTimeStateCount {
    NSNumber *number = objc_getAssociatedObject(self, &LMFirstTimeStateCount);
    return [number integerValue];
}

- (void)setFirstTimeStateCount:(NSInteger)count {
    NSNumber *number = [NSNumber numberWithInteger:count];
    objc_setAssociatedObject(self, &LMFirstTimeStateCount, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Add Monitoring Locations

- (BOOL)addMonitoringLocationsDictionary:(NSDictionary *)locations
                        monitoringRadius:(CGFloat)radius {
    BOOL hasLocation = NO;
    for (NSString* key in locations.allKeys) {
        id content = [locations objectForKey:key];
        if ([content isKindOfClass:[CLLocation class]]) {
            hasLocation = YES;
            CLLocation *location = (CLLocation *)content;
            [self addMonitoringLocation:location
                       monitoringRadius:radius
                             identifier:key];
        }
    }

    if (!hasLocation) {
        NSLog(@"ERROR_BGLocationMonitor_ \"addMonitoringLocationsDictionary:\" parameter has NO CLLocation instance");
    }
    return hasLocation;
}

- (BOOL)addMonitoringLocation:(CLLocation *)location
             monitoringRadius:(CGFloat)radius
                   identifier:(NSString *)identifier {
    BOOL isLocation = NO;
    if ([location isKindOfClass:[CLLocation class]]) {
        isLocation = YES;
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:location.coordinate
                                                                   radius:radius
                                                               identifier:identifier];
        [self addMonitoringRegion:region];
    }

    if (!isLocation) {
        NSLog(@"ERROR_BGLocationMonitor_ \"addMonitoringLocationsDictionary:\" parameter has NO CLLocation instance");
    }
    return isLocation;
}

- (BOOL)addMonitoringRegion:(CLRegion *)region {
    BOOL isRegion = NO;
    if ([region isKindOfClass:[CLRegion class]]) {
        isRegion = YES;
        region.notifyOnEntry = YES;
        region.notifyOnExit = YES;
        if (!self.lmRegionsToMonitor) {
            self.lmRegionsToMonitor = [NSMutableSet set];
        }
        [self.lmRegionsToMonitor addObject:region];
    }

    return isRegion;
}


#pragma mark - Monitor Control

- (void)enableLocationMonitor {
    [self.lmLocationManager requestAlwaysAuthorization];
    if (!objc_getAssociatedObject(self, &LMBackgroundQueueKey)) {
        dispatch_queue_t lmBackgroundQueue = dispatch_queue_create(LMBACKGROUNDQUEUELABEL, DISPATCH_QUEUE_SERIAL);
        objc_setAssociatedObject(self, &LMBackgroundQueueKey, lmBackgroundQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (!objc_getAssociatedObject(self, &LMBackgroundTaskKey)) {
        [self setBackgroundTaskIdentifier:UIBackgroundTaskInvalid];
    }
    if (!objc_getAssociatedObject(self, &LMFirstTimeStateCount)) {
        [self setFirstTimeStateCount:-1];
    }
    if ((self.lmHandlerType&LMHandlerTypeNotificationOnEntry)>0) {
        if (!self.lmEntryRegionNotification) {
            [self makeDefaultEntryNotification];
        }
    }
    if ((self.lmHandlerType&LMHandlerTypeNotificationOnExit)>0) {
        if (!self.lmExitRegionNotification) {
            [self makeDefaultExitNotification];
        }
    }

    UIApplicationState applicationState = [UIApplication sharedApplication].applicationState;
    if (applicationState==UIApplicationStateBackground) {
        if ((self.lmMonitorMode&LMMonitorModeBackground)>0) {
            [self startMonitoring];
        }
    } else if (applicationState==UIApplicationStateActive) {
        if ((self.lmMonitorMode&LMMonitorModeForeground)>0) {
            [self startMonitoring];
        }
    }

    NSNumber *number = [NSNumber numberWithBool:YES];
    objc_setAssociatedObject(self, @selector(locationMonitorEnabled), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)disableLocationMonitor {
    [self stopMonitoring];

    NSNumber *number = [NSNumber numberWithBool:NO];
    objc_setAssociatedObject(self, @selector(locationMonitorEnabled), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)startMonitoring {
    UIBackgroundTaskIdentifier lmBackgroundTask = [self getBackgroundTaskIdentifier];
    if (lmBackgroundTask != UIBackgroundTaskInvalid) {
        return;
    }
    lmBackgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:lmBackgroundTask];
        [self setBackgroundTaskIdentifier:UIBackgroundTaskInvalid];
    }];

    dispatch_async(objc_getAssociatedObject(self, &LMBackgroundQueueKey), ^{
        if ((![CLLocationManager locationServicesEnabled])||([CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedAlways)) {
            NSLog(@"LocationMonitor locationService NOT enable or has NO authorization");
            return;
        }

        NSLog(@"LocationMonitor StartMonitoring");

        if ([self.lmRegionsToMonitor count]>0) {
            for (CLRegion *region in self.lmRegionsToMonitor) {
                [self.lmLocationManager startMonitoringForRegion:region];
            }
        }
    });
}

- (void)stopMonitoring {
    if (!objc_getAssociatedObject(self, &LMBackgroundQueueKey)) {
        return;
    }
    dispatch_async(objc_getAssociatedObject(self, &LMBackgroundQueueKey), ^{
        NSLog(@"LocationMonitor StopMonitoring");

        if ([self.lmRegionsToMonitor count]>0) {
            for (CLRegion *region in self.lmRegionsToMonitor) {
                [self.lmLocationManager stopMonitoringForRegion:region];
            }
        }
    });
}


#pragma mark - Method Swizzling

void swizzleMethod_LocationMonitor(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzled_applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"LocationMonitor DidEnterBackground");

    if (self.locationMonitorEnabled) {
        if ((self.lmMonitorMode&LMMonitorModeBackground)>0) {
            [self startMonitoring];
        } else {
            [self stopMonitoring];
        }
    }

    [self swizzled_applicationDidEnterBackground:application];
}

- (void)swizzled_applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"LocationMonitor WillEnterForeground");

    UIBackgroundTaskIdentifier lmBackgroundTask = [self getBackgroundTaskIdentifier];
    if (lmBackgroundTask != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:lmBackgroundTask];
        [self setBackgroundTaskIdentifier:UIBackgroundTaskInvalid];;
    }

    if (self.locationMonitorEnabled) {
        if ((self.lmMonitorMode&LMMonitorModeForeground)>0) {
            [self startMonitoring];
        } else {
            [self stopMonitoring];
        }
    }

    [self swizzled_applicationWillEnterForeground:application];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod_LocationMonitor([self class], @selector(applicationDidEnterBackground:), @selector(swizzled_applicationDidEnterBackground:));
        swizzleMethod_LocationMonitor([self class], @selector(applicationWillEnterForeground:), @selector(swizzled_applicationWillEnterForeground:));
    });
}


#pragma mark - Location Manager Delegate

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    if (![self.lmRegionsToMonitor containsObject:region]) {
        NSLog(@"LocationMonitor RegionMonitored NOT in Set");
        return;
    }

    [self setFirstTimeStateCount:0];
    [manager requestStateForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSInteger count = [self getFirstTimeStateCount];
    if (count<0) {
        return;
    }

    switch (state) {
        case CLRegionStateInside:
            NSLog(@"LocationMonitor %@ RegionState:inside", region.identifier);
            break;
        case CLRegionStateOutside:
            NSLog(@"LocationMonitor %@ RegionState:outside", region.identifier);
            break;
        case CLRegionStateUnknown:
            NSLog(@"LocationMonitor %@ RegionState:unknown", region.identifier);
            break;
        default:
            NSLog(@"LocationMonitor %@ RegionState:error", region.identifier);
            break;
    }

    count++;
    if (count>=[self.lmRegionsToMonitor count]) {
        UIBackgroundTaskIdentifier lmBackgroundTask = [self getBackgroundTaskIdentifier];
        [[UIApplication sharedApplication] endBackgroundTask:lmBackgroundTask];
        [self setBackgroundTaskIdentifier:UIBackgroundTaskInvalid];
        [self setFirstTimeStateCount:-1];
    } else {
        [self setFirstTimeStateCount:count];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ((self.lmHandlerType&LMHandlerTypeNotificationOnEntry)>0) {
        NSLog(@"LocationMonitor %@ Entry", region.identifier);
        self.lmEntryRegionNotification.fireDate = [NSDate date];
        self.lmEntryRegionNotification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        self.lmEntryRegionNotification.alertBody = [NSString stringWithFormat:@"Enter %@", region.identifier];
        [[UIApplication sharedApplication] scheduleLocalNotification:self.lmEntryRegionNotification];
    }
    if ((self.lmHandlerType&LMHandlerTypeBlockOnEntry)>0) {
        if (self.lmEntryRegionHandler) {
            if ([region isMemberOfClass:[CLCircularRegion class]]) {
                CLCircularRegion *circularRegion = (CLCircularRegion *)region;
                CLLocation *location = [[CLLocation alloc] initWithLatitude:circularRegion.center.latitude
                                                                  longitude:circularRegion.center.longitude];
                self.lmEntryRegionHandler(location, circularRegion.identifier);
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ((self.lmHandlerType&LMHandlerTypeNotificationOnExit)>0) {
        NSLog(@"LocationMonitor %@ Exit", region.identifier);
        self.lmExitRegionNotification.fireDate = [NSDate date];
        self.lmExitRegionNotification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
        self.lmExitRegionNotification.alertBody = [NSString stringWithFormat:@"Exit %@", region.identifier];
        [[UIApplication sharedApplication] scheduleLocalNotification:self.lmExitRegionNotification];
    }
    if ((self.lmHandlerType&LMHandlerTypeBlockOnExit)>0) {
        if (self.lmExitRegionHandler) {
            if ([region isMemberOfClass:[CLCircularRegion class]]) {
                CLCircularRegion *circularRegion = (CLCircularRegion *)region;
                CLLocation *location = [[CLLocation alloc] initWithLatitude:circularRegion.center.latitude
                                                                  longitude:circularRegion.center.longitude];
                self.lmExitRegionHandler(location, circularRegion.identifier);
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"LocationMonitor %@ Fail", region.identifier);
    NSLog(@"%@", error);
}

@end
