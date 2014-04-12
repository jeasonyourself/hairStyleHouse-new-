//
//  addBeaspeakViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-9.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scanImageViewController.h"
#import "lookEvaluateViewController.h"
@class TPKeyboardAvoidingScrollView;
@interface addBeaspeakViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString * styleString;
    NSString * oldPriceString;
    NSString * saleString;

    NSString * newPriceString;
    NSString * dateString;
    NSString * dateString1;

    NSString * timeString;
    
    NSString * timeDataString;

    NSMutableArray * fourButtonArr;
    NSMutableArray * sevenButtonArr;
    NSMutableArray * twelveButtonArr;
    
    scanImageViewController * scanView;
    lookEvaluateViewController * lookEvaluate;
    NSMutableArray * firstArr;
    NSMutableArray * secondArr;
    UILabel * firstLable;
    UILabel * secondLable;
    UILabel * thirdLable;
    UILabel *forthLable;
    BOOL select;
    
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
@property (strong, nonatomic)  NSString * _hidden;
@property (strong, nonatomic)  NSMutableDictionary * inforDic;

@property (strong, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *headBackView;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;

@property (strong, nonatomic) IBOutlet UILabel *evaluateLable;
@property (strong, nonatomic) IBOutlet UILabel *shalongLable;

@property (strong, nonatomic) IBOutlet UILabel *cityLable;
@property (strong, nonatomic) IBOutlet UILabel *placeLable;
@property (strong, nonatomic) IBOutlet UILabel *telLable;

@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UIButton *lookWorksButton;
@property (strong, nonatomic) IBOutlet UIButton *lookEvauateButton;

@property (strong, nonatomic) IBOutlet UIView *secondView;
@property (strong, nonatomic) IBOutlet UITableView *firstTable;
@property (strong, nonatomic) IBOutlet UITableView *secondTable;
@property (strong, nonatomic) IBOutlet UILabel *introLable;

@property (strong, nonatomic) IBOutlet UIButton *styleOneButton;

@property (strong, nonatomic) IBOutlet UIButton *styleTwoButton;

@property (strong, nonatomic) IBOutlet UIButton *styleThirdButton;
@property (strong, nonatomic) IBOutlet UIButton *styleFourButton;

@property (strong, nonatomic) IBOutlet UIButton *dateOneButton;

@property (strong, nonatomic) IBOutlet UIButton *dateTwoButton;

@property (strong, nonatomic) IBOutlet UIButton *dateThirdButton;
@property (strong, nonatomic) IBOutlet UIButton *dateFourButton;
@property (strong, nonatomic) IBOutlet UIButton *dateFiveButton;

@property (strong, nonatomic) IBOutlet UIButton *dateSixButton;
@property (strong, nonatomic) IBOutlet UIButton *dateSevenButton;

@property (strong, nonatomic) IBOutlet UILabel *dayOneLable;
@property (strong, nonatomic) IBOutlet UILabel *dayTwoLable;
@property (strong, nonatomic) IBOutlet UILabel *dayThirdLable;
@property (strong, nonatomic) IBOutlet UILabel *dayFourLable;
@property (strong, nonatomic) IBOutlet UILabel *dayFiveLable;
@property (strong, nonatomic) IBOutlet UILabel *daySixLable;
@property (strong, nonatomic) IBOutlet UILabel *daySevenLable;

@property (strong, nonatomic) IBOutlet UILabel *timeOneLable;
@property (strong, nonatomic) IBOutlet UILabel *timeTwoLable;
@property (strong, nonatomic) IBOutlet UILabel *timeThirdLable;
@property (strong, nonatomic) IBOutlet UILabel *timeFourLable;
@property (strong, nonatomic) IBOutlet UILabel *timeFiveLable;
@property (strong, nonatomic) IBOutlet UILabel *timeSixLable;
@property (strong, nonatomic) IBOutlet UILabel *timeSevenLable;

@property (strong, nonatomic) IBOutlet UILabel *oldPrice;

@property (strong, nonatomic) IBOutlet UILabel *nowPrice;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;

@property (strong, nonatomic) IBOutlet UIButton *nineClockButton;
@property (strong, nonatomic) IBOutlet UIButton *tenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *elevenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *twelveClockButton;
@property (strong, nonatomic) IBOutlet UIButton *thirteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *forteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *fifteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *sixteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *seventeenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *eighteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *ninteenClockButton;
@property (strong, nonatomic) IBOutlet UIButton *twentyClockButton;
@property (strong, nonatomic) IBOutlet UIButton *sureButton;



- (IBAction)lookWorksClick:(id)sender;
- (IBAction)lookEvaluateButtonClick:(id)sender;

- (IBAction)styleButtonClick:(id)sender;


- (IBAction)dateButtonClick:(id)sender;


- (IBAction)timeClockButtonClick:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *timeField;

- (IBAction)sureButtonClick:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *otherSecondView;

@property (strong, nonatomic) IBOutlet UILabel *getTimeLable;

@property (strong, nonatomic) IBOutlet UILabel *beaspeakStyleLable;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *mobileField;

@property (strong, nonatomic) IBOutlet UIButton *sendBeaspeakButton;
- (IBAction)sendBeaspeakButtonClick:(id)sender;



-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;



@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;

@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
- (IBAction)actionCancel:(id)sender;

- (IBAction)actionDone:(id)sender;
@end
