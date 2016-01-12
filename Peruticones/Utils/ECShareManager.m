//
//  ECShareManager.m
//  ClubSuscriptores
//
//  Created by RLoza on 10/28/14.
//  Copyright (c) 2014 Empresa Editora El Comercio. All rights reserved.
//

#import "ECShareManager.h"
#import "Constants.h"
#import "ECAsyncTaskQueue.h"
#import "NSString+Utils.h"
#import "UIAlertViewUsingBlock.h"
#import "PoliticonesCollectionVC.h"

#import <GoogleAnalyticsServices/GAIFields.h>
#import <GoogleAnalyticsServices/GAI.h>
#import <GoogleAnalyticsServices/GAIDictionaryBuilder.h>
#import <Flurry/Flurry.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>


@interface ECShareManager()

@end

@implementation ECShareManager

#pragma mark - Life Cicle

+ (ECShareManager *)shared {
    
    static ECShareManager *_shared = nil;
    
    if (!_shared) {
        
        _shared = [[super allocWithZone:nil] init];
    }
    
    return _shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    return [ECShareManager shared];
}

#pragma mark - Google Analytics Tracking

+ (void)GACreateTracker {
    
    [[GAI sharedInstance] setOptOut:NO];
    // Initialize Google Analytics with a 120-second dispatch interval. There is a
    // tradeoff between battery usage and timely dispatch. if not positive-second information must be sent manually by calling dispatch
    [[GAI sharedInstance] setDispatchInterval:-1.0];
    [[GAI sharedInstance] setTrackUncaughtExceptions:NO];
    [[GAI sharedInstance] setDryRun:NO];
    [[GAI sharedInstance] setOptOut:NO];
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelNone];
    
    
    [self shared].tracker = [[GAI sharedInstance] trackerWithName:kEC_GA_TrackerWithName
                                                        trackingId:kEC_GA_Tracking_ID];
    [[self shared].tracker setAllowIDFACollection:NO];
    
    // Send hits using HTTP (default=HTTPS).
    
    [[self shared].tracker set:kGAIUseSecure value:@"0"];
    
//    NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
//    formatterDate.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_PE"];
//    formatterDate.dateStyle = NSDateFormatterLongStyle;
//    formatterDate.timeStyle = NSDateFormatterLongStyle;
//    [formatterDate stringFromDate:[NSDate date]]
    
    NSString *sCurrentLocalDate = [NSString stringByCurrentLocalDate];
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:@"Session" action:@"start" label:sCurrentLocalDate value:nil];
    
    [builder set:@"start" forKey:kGAISessionControl];
//    [[self shared].tracker set:kGAIScreenName value:@"Home"];
    
    [[self shared].tracker send:[builder build]];
    
    GAIDictionaryBuilder *builderScreen = [GAIDictionaryBuilder createScreenView];
    [[self shared].tracker set:kGAIScreenName value:@"Home"];
    [[self shared].tracker send:[builderScreen build]];
    
    [self GADispatchTracking];
}

+ (void)GATrackingWithCategory:(NSString *)category
                              action:(NSString *)action
                               label:(NSString *)label {
    
    AppDebugECLog(@"category : %@, action : %@, label : %@", category, action, label);
    
    NSMutableDictionary *event =
    [[GAIDictionaryBuilder createEventWithCategory:category
                                            action:action
                                             label:label
                                             value:nil] build];
    [[[GAI sharedInstance] defaultTracker] send:event];
    
    [self GADispatchTracking];
}

+ (void)GATrackingScreenName:(NSString *)ScreenName {
    
    AppDebugECLog(@"GAScreenName : %@", ScreenName);
    
    GAIDictionaryBuilder *builderScreen = [GAIDictionaryBuilder createScreenView];
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:ScreenName];
    [[[GAI sharedInstance] defaultTracker] send:[builderScreen build]];
    
    [self GADispatchTracking];
}

+ (void)GADispatchTracking {
    
    dispatch_async([[ECAsyncTaskQueue shared] task_queue_serial], ^{
        
        [[GAI sharedInstance] dispatch];
    });
}

#pragma mark - Facebook Analytics

