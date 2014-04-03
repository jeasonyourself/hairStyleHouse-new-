//
//  findStyleDetailViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-4.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hairStyleCategoryScanImageCell.h"
#import "MJPhotoBrowser.h"
#import "FMDatabase.h"
@class AllAroundPullView;
@interface findStyleDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * topImage;
    UIButton * oneButton;
    UIButton * twoButton;
    UITableView *myTableView;
    UIActivityIndicatorView * _activityIndicatorView ;
    AllAroundPullView *bottomRefreshView;

//    NSMutableArray * dresserArray;
    NSMutableArray * localDresserArray;

//    NSMutableArray * cleandresserArray;
    NSMutableArray * localcleanDresserArray;

    NSMutableArray * localDresserArray1;
    NSMutableArray * localcleanDresserArray1;
    
//    NSMutableArray * dresserArray1;
//    NSMutableArray * cleandresserArray1;

    NSString * page;
    NSString * page1;
    NSString * pageCount;
    NSString * pageCount1;
    NSString * sign;

    NSString* style;
    
    MJPhotoBrowser *browser;
    
//    FMDatabase *db;
//    FMDatabase *dbTwo;
//
//    BOOL localData;

}
@property(nonatomic,strong)        NSString* style;
@property(nonatomic,strong)        NSString* bcid;
@property(nonatomic,strong)        NSString* scid;



-(void)selectImage:(NSInteger)_index;

@end
