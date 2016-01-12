//
//  SetupKeyboardViewController.m
//  Peruticones
//
//  Created by RLoza on 1/8/16.
//  Copyright © 2016 Empresa Editora El Comercio. All rights reserved.
//

#import "SetupKeyboardViewController.h"
#import "Constants.h"

#define kSetupKeyboardCell @"SetupKeyboardCell"

@interface SetupKeyboardViewController ()<UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation SetupKeyboardViewController

#pragma mark - Life Cicle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableContainer.layer.cornerRadius = self.tableContainer.bounds.size.width * 0.010;
    self.tableContainer.layer.borderWidth = 1.0f;
    self.tableContainer.layer.borderColor = [UIColorFromRGB(0x82828D) CGColor];
    
    [self fillData];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *imageFromColor = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageFromColor;
}

- (UIImage *)imageFromText:(NSString *)text size:(CGSize)size font:(UIFont *)font color:(UIColor *)color {
    
    CGSize sizeText = [text sizeWithFont:font];
    size  = color ? size : sizeText;
    
    UIGraphicsBeginImageContext(size);
    
    CGPoint offset = CGPointMake(0.0f, 0.0f);
    
    if (color) {
     
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 0.5f);
        CGContextSetStrokeColorWithColor(context, [color CGColor]);
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextStrokeEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));
        
        offset = CGPointMake((size.width / 2.0f) - (sizeText.width / 2.0), (size.height / 2.0f) - (sizeText.height / 2.0));
        
//        CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    }
    
    
    // optional: add a shadow, to avoid clipping the shadow you should make the context size bigger
    //
    // CGContextRef ctx = UIGraphicsGetCurrentContext();
    // CGContextSetShadowWithColor(ctx, CGSizeMake(1.0, 1.0), 5.0, [[UIColor grayColor] CGColor]);
    
    // draw in context, you can use also drawInRect:withFont:
    [text drawAtPoint:CGPointMake(0.0f + offset.x, 0.0f + offset.y) withFont:font];
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)fillData {
    
    NSDictionary *attr1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [UIFont boldSystemFontOfSize:13.0f], NSFontAttributeName,
                          UIColorFromRGB(0xF5C002), NSForegroundColorAttributeName,
                          nil];
    
    NSDictionary *attr2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                           [UIFont systemFontOfSize:13.0f], NSFontAttributeName,
                           [UIColor darkGrayColor], NSForegroundColorAttributeName,
                           nil];
    
    NSString *text1 = NSLocalizedString(@"TextSetupKeyboard_1", nil);
    NSString *text2 = NSLocalizedString(@"TextSetupKeyboard_2", nil);
    NSString *text3 = NSLocalizedString(@"TextSetupKeyboard_3", nil);
    NSString *text4 = NSLocalizedString(@"TextSetupKeyboard_4", nil);
    NSString *text5 = NSLocalizedString(@"TextSetupKeyboard_5", nil);
    NSString *text6 = NSLocalizedString(@"TextSetupKeyboard_6", nil);
    NSString *text7 = NSLocalizedString(@"TextSetupKeyboard_7", nil);
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"TextSettings", @"TextGeneral", @"TextKeyboard", @"Text2Keyboard", @"TextButtonAllow", @"TextPeruticones", @"TextAddNewKeyboard", @"TextAllowFullAcessKeyboard", nil];
    
    NSArray *words = [[NSArray alloc] initWithObjects:text1, text2, text3, text4, text5, text6, text7, nil];
    
    NSString *joinedBy = @"$$";
    
    NSString *concatenateWords = [words componentsJoinedByString:joinedBy];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:concatenateWords attributes:attr2];
    
    NSRange range = NSMakeRange(0, 0);
    NSAttributedString *attrReplace = nil;
    
    for (NSString *key in keys) {
        
        while ((range = [attrString.string rangeOfString:key]).location != NSNotFound) {
            
            attrReplace = [[NSAttributedString alloc] initWithString:NSLocalizedString(key, nil) attributes:attr1];
            [attrString replaceCharactersInRange:range withAttributedString:attrReplace];
        }
    }
    
    NSMutableArray *tmp = [[NSMutableArray alloc] initWithCapacity:words.count];
    
    concatenateWords = attrString.string;
    
    words = [concatenateWords componentsSeparatedByString:joinedBy];
    
    for (NSString *attrText in words) {
        
        NSRange range = [concatenateWords rangeOfString:attrText];
        
        [tmp addObject:[attrString attributedSubstringFromRange:range]];
    }
    
    self.data = [tmp copy];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions

- (IBAction)closeButtonTouch:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak NSAttributedString *attrTitle = [self.data objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSetupKeyboardCell forIndexPath:indexPath];
    
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.attributedText = attrTitle;
    
    NSInteger index = indexPath.row + 1;
    
    NSString *str = [[NSString alloc] initWithFormat:@"%@", (indexPath.row != (self.data.count - 1) ? [[NSString alloc] initWithFormat:@"%d", index] : @"?")];
    
    UIFont *font = [UIFont systemFontOfSize:20.0f];
    
    UIImage *indexImage = [self imageFromText:str size:CGSizeMake(30.0f, 30.0f) font:font color:(indexPath.row != (self.data.count - 1) ? nil : UIColorFromRGB(0x007AFF))];
    
    cell.imageView.image = indexImage;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 55.0f;
}

@end
