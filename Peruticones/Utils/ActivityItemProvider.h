//
//  TromeActivityItemProvider.h
//  TromeEnterate
//
//  Created by RLoza on 9/23/15.
//  Copyright (c) 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Emoticon;
@interface ItemProvider : NSObject

@property (nonatomic, strong) Emoticon *emoticon;

- (id)initWithItem:(Emoticon *)emoticon;

@end

@interface ActivityItemProvider : UIActivityItemProvider<UIActivityItemSource>

- (id)initWithItem:(ItemProvider *)item;

@end
