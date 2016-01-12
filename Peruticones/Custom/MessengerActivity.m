//
//  MessengerActivity.m
//  Peruticones
//
//  Created by RLoza on 12/7/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "MessengerActivity.h"
#import "Constants.h"
#import "ECShareManager.h"

@implementation MessengerActivity

- (NSString *)activityType {
    
    return kMessengerActivityType;
}

- (NSString *)activityTitle {
    
    return @"Messenger GIF";
}

- (UIImage *)activityImage {

    // Note: These images need to have a transparent background and I recommend these sizes:
    // iPadShare@2x should be 126 px, iPadShare should be 53 px, iPhoneShare@2x should be 100
    // px, and iPhoneShare should be 50 px. I found these sizes to work for what I was making.
    
    NSString *fileName = @"fbmessenger-ico.png";
    NSString *pathFile = pathForResource(kBundleImages, fileName);
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    
    return image;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    
//    NSLog(@"%s", __FUNCTION__);
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
//    NSLog(@"%s",__FUNCTION__);
}

- (UIViewController *)activityViewController {
    
//    NSLog(@"%s",__FUNCTION__);
    return nil;
}

- (void)performActivity
{
    // This is where you can do anything you want, and is the whole reason for creating a custom
    // UIActivity
}
@end
