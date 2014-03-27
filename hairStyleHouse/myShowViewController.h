//
//  myShowViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myShowCell.h"
#import "MJPhotoBrowser.h"
#import "loginViewController.h"
#import "pubImageViewController.h"
#import "FMDatabase.h"
@class AllAroundPullView;

@interface myShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UITableView *myTableView;
    UIActivityIndicatorView * _activityIndicatorView ;

    AllAroundPullView *bottomRefreshView;
    
    UIButton * oneButton;
    UIButton * twoButton;
    UIButton * thirdButton;
    
//    NSMutableArray * dresserArray;
//    NSMutableArray * cleandresserArray;

    NSString * page;
    NSString * pageCount;
//    NSMutableArray * dresserArray1;
//    NSMutableArray * cleandresserArray1;

    NSString * page1;
    NSString * pageCount1;
//    NSMutableArray * dresserArray2;
//    NSMutableArray * cleandresserArray2;

    NSString * page2;
    NSString * pageCount2;
    
    NSMutableArray * localDresserArray;
    NSMutableArray * localcleanDresserArray;
    NSMutableArray * localDresserArray1;
    NSMutableArray * localcleanDresserArray1;
    NSMutableArray * localDresserArray2;
    NSMutableArray * localcleanDresserArray2;
    
    NSString * sign;
    
    NSString* style;
    
    MJPhotoBrowser *browser;
    
    loginViewController* loginView;
    pubImageViewController * pubImage;
    
    
    FMDatabase *db;
    FMDatabase *dbTwo;
//    FMDatabase *dbThree;
    BOOL localData;
    BOOL needRefeashCleanPic;
    BOOL needRefeashCleanPic1;
    BOOL needRefeashCleanPic2;

    NSInteger voteIndex;
}
@property(nonatomic,strong)        NSString* style;
@property(nonatomic,strong)        NSString* _hidden;

-(void)selectImage:(NSInteger)_index;
-(void)selectVote:(NSInteger)_index;

@end
