//
//  Constants.h
//  El Comercio Emoticones
//
//  Created by RLoza on 11/21/15.
//  Copyright © 2015 Cristian Palomino. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//@interface Constants : NSObject
//
//@end

#pragma mark - Segue

#define kSetupKeyboardViewControllerID @"SetupKeyboardViewController"
#define kSegueSetupKeyboard @"segue_setupKeyboard"

#pragma mark - Constants

#define kFacebook @"facebook"
#define kTwitter @"twitter"
#define kWhatsapp @"whatsapp"
#define kMessengerActivityType @"trome.open.MessengerGif"

// Google Analytics
#define kEC_GA_Tracking_ID @"UA-62219903-16"
#define kEC_GA_TrackerWithName @"APP-Emoticonos–IOs"
#define kBundleImages @"images"

// Users Defaults
#define kUserNotFirstLaunch @"notFirstLaunch"

#pragma mark - Macros

#define AppendingPathToCacheDirectory(path) [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:path]

#define kECCacheFolderTemp @"temp"
#define kECCachePathToCacheTemp AppendingPathToCacheDirectory(kECCacheFolderTemp)


#define AppDebugECLog(s,...) NSLog(s, ##__VA_ARGS__)
//#define AppDebugECLog(s,...)

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, t) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:t]

#pragma mark - Functions

static inline NSBundle* resourcesBundle(NSString *bundle);
static inline NSString* pathForResource(NSString *bundle, NSString *fileName);
static inline dispatch_source_t CreateDispatchTimer(double interval, dispatch_queue_t queue, dispatch_block_t block);
static inline BOOL createDirectoryAtPath(NSString *path);
static inline BOOL createSymLinkAtPath(NSString *symLinkPath, NSString *sourcePath);
static inline BOOL createFilePathWithData(NSData *data, NSString *filePath);
static inline BOOL deleteFilePath(NSString *filePath);

////////

static inline NSString* pathForResource(NSString *bundle, NSString *fileName) {
    
    NSString *path = [resourcesBundle(bundle) pathForResource:fileName ofType:nil];
    
    return path;
}

static inline NSBundle* resourcesBundle(NSString *bundle) {
    
    NSString *imagesPathBundle = [[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"];
    
    NSBundle *imagesBundle = [NSBundle bundleWithPath:imagesPathBundle];
    
    return imagesBundle;
}

static inline dispatch_source_t CreateDispatchTimer(double interval, dispatch_queue_t queue, dispatch_block_t block) {
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    if (timer)
    {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    
    return timer;
}

static inline BOOL createDirectoryAtPath(NSString *path) {
    
    BOOL success = NO;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        
         success =  [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    }
    else {
        success = YES;
    }
    
    return success;
}

static inline BOOL createFilePathWithData(NSData *data, NSString *filePath) {
    
    if (data == nil || filePath.length < 1) {
        
        return NO;
    }
    
    BOOL success = NO;
    
    NSError *error = nil;
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
    }
    
    return success;
}

static inline BOOL deleteFilePath(NSString *filePath) {
    
    if (filePath.length < 1) {
        
        return NO;
    }
    
    BOOL success = NO;
    
    NSError *error = nil;
    
    success = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    
    return success;
}

static inline BOOL createSymLinkAtPath(NSString *symLinkPath, NSString *sourcePath) {

    BOOL success = createDirectoryAtPath(kECCachePathToCacheTemp);
    
    if (success) {
        
        NSError *error = nil;
        
        [[NSFileManager defaultManager] removeItemAtPath:symLinkPath error:&error];
        
        success = [[NSFileManager defaultManager] createSymbolicLinkAtPath:symLinkPath withDestinationPath:sourcePath error:&error];
    }
    
    return success;
}

static inline id UIStoryboardInstantiateViewControllerWithIdentifier(NSString *storyboarName, NSString *identifier)
{
    
    return [[UIStoryboard storyboardWithName:storyboarName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}

