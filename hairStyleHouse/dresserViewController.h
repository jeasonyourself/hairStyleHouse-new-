//
//  dresserViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserInforViewController.h"
#import "dresserCell.h"
#import "LoginView.h"
#import "loginViewController.h"
#import "ASIFormDataRequest.h"
#import "TSLocateView.h"
#import "scanImageViewController.h"
#import "addBeaspeakViewController.h"
@class AllAroundPullView;
@interface dresserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

{
    UIImageView * topImage;
    UIButton * rightButton;
    TSLocateView *locateView;
    UIButton * oneButton;
    UIButton * twoButton;
    UIButton * thirdButton;
    UIButton * forthButton;
    UIButton * fifthButton;
    UIButton * sixthButton;
    UITableView *myTableView;
    
    UIView * categryOne;
    UIView * categryBackOne;
    UIView * categryBackOne1;
    UIButton * clearButtonOne;
    UITableView * categryTableOne;
    NSMutableArray * categryOneArr;
    NSMutableArray * categryTwoArr;
    
    UIView * categryTwo;
    UIView * categryBacktwo;
UIView * categryBacktwo1;
    UIButton * clearButtonTwo;
    UITableView * categryTableTwo;
    
    
     AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSMutableArray * dresserArray1;
    NSMutableArray * dresserArray2;
    NSMutableArray * dresserArray3;

    NSString * page;
    NSString * page1;
    NSString * page2;
    NSString * page3;
    NSString * pageCount;
    NSString * pageCount1;
    NSString * pageCount2;
    NSString * pageCount3;

    NSString * sign;//标记登陆成功后调用哪个借口
    dresserInforViewController * dreserView;

    loginViewController* loginView;
ASIFormDataRequest* requestMain;
    NSString* fromFouceLoginCancel;//标记取消登陆后调用哪个借口
    NSString * cityStr;
    NSString * lonStr;
    NSString * latStr;
    
    scanImageViewController * scanView;
    
    addBeaspeakViewController * addBeaspeakView;
    
    NSString * serviceStr;
    NSString * sortStr;
}
@property(nonatomic,strong)        NSString* fromFouceLoginCancel;
//-(void)fromFouceCancelBack:(NSString *)_str;
-(void)selectCell:(NSInteger)_index;
-(void)didFouce:(NSInteger)_index;
-(void)selectImage:(NSInteger)_index;

@end
