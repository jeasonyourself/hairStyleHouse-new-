//
//  userDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-6.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "lookEvaluateViewController.h"
#import "scanImageViewController.h"
#import "talkViewController.h"
@class userInforViewController;
@interface userDetailViewController : UIViewController<UIScrollViewDelegate>
{
    userInforViewController * fatherController;
    NSDictionary * infoDic;
    UIScrollView * workScroll;
    UIScrollView * saveScroll;
    lookEvaluateViewController * lookEvaluate;
    scanImageViewController * scanView;
    talkViewController * talkView;
    

}
@property(nonatomic,strong)userInforViewController * fatherController;
@property(nonatomic,strong)NSDictionary * infoDic;

@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *headBackView;


@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UILabel *signature;

@property (strong, nonatomic) IBOutlet UIView *secondView;


@property (strong, nonatomic) IBOutlet UIView *thirdView;
@property (strong, nonatomic) IBOutlet UIView *forthView;

@property (strong, nonatomic) IBOutlet UIButton *askButton;
@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
- (IBAction)questionButtonClick:(id)sender;


- (IBAction)saveButtonClick:(id)sender;

- (IBAction)askButtonClick:(id)sender;
- (IBAction)fouceButtonClick:(id)sender;


- (IBAction)bespeakDresserClick:(id)sender;
@end
