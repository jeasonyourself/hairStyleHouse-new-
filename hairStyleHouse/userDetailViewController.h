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

@class userInforViewController;
@interface userDetailViewController : UIViewController<UIScrollViewDelegate>
{
    userInforViewController * fatherController;
    NSDictionary * infoDic;
    UIScrollView * workScroll;
    UIScrollView * saveScroll;
    lookEvaluateViewController * lookEvaluate;
    scanImageViewController * scanView;
    
}
@property(nonatomic,strong)userInforViewController * fatherController;
@property(nonatomic,strong)NSDictionary * infoDic;

@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;

@property (strong, nonatomic) IBOutlet UIView *secondBackView;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;
@property (strong, nonatomic) IBOutlet UITextView *inforTextVuew;
@property (strong, nonatomic) IBOutlet UIView *saveBackView;

@property (strong, nonatomic) IBOutlet UIButton *bespeakButton;



- (IBAction)bespeakDresserClick:(id)sender;
@end
