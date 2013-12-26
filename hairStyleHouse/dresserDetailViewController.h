//
//  dresserDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  dresserInforViewController;
#import "lookEvaluateViewController.h"
#import "scanImageViewController.h"
#import "talkViewController.h"
@interface dresserDetailViewController : UIViewController<UIScrollViewDelegate>
{
    dresserInforViewController * fatherController;
    NSDictionary * infoDic;
    UIScrollView * workScroll;

    lookEvaluateViewController * lookEvaluate;
    scanImageViewController * scanView;
    talkViewController * talkView;
}

@property(nonatomic,strong)dresserInforViewController * fatherController;
@property(nonatomic,strong)NSDictionary * infoDic;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;
@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
@property (strong, nonatomic) IBOutlet UIView *secondBackView;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;
@property (strong, nonatomic) IBOutlet UITextView *inforTextVuew;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLable;
@property (strong, nonatomic) IBOutlet UILabel *mobileLable;
@property (strong, nonatomic) IBOutlet UILabel *cityLable;
@property (strong, nonatomic) IBOutlet UIButton *bespeakButton;

- (IBAction)myFansButtonClick:(id)sender;
- (IBAction)myFouceButtonClick:(id)sender;

- (IBAction)bespeakDresserClick:(id)sender;

@end
