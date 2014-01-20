//
//  adviceViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-20.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adviceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *adviceText;
@property (strong, nonatomic) IBOutlet UIButton *adviceButton;

- (IBAction)adviceButtonClick:(id)sender;
@property(nonatomic,strong) NSString * _hidden;
@end