//+ (void)FBactivateApp {
//    
//    NSString *facebookAppID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"FacebookAppID"];
//    
//    [FBSettings setDefaultAppID:facebookAppID];
//    
//    // Logs 'install' and 'app activate' App Events.
//    [FBAppEvents activateApp];
//}

#pragma mark - Flurry Analytics

+ (void)FlurryLogEvent:(NSString *)event {
    
    AppDebugECLog(@"Flurry : %@", event);
    dispatch_async([[ECAsyncTaskQueue shared] task_queue_serial], ^{
       
        [Flurry logEvent:event];
    });
}

+ (void)startFlurrySessionWithApiKey:(NSString *)apiKey event:(NSString *)event {
    
    //Step 1: This should be done before you start session
    [Flurry setCrashReportingEnabled:YES];
    [Flurry startSession:apiKey];
    
    [Flurry setDebugLogEnabled:NO];
    [Flurry setLogLevel:FlurryLogLevelNone];
    [Flurry setSessionReportsOnCloseEnabled:YES];
    [Flurry setSessionReportsOnPauseEnabled:YES];
    
    [Flurry setEventLoggingEnabled:YES];
    UIDevice *device = [UIDevice currentDevice];
    
    NSString *identifier = [device name];
    
    [Flurry setUserID:identifier];
    
    [Flurry logEvent:event
      withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[device systemVersion], @"OS", nil]
               timed:YES];
}

+ (void)endFlurrySessionEvent:(NSString *)event {
    
    UIDevice *device = [UIDevice currentDevice];
    [Flurry endTimedEvent:event withParameters:[NSDictionary dictionaryWithObjectsAndKeys:[device systemVersion], @"OS", nil]];
}

#pragma mark - Share

+ (void)sendEmailTo:(NSString *)to withSubject:(NSString *)subject image:(UIImage *)image mimeType:(NSString *)mimeType body:(NSString *)body inControllerView:(UIViewController<MFMailComposeViewControllerDelegate> __weak *)inControllerView {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController* mailVC = [[MFMailComposeViewController alloc] init];
        
        if (mailVC) {
            
            mailVC.mailComposeDelegate = inControllerView;
            
            if (body.length > 0)
                [mailVC setMessageBody:body isHTML:YES];
            
            [mailVC setSubject:subject];
            [mailVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
            
            NSData *imgData = UIImagePNGRepresentation(image);

            [mailVC addAttachmentData:imgData mimeType:mimeType fileName:@"peruticon.png"];
//            [mailVC addAttachmentData:imgData mimeType:@"image/png" fileName:@"peruticon.png"];
            
            [inControllerView presentViewController:mailVC animated:YES completion:nil];
        }
    }
    else {
        
        [[UIAlertViewUsingBlock alertViewWithTitle:@"" message:NSLocalizedString(@"TextEmailSettings", @"") cancelButtonTitle:NSLocalizedString(@"TextButtonCancel", @"") otherButtonTitles:[NSArray arrayWithObject:NSLocalizedString(@"TextButtonSettings", @"")] onDismiss:^(NSInteger buttonIndex) {
            
            switch (buttonIndex) {
                case 1:
                    
                    // Settings Email
                    [[UIApplication sharedApplication] openURL:
                     [NSURL URLWithString:@"mailto:me@example.com?subject=subject&body=body"
                      ]];
                    
                    break;
                    
                default:
                    break;
            }
            
            if ([inControllerView isKindOfClass:[PoliticonesCollectionVC class]]) {
                
                [(PoliticonesCollectionVC *)inControllerView hideShareView];
            }
            
        }] show];
    }
}

// abre la interfaz nativa para publicar un mensaje en twitter
+ (void)publishInSocialServiceType:(NSString *)serviceType
                    withSharedImage:(UIImage *)imagem url:(NSURL *)url text:(NSString *)text
                    viewController:(UIViewController *)controller
{
    SLComposeViewController *socialServiceVC = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    
    SLComposeViewControllerCompletionHandler completionHandler = ^(SLComposeViewControllerResult result)
    {
        [controller dismissViewControllerAnimated:NO completion:^{
           
            if ([controller isKindOfClass:[PoliticonesCollectionVC class]]) {
                
                [(PoliticonesCollectionVC *)controller hideShareView];
            }
        }];
    };
    
    if (text.length > 0) [socialServiceVC setInitialText:text];
    
    if (imagem) [socialServiceVC addImage:imagem];
    
    if (url) [socialServiceVC addURL:url];
    
    [socialServiceVC setCompletionHandler:completionHandler];
    
    [controller presentViewController:socialServiceVC animated:YES completion:nil];
}

