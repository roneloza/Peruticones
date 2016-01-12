//
//  Emoticon.h
//  Peruticones
//
//  Created by RLoza on 11/30/15.
//  Copyright © 2015 Empresa Editora El Comercio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emoticon : NSObject

@property (nonatomic, strong) NSString *png;
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSString *whatsapp;
@property (nonatomic, strong) NSString *gif;
@property (nonatomic, strong) NSString *title;

/**
 * @name
 * Initializer convenience
 */
- (instancetype)initWithPng:(NSString *)png facebook:(NSString *)facebook twitter:(NSString *)twitter whatsapp:(NSString *)whatsapp gif:(NSString *)gif title:(NSString *)title;

+ (NSArray *)getAllEmoticons;

@end
