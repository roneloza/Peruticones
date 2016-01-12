//
//  AppDelegate.m
//  Peruticones
//
//  Created by RLoza on 11/26/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "ECShareManager.h"
#import "ECAsyncTaskQueue.h"
#import "NSString+Utils.h"
#import "Constants.h"
#import "PoliticonesCollectionVC.h"

@interface AppDelegate ()

@property (nonatomic, weak) UINavigationController *navigationController;
@end

@implementation AppDelegate
{
    dispatch_source_t _timer;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.navigationController = ([self.window.rootViewController isKindOfClass:[UINavigationController class]] ? (UINavigationController *)self.window.rootViewController : nil);
    
    createDirectoryAtPath(kECCachePathToCacheTemp);
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0f]];

    [ECShareManager GACreateTracker];
    [ECShareManager startFlurrySessionWithApiKey:kFlurryApiKey event:@"SESSION_START"];
    
    BOOL notUserFirstLaunch = [[NSUserDefaults standardUserDefaults]
                               boolForKey:kUserNotFirstLaunch];
    
    if (!notUserFirstLaunch) {
        
        //// TAG : (Instalaciones,Android,fecha)
        
        NSString *sCurrentLocalDate = [NSString stringByCurrentLocalDate];
        
        [ECShareManager GATrackingWithCategory:kTrackingCategoryFirstLaunch action:@"iOS" label:sCurrentLocalDate];
        
        NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategoryFirstLaunch, @"iOS", sCurrentLocalDate];
        
        [ECShareManager FlurryLogEvent:event];
    }
    
    //// TAG : (Arranques,Android,fecha)
    
    NSString *sCurrentLocalDate = [NSString stringByCurrentLocalDate];
    
    [ECShareManager GATrackingWithCategory:kTrackingCategoryDidLaunching action:@"iOS" label:sCurrentLocalDate];
    
    NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategoryDidLaunching, @"iOS", sCurrentLocalDate];
    
    [ECShareManager FlurryLogEvent:event];
    
    [self createTimerUserLimitTimeApp];
    
    return YES;
}

- (void)createTimerUserLimitTimeApp {
    
    //    double secondsToFire = 600.0f;
    
    double secondsToFire = 600.0f;
    
    _timer = CreateDispatchTimer(secondsToFire, [ECAsyncTaskQueue shared].task_queue_serial, ^{
        
        //// TAG : (Usuarios mas del limite,Android,fecha)
        
        NSString *sCurrentLocalDate = [NSString stringByCurrentLocalDate];
        
        [ECShareManager GATrackingWithCategory:kTrackingCategoryUserLimitTimeApp action:@"iOS" label:sCurrentLocalDate];
        
        NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategoryUserLimitTimeApp, @"iOS", sCurrentLocalDate];
        
        [ECShareManager FlurryLogEvent:event];
    });
}

- (void)startTimerUserLimitTimeApp {
    
    if (_timer) {
        
        dispatch_resume(_timer);
    }
}

- (void)cancelTimerUserLimitTimeApp {
    
    if (_timer) {
        
        dispatch_suspend(_timer);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self cancelTimerUserLimitTimeApp];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    __weak UIViewController *topVC = self.navigationController.topViewController;
    
    if ([topVC isKindOfClass:[PoliticonesCollectionVC class]]) {
        
        ((PoliticonesCollectionVC *)topVC).keyboardButton.hidden = [((PoliticonesCollectionVC *)topVC) isInstalledKeyboard];
    }
    
    [self startTimerUserLimitTimeApp];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    deleteFilePath(kECCachePathToCacheTemp);
    
    BOOL notUserFirstLaunch = [[NSUserDefaults standardUserDefaults]
                               boolForKey:kUserNotFirstLaunch];
    
    if (!notUserFirstLaunch) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserNotFirstLaunch];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [ECShareManager endFlurrySessionEvent:@"SESSION_START"];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
