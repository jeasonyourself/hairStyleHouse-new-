//
//  beaspeakDresserViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserInforViewController.h"
@interface beaspeakDresserViewController : UIViewController
{
    NSString * orderId;
    NSDictionary * orderInfor;
    NSMutableArray * dresserArray;
    
    dresserInforViewController * dreserView;

}
@property (strong, nonatomic)   NSString * dresserOrCommen;

@property (strong, nonatomic)   NSString * orderId;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *storeLable;
@property (strong, nonatomic) IBOutlet UILabel *mobileLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UILabel *brespeakLable;
@property (strong, nonatomic) IBOutlet UILabel *typeLable;
@property (strong, nonatomic) IBOutlet UILabel *priceLable;

@property (strong, nonatomic) IBOutlet UILabel *firstLable;

@property (strong, nonatomic) IBOutlet UILabel *secondLable;
@property (strong, nonatomic) IBOutlet UILabel *thirdLable;

@property (strong, nonatomic) IBOutlet UILabel *forthLable;

@property (strong, nonatomic) IBOutlet UILabel *fifthLable;


@property (strong, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) IBOutlet UILabel *otherNameLable;

@property (strong, nonatomic) IBOutlet UILabel *otherMobileLable;
@property (strong, nonatomic) IBOutlet UIView *introView;

@property (strong, nonatomic) IBOutlet UILabel *otherTimeLable;

@property (strong, nonatomic) IBOutlet UILabel *otherTypeLable;

@property (strong, nonatomic) IBOutlet UILabel *otherMoneyLable;

@property (strong, nonatomic) IBOutlet UIImageView *picImage;

- (IBAction)headButtonClick:(id)sender;





@end
