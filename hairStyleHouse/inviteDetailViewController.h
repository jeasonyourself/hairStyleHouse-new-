//
//  inviteDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface inviteDetailViewController : UIViewController
{
    NSDictionary * jobDetailDic;
}
@property (strong, nonatomic) NSDictionary * inforDic;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLable;
@property (strong, nonatomic) IBOutlet UILabel *workPlaceLable;
@property (strong, nonatomic) IBOutlet UILabel *workCityLable;
@property (strong, nonatomic) IBOutlet UILabel *numOfNeedLable;
@property (strong, nonatomic) IBOutlet UILabel *moneyLable;
@property (strong, nonatomic) IBOutlet UILabel *storeAddressLable;

@property (strong, nonatomic) IBOutlet UILabel *telephoneLable;
@property (strong, nonatomic) IBOutlet UIButton *talkButton;
- (IBAction)talkButtonClick:(UIButton *)sender;

@end
