//
//  TromeActivityItemProvider.m
//  TromeEnterate
//
//  Created by RLoza on 9/23/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//



#import "ActivityItemProvider.h"
#import "ECShareManager.h"
#import "NSString+Utils.h"
#import "Constants.h"
#import "Emoticon.h"


//com.apple.UIKit.activity.PostToFacebook
//com.facebook.Facebook.ShareExtension

@implementation ItemProvider

- (id)initWithItem:(Emoticon *)emoticon {
    
    if ((self = [super init])) {
        
        _emoticon = emoticon;
    }
    
    return self;
}

@end


@implementation ActivityItemProvider

#define kShareExtensionFbApp @"facebook"
#define kShareExtensionTwApp @"tweetie"
#define kShareExtensionWsApp @"whatsapp"

- (id)activityViewController:(UIActivityViewController *)activityViewController
         itemForActivityType:(NSString *)activityType {
    
    /// TAG : (Compartir, [red-social-que-comparte],[Nombre de la sección]/[Personaje])
    
    __weak ItemProvider *item = (ItemProvider *)self.placeholderItem;
    
    __weak Emoticon *emoticon = item.emoticon;
    
    [ECShareManager GATrackingWithCategory:kTrackingCategoryShare action:activityType label:emoticon.title];
    
    NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategoryShare, activityType, emoticon.title];
    
    [ECShareManager FlurryLogEvent:event];
    
    
    NSString *fileName = emoticon.facebook;
    NSString *pathFile = pathForResource(kBundleImages, fileName);
    UIImage *image = nil;
    
    if ([activityType rangeOfString:kMessengerActivityType options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        pathFile = pathForResource(kBundleImages, emoticon.gif);
        [activityViewController dismissViewControllerAnimated:YES completion:nil];
        [ECShareManager FBMessengerSharerGif:pathFile];
        
        return nil;
    }
    else if ([activityType rangeOfString:kShareExtensionTwApp options:NSCaseInsensitiveSearch].location != NSNotFound || [activityType rangeOfString:UIActivityTypePostToTwitter options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        pathFile = pathForResource(kBundleImages, emoticon.twitter);
        image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    }
    else if ([activityType rangeOfString:kShareExtensionWsApp options:NSCaseInsensitiveSearch].location != NSNotFound) {
        
        pathFile = pathForResource(kBundleImages, emoticon.whatsapp);
        image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    }
    else {
        
//        ([activityType rangeOfString:kShareExtensionFbApp options:NSCaseInsensitiveSearch].location != NSNotFound || [activityType rangeOfString:UIActivityTypePostToFacebook options:NSCaseInsensitiveSearch].location != NSNotFound)
        
        pathFile = pathForResource(kBundleImages, emoticon.facebook);
        image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    }
    
    return image;
    
//    self.placeholderItem = [[NSArray alloc] initWithObjects:image, nil];
    
//    return self.placeholderItem;
}

- (id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController {

    __weak ItemProvider *item = (ItemProvider *)self.placeholderItem;
    
    __weak Emoticon *emoticon = item.emoticon;
    
    NSString *fileName = (emoticon.png.length > 0 ? emoticon.png : emoticon.gif);
    
    NSString *pathFile = pathForResource(kBundleImages, fileName);
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    
    return image;
}

- (id)initWithItem:(ActivityItemProvider *)item {

    self = [super initWithPlaceholderItem:item];
    
    return self;
}

@end
