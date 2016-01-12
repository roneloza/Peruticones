//
//  SetupKeyboardViewController.h
//  Peruticones
//
//  Created by RLoza on 1/8/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupKeyboardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *tableContainer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 @name NSArray od NSAttributedString *
 NSArray od NSAttributedString *
 */
@property (nonatomic, strong) NSArray *data;
@end
