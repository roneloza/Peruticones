//
//  KeyboardView.h
//  Peruticones
//
//  Created by RLoza on 1/8/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
