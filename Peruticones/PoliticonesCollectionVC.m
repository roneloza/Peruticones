//
//  PoliticonesCollectionViewController.m
//  Peruticones
//
//  Created by RLoza on 11/26/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import "PoliticonesCollectionVC.h"
#import "EmoticonCollectionViewCell.h"
#import "Constants.h"
#import "ECShareManager.h"
#import "Emoticon.h"
#import "ShareOption.h"
#import "ActivityItemProvider.h"
#import "ShareModalView.h"
#import "ShareTableViewCell.h"
#import "MessengerActivity.h"
#import "NSString+Utils.h"

#import <MessageUI/MessageUI.h>
#import <FBSDKMessengerShareKit/FBSDKMessengerShareKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

#import "SetupKeyboardViewController.h"

#define kEmoticonCell @"EmoticonCell"
#define kShareTableViewCell @"ShareTableViewCell"

@interface PoliticonesCollectionVC ()<UIDocumentInteractionControllerDelegate, MFMailComposeViewControllerDelegate, FBSDKSharingDelegate , UIScrollViewDelegate>

@property (nonatomic, strong) UIActivityViewController *activityViewController;
@property (nonatomic, weak) Emoticon *selectedEmoticon;
@property (nonatomic, strong) NSURL *tempFileURL;

@end

@implementation PoliticonesCollectionVC

