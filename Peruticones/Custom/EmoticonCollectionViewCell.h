//
//  EmoticonesCollectionViewCell.h
//  El Comercio Emoticones
//
//  Created by Cristian on 13/11/15.
//  Copyright © 2015 Cristian Palomino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmoticonCollectionViewCell : UICollectionViewCell

//@property (weak,nonatomic) º UILabel *nombreEmoji;
@property (weak,nonatomic) IBOutlet UIImageView *emoticonImageView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
