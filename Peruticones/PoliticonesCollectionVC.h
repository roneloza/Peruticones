//
//  PoliticonesCollectionViewController.h
//  Peruticones
//
//  Created by RLoza on 11/26/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShareModalView;

@interface PoliticonesCollectionVC : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *keyboardButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet ShareModalView *shareModalView;
@property (weak, nonatomic) IBOutlet UIButton *maskButton;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *shareOptions;

- (IBAction)maskButtonTouch:(UIButton *)sender;
- (IBAction)keyboardButtonTouch:(UIButton *)sender;

- (BOOL)isInstalledKeyboard;
- (void)hideShareView;
- (void)showShareView;
@end
