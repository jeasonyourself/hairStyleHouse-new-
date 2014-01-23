//
//  dresserMySetSingleCellViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-31.
//  Copyright (c) 2013年 jeason. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "personInforViewController.h"
#import "fansAndFouceAndmassegeViewController.h"
@class mySetViewController;
#import "adviceViewController.h"
#import "helpViewController.h"
#import "setBeaspeakViewController.h"
#import "rigViewController.h"
#import "setOpenOrCloseViewController.h"

@interface dresserMySetSingleCellViewController : UIViewController
{
    NSMutableDictionary * inforDic;
    personInforViewController* personInfor ;
    fansAndFouceAndmassegeViewController * fansAndfouceAndMassege;
    NSMutableArray * userInforArr;
    NSMutableDictionary * userInfor;
    adviceViewController * adviceView;
    helpViewController * helpView;
    setBeaspeakViewController * setBeaspeakView;
    rigViewController * rigView;
    setOpenOrCloseViewController *setOpenOrCloseView;
    

}
@property (nonatomic,strong)mySetViewController  *fatherController;
@property (strong, nonatomic) IBOutlet UIView *changeInforView;
@property (strong, nonatomic) IBOutlet UIView *beaspeakSetView;


@property (strong, nonatomic) IBOutlet UIView *messageView;
@property (strong, nonatomic) IBOutlet UIView *sinaView;

@property (strong, nonatomic) IBOutlet UILabel *sinaLable;


@property (strong, nonatomic) IBOutlet UIView *tencentView;
@property (strong, nonatomic) IBOutlet UIButton *sinaButton;
@property (strong, nonatomic) IBOutlet UIButton *tencentButton;
@property (strong, nonatomic) IBOutlet UILabel *tencentLable;
@property (strong, nonatomic) IBOutlet UIView *SuggestView;
@property (strong, nonatomic) IBOutlet UIView *userHelpView;
@property (strong, nonatomic) IBOutlet UIView *clearAllView;
@property (strong, nonatomic) IBOutlet UIView *updateLevelView;
@property (strong, nonatomic) IBOutlet UIButton *sigoutButton;


- (IBAction)changeInforButtonClick:(id)sender;
- (IBAction)beaspeakButtonClick:(id)sender;


- (IBAction)messageButtonClick:(id)sender;

- (IBAction)sinaButtonClick:(id)sender;
- (IBAction)tencentButtonClick:(id)sender;

- (IBAction)suggestButtonClick:(id)sender;
- (IBAction)userHelpButtonClick:(id)sender;
- (IBAction)clearAllButtonClick:(id)sender;
- (IBAction)updateLevelButtonClick:(id)sender;

- (IBAction)sinoutButtonClick:(id)sender;

@end
