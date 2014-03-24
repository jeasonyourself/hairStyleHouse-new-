//
//  fansAndFouceAndmassegeViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fansAndfoceAndMassegeCell.h"
#import "dresserInforViewController.h"
#import "userInforViewController.h"
#import "talkViewController.h"
#import "talkViewController.h"
#import "YFJLeftSwipeDeleteTableView.h"
@interface fansAndFouceAndmassegeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    NSMutableArray * dresserArray1;

    BOOL dresserOrperson;//yes是发型师。no是个人用户
    
    UIButton * oneButton;
    UIButton * twoButton;
    NSString * fansOrFouceOrMessage;
    NSString * fansOrFouce;
    
    dresserInforViewController * dreserView;
    userInforViewController * userView;
    talkViewController * talkView;
    
    NSString * page;
    NSString * pageCount;
    AllAroundPullView  *  bottomRefreshView;
    
    
    NSString * sign;
    UIActivityIndicatorView * _activityIndicatorView ;
    
}
@property (nonatomic, strong) YFJLeftSwipeDeleteTableView * tableViewM;

@property (strong,nonatomic)    NSString * fansOrFouceOrMessage;
@property (strong,nonatomic)    NSString * fansOrFouce;
@end

