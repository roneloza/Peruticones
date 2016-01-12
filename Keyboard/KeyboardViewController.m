//
//  KeyboardViewController.m
//  Keyboard
//
//  Created by RLoza on 1/7/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardView.h"
#import "KeyboardCollectionViewCell.h"
#import "Emoticon.h"
#import "FLAnimatedImage.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Constants.h"

@interface KeyboardViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton *nextKeyboardButton;
@property (nonatomic, strong) KeyboardView *keyboardView;

@property (nonatomic, assign) NSInteger selectedRow;
@end

@implementation KeyboardViewController

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    // Add custom view sizing constraints here
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectedRow = NSNotFound;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Perform custom UI setup here
    self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    NSString *pathFile = pathForResource(kBundleImages, @"nextKeyboard.png");
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    
    [self.nextKeyboardButton setImage:image forState:UIControlStateNormal];

    [self.nextKeyboardButton sizeToFit];
    
    self.data = [Emoticon getAllEmoticons];
    
    CGRect keyboardViewFrame = CGRectMake(0, 0, 320, 216);
    
    self.keyboardView = [[KeyboardView alloc] initWithFrame:keyboardViewFrame];
    [self.view addSubview:self.keyboardView];
    
    UIBarButtonItem *nextKeyboardBarButton = [[UIBarButtonItem alloc] initWithCustomView:self.nextKeyboardButton];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [[NSArray alloc] initWithObjects:nextKeyboardBarButton, flexibleSpace, nil];
    
    [self.keyboardView.toolbar setItems:items];
    
    [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.keyboardView.collectionView registerNib:[UINib nibWithNibName:@"KeyboardCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"KeyboardCollectionViewCell"];
    
    pathFile = pathForResource(kBundleImages, @"ico-pattern.png");
    
    image = [[UIImage alloc] initWithContentsOfFile:pathFile];
    
    self.keyboardView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    self.keyboardView.collectionView.delegate = self;
    self.keyboardView.collectionView.dataSource = self;
}

- (void)updatePermissionsView {
    
    if (![self allowAccessFullKeyboard]) {
     
        self.keyboardView.maskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
        self.keyboardView.maskView.hidden = NO;
        
        CGRect bounds = self.keyboardView.collectionView.frame;
        
        self.keyboardView.maskView.frame = bounds;
        
        self.keyboardView.textView.text = NSLocalizedString(@"TextAllowKeyboard", nil);
        
        CGRect textFrame = CGRectMake(0.0f, 0.0f, bounds.size.width * 0.8f, 0.0f);
        self.keyboardView.textView.frame = textFrame;
        
        [self.keyboardView.textView sizeToFit];
        
        textFrame = self.keyboardView.textView.bounds;
        
        textFrame.origin.x = ((bounds.origin.x +  bounds.size.width) / 2.0f) - (textFrame.size.width / 2.0f);
        textFrame.origin.y = ((bounds.origin.y +  bounds.size.height) / 2.0f) - (textFrame.size.height / 2.0f);
        
        self.keyboardView.textView.frame = textFrame;
        
        self.keyboardView.textView.backgroundColor = [UIColor clearColor];
        self.keyboardView.textView.layer.cornerRadius = 0.0f;
        
    }
    else {
        
        self.keyboardView.maskView.hidden = YES;
    }
}

- (void)updateCopyPasteView {
    
    KeyboardViewController *wkself = self;
    
    wkself.keyboardView.maskView.hidden = NO;
    
    wkself.keyboardView.maskView.backgroundColor = [UIColor clearColor];
    
    CGRect bounds = wkself.keyboardView.collectionView.frame;
    
    wkself.keyboardView.maskView.frame = wkself.keyboardView.collectionView.frame;
    
    wkself.keyboardView.textView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    
    wkself.keyboardView.textView.text = NSLocalizedString(@"TextCopyKeyboard", nil);
    
    CGRect textFrame = CGRectMake(0.0f, 0.0f, 300.0f, 200.0f);
    
    wkself.keyboardView.textView.frame = textFrame;
    
    [wkself.keyboardView.textView sizeToFit];
    
    textFrame = wkself.keyboardView.textView.bounds;
    
    textFrame.origin.x = ((bounds.origin.x +  bounds.size.width) / 2.0f) - (textFrame.size.width / 2.0f);
    textFrame.origin.y = ((bounds.origin.y +  bounds.size.height) / 2.0f) - (textFrame.size.height / 2.0f);
    
    wkself.keyboardView.textView.frame = textFrame;
    
    wkself.keyboardView.textView.layer.cornerRadius = textFrame.size.width * 0.015;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        wkself.keyboardView.maskView.hidden = YES;
    });
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGRect keyboardViewFrame = self.view.frame;
    
    self.keyboardView.frame = keyboardViewFrame;
    
    CGFloat toolbarHeight = 44.0f;
    
    CGRect collectionViewFrame = keyboardViewFrame;
    collectionViewFrame.size.height = collectionViewFrame.size.height - toolbarHeight;

    CGRect toolbarFrame = keyboardViewFrame;
    toolbarFrame.size.height = toolbarHeight;
    
    toolbarFrame.origin.y = collectionViewFrame.origin.y + collectionViewFrame.size.height;
    
    self.keyboardView.collectionView.frame = collectionViewFrame;
    self.keyboardView.toolbar.frame = toolbarFrame;
    
    [self updatePermissionsView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void)textWillChange:(id<UITextInput>)textInput {
    // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput {
    // The app has just changed the document's contents, the document context has been updated.
    
    UIColor *textColor = nil;
    if (self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark) {
        textColor = [UIColor whiteColor];
    } else {
        textColor = [UIColor blackColor];
    }
    
    [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak Emoticon *emoticon = [self.data objectAtIndex:indexPath.item];
    
    NSString *pathFile = pathForResource(kBundleImages, emoticon.gif);
    
    KeyboardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KeyboardCollectionViewCell" forIndexPath:indexPath];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:pathFile]];
    
    cell.animatedImageView.animatedImage = image;
    
    cell.checkImageView.hidden = (self.selectedRow != indexPath.item);
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
 
    return CGSizeMake(86, 85);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    KeyboardCollectionViewCell *cell = (KeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedRow inSection:indexPath.section]];
    
    cell.checkImageView.hidden = YES;
    
    cell = (KeyboardCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.checkImageView.hidden = NO;
    
    self.selectedRow = indexPath.item;
    
    [self updateCopyPasteView];
    
    __weak Emoticon *emoticon = [self.data objectAtIndex:indexPath.item];
    
    NSString *pathFile = pathForResource(kBundleImages, emoticon.gif);
    
    NSData *data = [NSData dataWithContentsOfFile:pathFile];
    
    [[UIPasteboard generalPasteboard] setData:data forPasteboardType:(__bridge_transfer NSString *)kUTTypeGIF];
}

- (BOOL)allowAccessFullKeyboard {
    
    return [UIPasteboard generalPasteboard] ? YES : NO;
}

@end
