//
//  setBeaspeakViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-20.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingTableView;
@class TPKeyboardAvoidingScrollView;
#import "setBeaspeakCell.h"
@interface setBeaspeakViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray * dresserArray;
    NSMutableArray * dresserArray1;
    
    NSString * string;

}
@property(nonatomic,strong) NSString * _hidden;
-(void)addNew;
-(void)deleteView:(NSInteger)index;
-(void)lookAllcell;
- (void)textFieldEditChanged:(UITextField *)textField;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;

- (IBAction)firstButtonClick:(id)sender;



- (IBAction)secondButtonClick:(id)sender;

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingTableView *myTableView;

@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UITextField *firstTextField;
@property (strong, nonatomic) IBOutlet UITextField *secondTextField;
@property (strong, nonatomic) IBOutlet UITextField *thirdTextField;
@property (strong, nonatomic) IBOutlet UITextField *forthTextField;
@property (strong, nonatomic) IBOutlet UITextField *fifithTextField;

@property (strong, nonatomic) IBOutlet UITextField *firstPrice;
@property (strong, nonatomic) IBOutlet UITextField *firstSale;
@property (strong, nonatomic) IBOutlet UITextField *secondPrice;
@property (strong, nonatomic) IBOutlet UITextField *secondSale;

@property (strong, nonatomic) IBOutlet UITextField *thirdPrice;
@property (strong, nonatomic) IBOutlet UITextField *thirdSale;

@property (strong, nonatomic) IBOutlet UITextField *forthPrice;

@property (strong, nonatomic) IBOutlet UITextField *forthSale;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)sureButtonClick:(id)sender;

-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;
@end
