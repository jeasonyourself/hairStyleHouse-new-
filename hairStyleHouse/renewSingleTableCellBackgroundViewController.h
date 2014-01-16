//
//  renewSingleTableCellBackgroundViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-7.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class mineViewController;
#import "personInforViewController.h"
#import "fansAndFouceAndmassegeViewController.h"
#import "scanImageViewController.h"
#import "beaspeakViewController.h"
#import "lookEvaluateViewController.h"
#import "sameCityViewController.h"
#import "toolBoxViewController.h"
#import "mySetViewController.h"
#import "sureStoreViewController.h"
@interface renewSingleTableCellBackgroundViewController : UIViewController<UIScrollViewDelegate>
{
    NSDictionary * infoDic;
    UIScrollView * workScroll;
    mineViewController * fatherController;
    personInforViewController * personInfor;
    lookEvaluateViewController * lookEvaluate;
    fansAndFouceAndmassegeViewController * fansAndfouceAndMassege;
    scanImageViewController * scanView;
    beaspeakViewController * beaspeakView;
    sameCityViewController * sameCityView;
    toolBoxViewController * toolBoxView;
    mySetViewController * mySetView;
    sureStoreViewController * sureView;
}

@property(nonatomic,strong)NSDictionary * infoDic;
@property(nonatomic,strong)mineViewController * fatherController;

@property (strong, nonatomic) IBOutlet UIView *firstBackView;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *fansLable;
@property (strong, nonatomic) IBOutlet UILabel *fouceLable;

@property (strong, nonatomic) IBOutlet UILabel *introduceLable;
@property (strong, nonatomic) IBOutlet UILabel *saveLable;


//@property (strong, nonatomic) IBOutlet UILabel *addressLable;
//@property (strong, nonatomic) IBOutlet UIButton *fansButton;
//@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
//@property (strong, nonatomic) IBOutlet UIView *secondBackView;
//@property (strong, nonatomic) IBOutlet UILabel *worksLable;
//@property (strong, nonatomic) IBOutlet UILabel *messageLable;
//@property (strong, nonatomic) IBOutlet UIButton *messageButton;

//@property (strong, nonatomic) IBOutlet UIButton *storeButton;

@property (strong, nonatomic) IBOutlet UIButton *changeInforButton;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;

@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
@property (strong, nonatomic) IBOutlet UIButton *evaluateButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) IBOutlet UIView *clearPerson;
@property (strong, nonatomic) IBOutlet UIButton *clearPersonButton;


@property (strong, nonatomic) IBOutlet UIView *myMessage;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;
@property (strong, nonatomic) IBOutlet UIView *myBeaspeak;
@property (strong, nonatomic) IBOutlet UIButton *beaspeakButton;

@property (strong, nonatomic) IBOutlet UIView *myWorks;
@property (strong, nonatomic) IBOutlet UIButton *myWorksButton;
@property (strong, nonatomic) IBOutlet UIView *mySave;
@property (strong, nonatomic) IBOutlet UIView *setPrice;
@property (strong, nonatomic) IBOutlet UIButton *setPriceButton;
@property (strong, nonatomic) IBOutlet UIView *shalong;
@property (strong, nonatomic) IBOutlet UIButton *shalongButton;

@property (strong, nonatomic) IBOutlet UIView *toolBox;
@property (strong, nonatomic) IBOutlet UIButton *toolBoxButton;



@property (strong, nonatomic) IBOutlet UIView *mySet;
@property (strong, nonatomic) IBOutlet UIView *mySetButton;

- (IBAction)headButtonClick:(id)sender;

- (IBAction)myFansButtonClick:(id)sender;
- (IBAction)myFouceButtonClick:(id)sender;

- (IBAction)evaluateButtonClick:(id)sender;

- (IBAction)saveButtonClick:(id)sender;

- (IBAction)clearPersonButtonClick:(id)sender;

- (IBAction)messageButtonClick:(id)sender;


- (IBAction)beaspeakButtonClick:(id)sender;

- (IBAction)myWorksButtonClick:(id)sender;

- (IBAction)setPriceButtonClick:(id)sender;

- (IBAction)shalongButtonClick:(id)sender;


- (IBAction)toolBoxButtonClick:(id)sender;

- (IBAction)mySetButtonClick:(id)sender;
//@property (strong, nonatomic) IBOutlet UILabel *saveLable;
//@property (strong, nonatomic) IBOutlet UIButton *saveButton;
//
//@property (strong, nonatomic) IBOutlet UILabel *beaspeakLable;
//@property (strong, nonatomic) IBOutlet UIButton *beaspeakButton;
//
//
//@property (strong, nonatomic) IBOutlet UIButton *checkInforButton;
//
//
//@property (strong, nonatomic) IBOutlet UITextView *personInforText;
//
//- (IBAction)headButtonClick:(id)sender;
//- (IBAction)myFansButtonClick:(id)sender;
//- (IBAction)myFouceButtonClick:(id)sender;
//- (IBAction)messageButtonClick:(id)sender;
//- (IBAction)myStoreButtonClick:(id)sender;
//- (IBAction)beaspeakButtonClick:(id)sender;
//- (IBAction)saveButtonClick:(id)sender;
//- (IBAction)checkInforButtonClick:(id)sender;


@end

