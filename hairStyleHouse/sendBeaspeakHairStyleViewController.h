//
//  sendBeaspeakHairStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendBeaspeakHairStyleViewController : UIViewController

{
    NSString * oldPriceString;
    NSString * saleString;
    NSString * newPriceString;
    NSString * dateString;
    NSString * dateString1;
    NSString * timeString;
    NSString * timeDataString;

    NSMutableArray * sevenButtonArr;
    NSMutableArray * twelveButtonArr;
}

@property (nonatomic,strong)NSDictionary * inforDic;
@property (nonatomic,strong)UIImage * headImg;
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

@property (strong, nonatomic) IBOutlet UIView *otherSecondView;

@property (strong, nonatomic) IBOutlet UILabel *getTimeLable;


@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *mobileField;
@property (strong, nonatomic) IBOutlet UIButton *sendBeaspeakButton;

- (IBAction)dateButtonClick:(id)sender;


- (IBAction)timeClockButtonClick:(id)sender;


- (IBAction)sendBeaspeakButtonClick:(id)sender;



-(IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)touchDown:(id)sender;
@end
