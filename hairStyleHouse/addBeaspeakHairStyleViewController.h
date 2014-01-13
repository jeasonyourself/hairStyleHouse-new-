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

@interface addBeaspeakHairStyleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    NSDictionary * inforDic;
    
    UITableView *myTableView;
    
    NSDictionary * workInforDic;
    NSMutableArray * dresserArray;
    
    UIView * lastView;
    UITextView * contentView;
    UIButton * sendButton;
    
    talkViewController * talkView;
    sendBeaspeakHairStyleViewController * beaspeakHairStyleView;
}
@property (nonatomic,strong)NSDictionary * inforDic;
-(void)askButtonClick:(NSInteger)_index;
-(void)beaspeakButtonClick:(NSInteger)_index andImage:(UIImageView *)Img;;


@end
