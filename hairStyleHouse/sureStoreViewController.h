//
//  sureStoreViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-16.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sureStoreViewController : UIViewController
@property(nonatomic,strong)NSString * _hidden;
@property(nonatomic,strong)NSMutableDictionary * infordic;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *mobileField;
@property (strong, nonatomic) IBOutlet UITextView *addressText;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)sureButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;
@end
