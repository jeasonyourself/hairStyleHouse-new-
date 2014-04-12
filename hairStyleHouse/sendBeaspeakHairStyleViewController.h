//
//  sendBeaspeakHairStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface sendBeaspeakHairStyleViewController : UIViewController<UITextFieldDelegate>

{
    NSString * oldPriceString;
    NSString * saleString;
    NSString * newPriceString;
    NSString * dateString;
    NSString * dateString1;
    NSString * timeString;
    NSString * timeDataString;


    
    
    
    
    NSMutableArray *yearArray;
//    NSMutableArray *monthArray;
//    NSMutableArray *DaysArray;
//    NSMutableArray *amPmArray;
    NSMutableArray *hoursArray;
    NSMutableArray *minutesArray;
    
    NSString *currentMonthString;
    
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    
    BOOL firstTimeLoad;
}

@property (nonatomic,strong)NSDictionary * inforDic;
@property (nonatomic,strong)NSString * headImg;
@property (nonatomic,strong)NSString * _hidden;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *headBackView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *oldPrice;

@property (strong, nonatomic) IBOutlet UILabel *nowPrice;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;


@property (strong, nonatomic) IBOutlet UIView *secondView;




@property (strong, nonatomic) IBOutlet UIView *otherSecondView;

@property (strong, nonatomic) IBOutlet UILabel *getTimeLable;
@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;


@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *mobileField;
@property (strong, nonatomic) IBOutlet UITextField *timeField;


@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;

@property (strong, nonatomic) IBOutlet UIButton *sendBeaspeakButton;


- (IBAction)actionCancel:(id)sender;

- (IBAction)actionDone:(id)sender;

- (IBAction)sendBeaspeakButtonClick:(id)sender;



-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;
@end
