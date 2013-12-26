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
@interface renewSingleTableCellBackgroundViewController : UIViewController<UIScrollViewDelegate>
{
    NSDictionary * infoDic;
    UIScrollView * workScroll;
    mineViewController * fatherController;
    personInforViewController * personInfor;
    fansAndFouceAndmassegeViewController * fansAndfouceAndMassege;
    scanImageViewController * scanView;
    beaspeakViewController * beaspeakView;
    
}
@property(nonatomic,strong)NSDictionary * infoDic;
@property(nonatomic,strong)mineViewController * fatherController;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;
@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
@property (strong, nonatomic) IBOutlet UIView *secondBackView;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;

@property (strong, nonatomic) IBOutlet UIButton *storeButton;

@property (strong, nonatomic) IBOutlet UILabel *saveLable;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) IBOutlet UILabel *beaspeakLable;
@property (strong, nonatomic) IBOutlet UIButton *beaspeakButton;


@property (strong, nonatomic) IBOutlet UIButton *checkInforButton;

@property (strong, nonatomic) IBOutlet UIButton *evaluateButton;

@property (strong, nonatomic) IBOutlet UITextView *personInforText;

- (IBAction)headButtonClick:(id)sender;
- (IBAction)myFansButtonClick:(id)sender;
- (IBAction)myFouceButtonClick:(id)sender;
- (IBAction)messageButtonClick:(id)sender;
- (IBAction)myStoreButtonClick:(id)sender;
- (IBAction)beaspeakButtonClick:(id)sender;
- (IBAction)saveButtonClick:(id)sender;
- (IBAction)checkInforButtonClick:(id)sender;
- (IBAction)evaluateButtonClick:(id)sender;

@end