- (void)presentShareActivityViewControllerWithEmoticon:(Emoticon *)emoticon {
    
    __weak PoliticonesCollectionVC *wkself = self;
    
    ItemProvider *itemProvider = [[ItemProvider alloc] initWithItem:emoticon];
    
    ActivityItemProvider *activityItemProvider = [[ActivityItemProvider alloc] initWithItem:itemProvider];
    
    NSArray *activityItems = [[NSArray alloc] initWithObjects:activityItemProvider, nil];
    
    MessengerActivity *FBMSGActivity = [[MessengerActivity alloc] init];
    NSArray *applicationActivities = [[NSArray alloc] initWithObjects:FBMSGActivity, nil];
    wkself.activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:applicationActivities];
    
    [wkself presentViewController:wkself.activityViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    __weak PoliticonesCollectionVC *wkself = self;
    
    wkself.data = [Emoticon getAllEmoticons];
    wkself.shareOptions = [ShareOption getAllShareOptions];
    
    [wkself.shareModalView.tableView registerNib:[UINib nibWithNibName:kShareTableViewCell bundle:nil] forCellReuseIdentifier:kShareTableViewCell];
    
    wkself.shareModalView.tableView.delegate = wkself;
    wkself.shareModalView.tableView.dataSource = wkself;
    wkself.shareModalView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [wkself hideShareView];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        if ([wkself isInstalledKeyboard]) {
//            
//            [wkself performSegueWithIdentifier:kSegueSetupKeyboard sender:nil];
//        }
//    });
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.keyboardButton.hidden = [self isInstalledKeyboard];
}

- (BOOL)isInstalledKeyboard {
    
    NSArray *keyboards = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleKeyboards"];
    
    // check for your keyboard
    
    NSUInteger index = [keyboards indexOfObject:@"com.eeec.Peruticones.Keyboard"];
    
    return (index != NSNotFound);
}

- (IBAction)keyboardButtonTouch:(UIButton *)sender {
    
    [self performSegueWithIdentifier:kSegueSetupKeyboard sender:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.collectionView.contentInset = UIEdgeInsetsZero;
    
    /// TAG : INICIO
    [ECShareManager GATrackingScreenName:kTrackingScreenHome];
    
    NSString *event = [[NSString alloc] initWithFormat:@"%@,%@",kTrackingScreen,
                       kTrackingScreenHome];
    
    [ECShareManager FlurryLogEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>,<UICollectionViewDelegate>

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGSize) collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    CGRect screen_size = self.view.bounds;
    CGFloat screenWidth = screen_size.size.width;
    
    CGSize row_size = [(UICollectionViewFlowLayout*)collectionViewLayout itemSize];
    
    row_size.width = (screenWidth/2);
    row_size.height = (screenWidth/2);
    
    return row_size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmoticonCollectionViewCell *cell = (EmoticonCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kEmoticonCell forIndexPath:indexPath];
    
    [cell layoutIfNeeded];
    
    __weak Emoticon *emoticon = [self.data objectAtIndex:indexPath.item];
    
    NSString *fileName = (emoticon.png.length > 0 ? emoticon.png : emoticon.gif);
    
    NSString *pathFile = pathForResource(kBundleImages, fileName);
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    
    cell.emoticonImageView.image = image;
    
    cell.backgroundColor = UIColorFromRGB(0xE9E6DF);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak Emoticon *emoticon = [self.data objectAtIndex:indexPath.item];

    self.selectedEmoticon = emoticon;

    /// TAG : Seleccion,[Personaje],[fecha]
    
    NSString *sCurrentLocalDate = [NSString stringByCurrentLocalDate];
    
    [ECShareManager GATrackingWithCategory:kTrackingCategorySelect action:[emoticon.title uppercaseString] label:sCurrentLocalDate];
    
    NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategorySelect, [emoticon.title uppercaseString], sCurrentLocalDate];
    
    [ECShareManager FlurryLogEvent:event];
    
    [self showShareView];
}

#pragma mark <UITableViewDataSource>,<UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.shareOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShareTableViewCell forIndexPath:indexPath];
    
    __weak ShareOption *option = [self.shareOptions objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = option.title;
    
    NSString *pathFile = pathForResource(kBundleImages, option.img);
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    cell.imageView.image = image;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak PoliticonesCollectionVC *wkself = self;
    
    __weak ShareOption *option = [wkself.shareOptions objectAtIndex:indexPath.row];
    
    NSString *activityType = nil;
    
    switch (option.shareOptionType) {
        
        case ShareOptionTypeFacebook:
        {
            activityType = NSLocalizedString(@"TextFacebook", nil);
            
            BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://"]];
            
            NSString *pathFile = pathForResource(kBundleImages, wkself.selectedEmoticon.facebook);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
            
            if (isInstalled) {
                
                FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
                photo.image = image;
                photo.userGenerated = YES;
                
                FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
                content.photos = [[NSArray alloc] initWithObjects:photo, nil];
                
                [FBSDKShareDialog showFromViewController:wkself
                                             withContent:content
                                                delegate:wkself];
            }
            else {
             
                [ECShareManager shareViaFacebookWithImage:image url:nil text:nil
                                         inViewController:wkself];
            }
        }
            break;
        case ShareOptionTypeTwitter:
        {
            activityType = NSLocalizedString(@"TextTwitter", nil);
            
            NSString *pathFile = pathForResource(kBundleImages, wkself.selectedEmoticon.twitter);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
            
            [ECShareManager shareViaTwitterWithImage:image url:nil text:nil
                                    inViewController:wkself];
        }
            break;
        case ShareOptionTypeMessenger:
        {
         
            activityType = NSLocalizedString(@"TextMessenger", nil);
            
            NSString *pathFileGif = pathForResource(kBundleImages, wkself.selectedEmoticon.gif);
            
            [ECShareManager FBMessengerSharerGif:pathFileGif];
            
            [wkself hideShareView];
        }
            break;
        case ShareOptionTypeWhatsapp:
        {
            activityType = NSLocalizedString(@"TextWhatsapp", nil);
            
            NSString *pathFile = pathForResource(kBundleImages, wkself.selectedEmoticon.whatsapp);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
            
            NSString *waiFileName = [wkself.selectedEmoticon.png stringByAppendingPathExtension:kTypeMediaWhatsappImage];
            
            NSString *tempFilePath = [kECCachePathToCacheTemp stringByAppendingPathComponent:waiFileName];
            
            NSData *imageData = UIImagePNGRepresentation(image);
            
            createFilePathWithData(imageData, tempFilePath);
            
            NSURL *fileUrl = [[NSURL alloc] initFileURLWithPath:tempFilePath];
            
            wkself.tempFileURL = fileUrl;
            
            [ECShareManager shareViaWhatsAppWithType:kTypeMediaWhatsappImage file:fileUrl text:nil inControllerView:wkself];
        }
            break;
        case ShareOptionTypeMail:
        {
            activityType = NSLocalizedString(@"TextMail", nil);
            
            NSString *pathFile = pathForResource(kBundleImages, wkself.selectedEmoticon.png);
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
            
            [ECShareManager shareViaEmailWithImage:image mimeType:@"image/png" text:nil inControllerView:wkself];
        }
            break;
        default:
            break;
    }
    
    /// TAG : (Compartir, [red-social-que-comparte],[Personaje])
    
    [ECShareManager GATrackingWithCategory:kTrackingCategoryShare action:activityType label:wkself.selectedEmoticon.title];
    
    NSString *event = [[NSString alloc] initWithFormat:@"%@,%@,%@", kTrackingCategoryShare, activityType, wkself.selectedEmoticon.title];
    
    [ECShareManager FlurryLogEvent:event];
}

#pragma mark - IBActions

- (IBAction)maskButtonTouch:(UIButton *)sender {
    
    [self hideShareView];
}

- (void)hideShareView {
    
    [self.shareModalView.tableView deselectRowAtIndexPath:self.shareModalView.tableView.indexPathForSelectedRow animated:NO];
    self.shareModalView.hidden = YES;
    self.maskButton.hidden = YES;
}

- (void)showShareView {
    
    self.shareModalView.hidden = NO;
    self.maskButton.hidden = NO;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:self.tempFileURL.path error:&error];
}

- (void)documentInteractionControllerDidDismissOpenInMenu:(UIDocumentInteractionController *)controller {
    
    [self hideShareView];
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    controller.mailComposeDelegate = nil;
    
    [self hideShareView];
}

#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    
    [self hideShareView];
    [sharer setDelegate:nil];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    
    [self hideShareView];
    [sharer setDelegate:nil];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    
    [self hideShareView];
    [sharer setDelegate:nil];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

@end
