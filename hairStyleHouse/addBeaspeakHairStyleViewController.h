//
//  addBeaspeakHairStyleViewController.h
//  hairStyleHouse
//
//  Created by jeason on 14-1-11.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addbeaspeakHairStyleCell.h"
#import "sendBeaspeakHairStyleViewController.h"
#import "talkViewController.h"
#import "AllAroundPullView.h"
@interface addBeaspeakHairStyleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSString * page;
    NSString * pageCount;
    
    NSDictionary * workInforDic;
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
    talkViewController * talkView;
    sendBeaspeakHairStyleViewController * beaspeakHairStyleView;
    
    UIActivityIndicatorView * _activityIndicatorView ;
    
   
}
@property (nonatomic,strong)NSDictionary * inforDic;
-(void)askButtonClick:(NSInteger)_index;
-(void)beaspeakButtonClick:(NSInteger)_index andImage:(UIImageView *)Img;;


@end