+ (void)shareViaFacebookWithImage:(UIImage *)image url:(NSURL *)url text:(NSString *)text inViewController:(__weak UIViewController *)controller {
    
    [self publishInSocialServiceType:SLServiceTypeFacebook withSharedImage:image url:url text:text viewController:controller];
}

+ (void)shareViaTwitterWithImage:(UIImage *)image url:(NSURL *)url text:(NSString *)text inViewController:(__weak UIViewController *)controller {
    
    [self publishInSocialServiceType:SLServiceTypeTwitter withSharedImage:image url:url text:text viewController:controller];
}

+ (void)shareViaWhatsAppWithType:(NSString *)type file:(NSURL *)fileUrl text:(NSString *)text inControllerView:(UIViewController<UIDocumentInteractionControllerDelegate> __weak *) inControllerView {
    
    if ([[UIApplication sharedApplication] canOpenURL:
         [NSURL URLWithString:@"whatsapp://send?text=Hello"]]) {
        
        [self presentDocumentInteractionWithFileUrl:fileUrl type:kTypeMediaWhatsappImage inControllerView:inControllerView];
    }
    else {
        
        [[UIAlertViewUsingBlock alertViewWithTitle:@""
                                           message:NSLocalizedString(@"TextShareNoWhatsapp", nil)
                                 cancelButtonTitle:NSLocalizedString(@"TextButtonAccept", nil)
                                 otherButtonTitles:nil
                                         onDismiss:^(NSInteger buttonIndex) {
                                             
                                             if ([inControllerView isKindOfClass:[PoliticonesCollectionVC class]]) {
                                                 
                                                 [(PoliticonesCollectionVC *)inControllerView hideShareView];
                                             }
                                         }] show];
    }
}

+ (void)shareViaEmailWithImage:(UIImage *)image mimeType:(NSString *)mimeType text:(NSString *)text inControllerView:(UIViewController<MFMailComposeViewControllerDelegate> __weak *)inControllerView {
    
    NSString *subject = NSLocalizedString(@"TextAppTitle", nil);
    
    NSString *body = (text.length > 0 ? [[NSString alloc] initWithFormat:@"<p>%@</p>",
                                         text] : nil);
    
    [self sendEmailTo:@"me@example.com" withSubject:subject image:image mimeType:mimeType body:body inControllerView:inControllerView];
}

+ (void)presentDocumentInteractionWithFileUrl:(NSURL *)fileUrl type:(NSString *)type inControllerView:(UIViewController<UIDocumentInteractionControllerDelegate> __weak *) inControllerView {
    
    __weak ECShareManager *weakSelf = [self shared];
    
    weakSelf.documentInteractionController =[UIDocumentInteractionController interactionControllerWithURL:fileUrl];
    
    weakSelf.documentInteractionController.delegate = inControllerView;
    
    if ([type rangeOfString:kTypeMediaWhatsappImage].location != NSNotFound) {
        
        weakSelf.documentInteractionController.UTI = @"net.whatsapp.image";
        
    }
    else if ([type rangeOfString:kTypeMediaWhatsappMovie].location != NSNotFound) {
        
        weakSelf.documentInteractionController.UTI = @"net.whatsapp.movie";
        
    }
    
    [weakSelf.documentInteractionController presentOpenInMenuFromRect:CGRectZero
                                                                   inView:inControllerView.view
                                                                 animated:YES];
}

+ (void)FBMessengerSharerGif:(NSString *)pathFile {
    
    NSData *gifData = [NSData dataWithContentsOfFile:pathFile];
    
    FBSDKMessengerShareOptions *ops = [[FBSDKMessengerShareOptions alloc] init];
    ops.renderAsSticker = NO;
    
    [FBSDKMessengerSharer shareAnimatedGIF:gifData withOptions:ops];
}

@end
