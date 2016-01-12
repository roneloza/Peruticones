//
//  KeyboardCollectionViewCell.h
//  Peruticones
//
//  Created by RLoza on 1/8/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLAnimatedImageView;

@interface KeyboardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;
@end
