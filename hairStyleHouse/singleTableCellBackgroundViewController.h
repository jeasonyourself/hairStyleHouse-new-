//
//  singleTableCellBackgroundViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class mineViewController;
#import "personInforViewController.h"
#import "fansAndFouceAndmassegeViewController.h"
#import "scanImageViewController.h"
#import "beaspeakViewController.h"
#import "completeViewController.h"
#import "sameCityViewController.h"
#import "toolBoxViewController.h"
#import "myShowViewController.h"
#import "mySetViewController.h"
@interface singleTableCellBackgroundViewController : UIViewController<UIScrollViewDelegate>
{
    NSDictionary * infoDic;
    UIScrollView * workScroll;
    mineViewController * fatherController;
    personInforViewController * personInfor;
    fansAndFouceAndmassegeViewController * fansAndfouceAndMassege;
    scanImageViewController * scanView;
    sameCityViewController * sameCityView;

    beaspeakViewController * beaspeakView;

    completeViewController * completeView;
    
    toolBoxViewController * toolBoxView;
    myShowViewController * myShowView;
    
    mySetViewController * mySetView;
}
@property(nonatomic,strong)NSDictionary * infoDic;
@property(nonatomic,strong)mineViewController * fatherController;

@property (strong, nonatomic) IBOutlet UIView *firstBackView;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UIButton *changeInforButton;


@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;
@property (strong, nonatomic) IBOutlet UILabel *fansLable;

@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
@property (strong, nonatomic) IBOutlet UILabel *fouceLable;

@property (strong, nonatomic) IBOutlet UIView *secondBackView;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;

@property (strong, nonatomic) IBOutlet UIView *clearPerson;
@property (strong, nonatomic) IBOutlet UIButton *clearPersonButton;


@property (strong, nonatomic) IBOutlet UIView *myMessage;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;


@property (strong, nonatomic) IBOutlet UILabel *beaspeakLable;

@property (strong, nonatomic) IBOutlet UIView *myBeaspeak;
@property (strong, nonatomic) IBOutlet UIButton *beaspeakButton;

@property (strong, nonatomic) IBOutlet UIView *myWorks;
@property (strong, nonatomic) IBOutlet UIButton *myWorksButton;



@property (strong, nonatomic) IBOutlet UILabel *saveLable;


@property (strong, nonatomic) IBOutlet UIView *mySave;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) IBOutlet UIView *toolBox;
@property (strong, nonatomic) IBOutlet UIButton *toolBoxButton;

@property (strong, nonatomic) IBOutlet UIView *myShow;
@property (strong, nonatomic) IBOutlet UIButton *myShowButton;

@property (strong, nonatomic) IBOutlet UIView *mySet;
@property (strong, nonatomic) IBOutlet UIView *mySetButton;


@property (strong, nonatomic) IBOutlet UILabel *mobileLable;

@property (strong, nonatomic) IBOutlet UITextView *personInforText;

- (IBAction)headButtonClick:(id)sender;

- (IBAction)myFansButtonClick:(id)sender;
- (IBAction)myFouceButtonClick:(id)sender;

- (IBAction)clearPersonButtonClick:(id)sender;

- (IBAction)messageButtonClick:(id)sender;


- (IBAction)beaspeakButtonClick:(id)sender;

- (IBAction)myWorksButtonClick:(id)sender;

- (IBAction)saveButtonClick:(id)sender;

- (IBAction)toolBoxButtonClick:(id)sender;

- (IBAction)myShowButtonClick:(id)sender;
- (IBAction)mySetButtonClick:(id)sender;
@end
