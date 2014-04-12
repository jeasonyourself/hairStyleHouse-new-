//
//  dresserViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "AllAroundPullView.h"
#import "BaiduMobStat.h"
@interface dresserViewController ()

@end

@implementation dresserViewController
@synthesize fromFouceLoginCancel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
        Lab.text = @"发型师";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
//    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
//    [topImage setImage:[UIImage imageNamed:@"全部.png"]];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 60)];
    [topImage setImage:[UIImage imageNamed:@"未选择默认.png"]];
    topImage.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    topImage.layer.cornerRadius = 0;//设置那个圆角的有多圆
    topImage.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, topImage.frame.origin.y, 160, topImage.frame.size.height);
    oneButton.layer.cornerRadius = 0;//设置那个圆角的有多圆
    oneButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    oneButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    oneButton.layer.masksToBounds = YES;//设为NO去试试
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(160,topImage.frame.origin.y, 160, topImage.frame.size.height);
    twoButton.layer.cornerRadius = 0;//设置那个圆角的有多圆
    twoButton.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    twoButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    twoButton.layer.masksToBounds = YES;//设为NO去试试
    twoButton.backgroundColor = [UIColor clearColor];
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = oneButton.frame;
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    forthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forthButton.frame = twoButton.frame;
    forthButton.backgroundColor = [UIColor clearColor];
    [forthButton addTarget:self action:@selector(forthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    fifthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fifthButton.frame = oneButton.frame;
    fifthButton.backgroundColor = [UIColor clearColor];
    [fifthButton addTarget:self action:@selector(fifthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    sixthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sixthButton.frame = twoButton.frame;
    sixthButton.backgroundColor = [UIColor clearColor];
    [sixthButton addTarget:self action:@selector(sixthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    
    [oneButton setTitle:@"服务项" forState:UIControlStateNormal];
    [twoButton setTitle:@"排序" forState:UIControlStateNormal];
//    [thirdButton setTitle:@"染发" forState:UIControlStateNormal];
//    [forthButton setTitle:@"护理" forState:UIControlStateNormal];

    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
//    [self.view addSubview:thirdButton];
//    [self.view addSubview:forthButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];
    dresserArray2 =[[NSMutableArray alloc] init];
    dresserArray3 =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page1 =[[NSString alloc] init];
    page2 =[[NSString alloc] init];
    page3 =[[NSString alloc] init];
    page=@"1";
    page1=@"1";
    page2=@"1";
    page3=@"1";
    pageCount=[[NSString alloc] init];
    pageCount1=[[NSString alloc] init];
    pageCount2=[[NSString alloc] init];
    pageCount3=[[NSString alloc] init];

    sign =[[NSString alloc] init];
    fromFouceLoginCancel=[[NSString alloc] init];
    sign = @"all";
    fromFouceLoginCancel=@"all";
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, topImage.frame.origin.y+topImage.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    
    categryOneArr = [[NSMutableArray alloc] initWithObjects:@"默认",@"洗剪吹",@"冷烫",@"数码烫",@"烫发",@"染发",@"挑染",@"护理",@"盘发",@"剪发",@"离子烫", nil];
    
    categryTwoArr = [[NSMutableArray alloc] initWithObjects:@"默认",@"价格↑ ",@"价格↓",@"距离↑", nil];
    serviceStr  = [[NSString alloc] initWithFormat:@"洗剪吹"];
    sortStr = [[NSString alloc] initWithFormat:@"0"];
    categryOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
//    categryOne.backgroundColor = [UIColor blackColor];
//    categryOne.alpha=0.2;
    categryBackOne= [[UIView alloc] initWithFrame:CGRectMake(0, oneButton.frame.size.height+oneButton.frame.origin.y, self.view.frame.size.width,  self.view.frame.size.height/2+100)];
    categryBackOne.backgroundColor = [UIColor colorWithRed:239.0/256.0 green:239.0/256.0 blue:239.0/256.0 alpha:1.0];
    categryBackOne1= [[UIView alloc] initWithFrame:CGRectMake(0, categryBackOne.frame.size.height+categryBackOne.frame.origin.y, self.view.frame.size.width,  self.view.frame.size.height-categryBackOne.frame.size.height-categryBackOne.frame.origin.y)];
    categryBackOne1.backgroundColor = [UIColor blackColor];
    categryBackOne1.alpha=0.2;
    clearButtonOne = [[UIButton alloc] initWithFrame:categryOne.frame];
    [clearButtonOne addTarget:self action:@selector(categoryButtonOneClick) forControlEvents:UIControlEventTouchDown];
    categryTableOne=[[UITableView alloc] initWithFrame:CGRectMake(0, oneButton.frame.size.height+oneButton.frame.origin.y, 160, categryBackOne.frame.size.height-25) style:UITableViewStylePlain];
    categryTableOne.layer.cornerRadius = 0;//设置那个圆角的有多圆
    categryTableOne.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    categryTableOne.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    categryTableOne.layer.masksToBounds = YES;//设为NO去试试
    categryTableOne.allowsSelection=YES;
    [categryTableOne setSeparatorInset:UIEdgeInsetsZero];
    categryTableOne.dataSource=self;
    categryTableOne.delegate=self;
    categryTableOne.backgroundColor=[UIColor whiteColor];
    [categryOne addSubview:categryBackOne];
    [categryOne addSubview:categryBackOne1];
    [categryOne addSubview:clearButtonOne];
    [categryOne addSubview:categryTableOne];
    [categryOne addSubview:thirdButton];
    [categryOne addSubview:forthButton];
    [self.view addSubview:categryOne];
    
    
    
    categryTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,  self.view.frame.size.height)];
    categryTwo.backgroundColor = [UIColor clearColor];
    categryBacktwo= [[UIView alloc] initWithFrame:CGRectMake(0, twoButton.frame.size.height+twoButton.frame.origin.y, self.view.frame.size.width,  self.view.frame.size.height/2+100)];
    categryBacktwo.backgroundColor = [UIColor colorWithRed:239.0/256.0 green:239.0/256.0 blue:239.0/256.0 alpha:1.0];
    categryBacktwo1= [[UIView alloc] initWithFrame:CGRectMake(0, categryBacktwo.frame.size.height+categryBacktwo.frame.origin.y, self.view.frame.size.width,  self.view.frame.size.height-categryBacktwo.frame.size.height-categryBacktwo.frame.origin.y)];
    categryBacktwo1.backgroundColor = [UIColor blackColor];
    categryBacktwo1.alpha=0.2;
    clearButtonTwo = [[UIButton alloc] initWithFrame:categryTwo.frame];
    [clearButtonTwo addTarget:self action:@selector(clearButtonTwoClick) forControlEvents:UIControlEventTouchDown];
    categryTableTwo=[[UITableView alloc] initWithFrame:CGRectMake(160, twoButton.frame.size.height+twoButton.frame.origin.y, 160, self.view.frame.size.height/2-45) style:UITableViewStylePlain];
    categryTableTwo.allowsSelection=YES;
    [categryTableTwo setSeparatorInset:UIEdgeInsetsZero];
    categryTableTwo.dataSource=self;
    categryTableTwo.delegate=self;
    categryTableTwo.backgroundColor=[UIColor whiteColor];
    [categryTwo addSubview:categryBacktwo];
    [categryTwo addSubview:categryBacktwo1];

    [categryTwo addSubview:clearButtonTwo];
    [categryTwo addSubview:categryTableTwo];
    [categryTwo addSubview:fifthButton];
    [categryTwo addSubview:sixthButton];
//    categryTwo.hidden = YES;
    [self.view addSubview:categryTwo];
    
    categryOne.hidden=YES;
    categryTwo.hidden=YES;
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    if (appDele.uid)
//    {
    [self getData];
//    [self getData1];
//    [self getData2];
//    [self getData3];
//    }
//    else
//    {
//        [self getData];
//        [self getData1];
//        [self getData2];
//    }
}


-(void)categoryButtonOneClick
{
   
        categryOne.hidden=YES;

    
}
-(void)clearButtonTwoClick
{
   
        categryTwo.hidden=YES;
   
}
#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"发型师"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"发型师"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)pullLoadMore
{
//        if ([sign isEqualToString:@"all"])
//        {
            NSInteger _pageCount= [pageCount integerValue];

           NSInteger _page = [page integerValue];
            if (_page<_pageCount) {
                _page++;
                page = [NSString stringWithFormat:@"%d",_page];
                NSLog(@"page:%@",page);
                [self getData];
            }
            else
            {
                [bottomRefreshView performSelector:@selector(finishedLoading)];
                
            }

//        }
//        else if([sign isEqualToString:@"sameCity"])
//        {
//            NSInteger _pageCount1= [pageCount1 integerValue];
//
//            NSInteger _page = [page1 integerValue];
//            if (_page<_pageCount1) {
//                _page++;
//                page1 = [NSString stringWithFormat:@"%d",_page];
//                NSLog(@"page1:%@",page1);
//                [self getData1];
//            }
//            else
//            {
//                [bottomRefreshView performSelector:@selector(finishedLoading)];
//                
//            }
//
//
//        }
//        else if([sign isEqualToString:@"introduce"])
//        {
//            NSInteger _pageCount2= [pageCount2 integerValue];
//
//            NSInteger _page = [page2 integerValue];
//            if (_page<_pageCount2) {
//                _page++;
//                page2 = [NSString stringWithFormat:@"%d",_page];
//                NSLog(@"page:%@",page2);
//                [self getData2];
//            }
//            else
//            {
//                [bottomRefreshView performSelector:@selector(finishedLoading)];
//                
//            }
//
//        }
//        else if([sign isEqualToString:@"fouce"])
//        {
//            NSInteger _pageCount3= [pageCount3 integerValue];
//
//            NSInteger _page = [page3 integerValue];
//            if (_page<_pageCount3) {
//                _page++;
//                page3 = [NSString stringWithFormat:@"%d",_page];
//                NSLog(@"page:%@",page3);
//                [self getData3];
//            }
//            else
//            {
//                [bottomRefreshView performSelector:@selector(finishedLoading)];
//                
//            }
//
//        }
}

//-(void)viewDidAppear:(BOOL)animated
//{
//  
//}
-(void)refreashNav
{
    rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    rightButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    rightButton.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    rightButton.layer.masksToBounds = YES;//设为NO去试试
    
    rightButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
    rightButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    rightButton.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    rightButton.layer.masksToBounds = YES;//设为NO去试试
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    cityStr = [[NSString alloc] init];
    lonStr = [[NSString alloc] init];
    latStr = [[NSString alloc] init];

    if (appDele.city) {
        [rightButton setTitle:appDele.city forState:UIControlStateNormal];
        cityStr=appDele.city;
        lonStr=[NSString stringWithFormat:@"%f",appDele.longitude];

        latStr=[NSString stringWithFormat:@"%f",appDele.latitude];

    }
    else
    {
    [rightButton setTitle:@"选择城市" forState:UIControlStateNormal];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位失败，请通过右上方按钮自定义城市" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    [rightButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)rightButtonClick
{
    rightButton.enabled=NO;
    oneButton.enabled=NO;
    twoButton.enabled=NO;
    thirdButton.enabled=NO;
    forthButton.enabled=NO;

    locateView = [[TSLocateView alloc] initWithTitle:@"选择城市" delegate:self];
    [locateView showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    rightButton.enabled=YES;
    oneButton.enabled=YES;
    twoButton.enabled=YES;
    thirdButton.enabled=YES;
    forthButton.enabled=YES;
    
    locateView = (TSLocateView *)actionSheet;
    TSLocation *location = locateView.locate;
    NSLog(@"city:%@ lat:%f lon:%f", location.city, location.latitude, location.longitude);
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        cityStr =[NSString stringWithFormat:@"%@市",location.city] ;
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        if (appDele.city)
        {
            lonStr=[NSString stringWithFormat:@"%f",appDele.longitude];
            
            latStr=[NSString stringWithFormat:@"%f",appDele.latitude];
            
        }
        else
        {
        lonStr=[NSString stringWithFormat:@"%f",location.longitude];
        
        latStr=[NSString stringWithFormat:@"%f",location.latitude];
        }
        [rightButton setTitle:cityStr forState:UIControlStateNormal];
        
            if (dresserArray!=nil)
            {
                [dresserArray removeAllObjects];
            }
        page=@"1";
        [self getData];
        NSLog(@"Select");
    }
}

-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    oneButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    twoButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    
    if (categryOne.hidden==YES) {
        [topImage setImage:[UIImage imageNamed:@"选择服务.png"]];
        categryOne.hidden=NO;
    }
    else
    {
        [topImage setImage:[UIImage imageNamed:@"未选择默认.png"]];
        categryOne.hidden=YES;
        
    }
    //    [requestMain clearDelegatesAndCancel];
    sign =@"all";
    fromFouceLoginCancel=@"all";
//    [myTableView reloadData];
//    page=@"1";
////    [dresserArray removeAllObjects];
//    [self getData];
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [requestMain clearDelegatesAndCancel];
    
    twoButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    oneButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色

    
    if (categryTwo.hidden==YES) {
        categryTwo.hidden=NO;
        [topImage setImage:[UIImage imageNamed:@"选择排序.png"]];
    }
    else
    {
        categryTwo.hidden=YES;
        [topImage setImage:[UIImage imageNamed:@"未选择默认.png"]];
        
    }

    sign =@"sameCity";
    fromFouceLoginCancel=@"sameCity";
//    [myTableView reloadData];

//    page1=@"1";
////    [dresserArray1 removeAllObjects];
//    [self getData1];
}
-(void)thirdButtonClick
{
    
   
    if (categryOne.hidden==YES) {
        categryOne.hidden=NO;
        [topImage setImage:[UIImage imageNamed:@"选择服务.png"]];
        
    }
    else
    {
        categryOne.hidden=YES;
        [topImage setImage:[UIImage imageNamed:@"未选择默认.png"]];
        
    }
            categryTwo.hidden=YES;
    
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    oneButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    twoButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
   
//    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]forState:UIControlStateNormal];
//    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    
//
//    sign =@"introduce";
//    fromFouceLoginCancel=@"introduce";
//    [myTableView reloadData];


}
-(void)forthButtonClick
{
    
    [topImage setImage:[UIImage imageNamed:@"选择排序.png"]];
    
    categryOne.hidden = YES;
   
    categryTwo.hidden=NO;
    
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    twoButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    oneButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
  
//    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [forthButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//
//    sign =@"fouce";
//
//        [myTableView reloadData];

    
}
-(void)fifthButtonClick

{
    
    [topImage setImage:[UIImage imageNamed:@"选择服务.png"]];
    categryOne.hidden=NO;
    categryTwo.hidden=YES;
    
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    oneButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    twoButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    
}
-(void)sixthButtonClick
{
    
    categryOne.hidden = YES;
    
    if (categryTwo.hidden==YES) {
        categryTwo.hidden=NO;
        
        [topImage setImage:[UIImage imageNamed:@"选择排序.png"]];
        
    }
    else
    {
        categryTwo.hidden=YES;
        [topImage setImage:[UIImage imageNamed:@"未选择默认.png"]];
        
    }
    
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    twoButton.layer.borderColor =[ [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    oneButton.layer.borderColor =[ [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    
}
//-(void)fromFouceCancelBack:(NSString *)_str
//{
//    
//    if ([fromFouceLoginCancel isEqualToString:@"all"]) {
//        [self oneButtonClick];
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"sameCity"])
//    {
//        [self twoButtonClick];
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"introduce"])
//    {
//        [self thirdButtonClick];
//    }
//    NSLog(@"fromFouceLoginCancel:%@",fromFouceLoginCancel);
//    sign=_str;
//    page=@"1";
//    if ([fromFouceLoginCancel isEqualToString:@"all"]) {
//        
//        [topImage setImage:[UIImage imageNamed:@"全部.png"]];
//        [self getDataback];
//        
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"sameCity"])
//    {
//        [topImage setImage:[UIImage imageNamed:@"同城1.png"]];
//        [self getDataback];
//    }
//    else if ([fromFouceLoginCancel isEqualToString:@"introduce"])
//    {
//        [topImage setImage:[UIImage imageNamed:@"推荐.png"]];
//        
//        [self getDataback];
//    }
    
   
//}

//-(void)getDataback
//{
//    [dresserArray removeAllObjects];
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    //    if (appDele.uid) {
//    
//    if ([fromFouceLoginCancel isEqualToString:@"all"])
//    {
//        //            page=@"2";
//        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=allstylists&page=%@",page]]];
//    }
//    else if([fromFouceLoginCancel isEqualToString:@"sameCity"])
//    {
//        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page]]];
//        [requestMain setPostValue:appDele.city forKey:@"city"];
//        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
//        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
//    }
//    else if([fromFouceLoginCancel isEqualToString:@"introduce"])
//    {
//        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page]]];
//    }
//    requestMain.delegate=self;
//    requestMain.tag=1;
//    
//    if (appDele.uid) {
//        [requestMain setPostValue:appDele.uid forKey:@"uid"];
//    }
//    else
//    {
//        
//    }
//    [requestMain startAsynchronous];
//    //    }
//    
//}

//-(void)getDataback2
//{
//    [self getData3];
////    page=@"1";
////    [dresserArray removeAllObjects];
////    page1=@"1";
////    [dresserArray1 removeAllObjects];
////    page2=@"1";
////    [dresserArray2 removeAllObjects];
////    page3=@"1";
////    [dresserArray3 removeAllObjects];
////    [self getData];
//}

-(void)getData
{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
        requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=goods&a=hairStylistList&page=%@",page]]];
        requestMain.delegate=self;
        requestMain.tag=100;
    
        [requestMain setPostValue:cityStr forKey:@"city"];
        [requestMain setPostValue:lonStr forKey:@"lng"];
        [requestMain setPostValue:latStr forKey:@"lat"];
    [requestMain setPostValue:serviceStr forKey:@"service"];
    [requestMain setPostValue:sortStr forKey:@"sort"];
    
    
        [requestMain startAsynchronous];
  
}

//-(void)getData1
//{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    //    if (appDele.uid) {
//            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page1]]];
//        [requestMain setPostValue:appDele.city forKey:@"city"];
//        NSLog(@"city:%@",appDele.city);
//        
//        NSLog(@"%f",appDele.longitude);
//        NSLog(@"%f",appDele.latitude);
//        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
//        [requestMain setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
//        requestMain.delegate=self;
//        requestMain.tag=101;
//        
//        if (appDele.uid) {
//            [requestMain setPostValue:appDele.uid forKey:@"uid"];
//        }
//        else
//        {
//            
//        }
//        [requestMain startAsynchronous];
//    
//}

//-(void)getData2
//{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page2]]];
//        requestMain.delegate=self;
//        requestMain.tag=102;
//        
//        if (appDele.uid) {
//            [requestMain setPostValue:appDele.uid forKey:@"uid"];
//        }
//        else
//        {
//            
//        }
//        [requestMain startAsynchronous];
//    
//}

//-(void)getData3
//{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//   
//        NSLog(@"appDele.uid:%@",appDele.uid);
//        
//      
//            requestMain=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=followstylists&page=%@",page3]]];
//            requestMain.delegate=self;
//            requestMain.tag=103;
//            
//            if (appDele.uid)
//            {
//                [requestMain setPostValue:appDele.uid forKey:@"uid"];
//            }
//            else
//            {
//                
//            }
//            [requestMain startAsynchronous];
//}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * arr;
    if ([page isEqualToString:@"1"]) {
        [dresserArray removeAllObjects];
    }
//    if (dresserArray!=nil) {
//        arr= [NSMutableArray arrayWithArray:dresserArray];
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==100) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        
        pageCount = [dic objectForKey:@"page_count"];
        
            if ([[dic objectForKey:@"userList"] isKindOfClass:[NSString class]])
            {
                [dresserArray removeAllObjects];
            }
            else if ([[dic objectForKey:@"userList"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"userList"];
                [dresserArray addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray.count);
                
               /* if ([[[dresserArray objectAtIndex:0] objectForKey:@"works_list"] isKindOfClass:[NSString class]])
                {
                    
                }
                else if ([[[dresserArray objectAtIndex:0] objectForKey:@"works_list"] isKindOfClass:[NSArray class]])
                {
                    
                }*/
            
            }
        [self freashView];

        }
//    else if (request.tag==101)
//    {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//        
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"发型师dic:%@",dic);
//        
//        pageCount1 = [dic objectForKey:@"page_count"];
//        
//            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
//            {
//                
//            }
//            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
//            {
//                arr= [dic objectForKey:@"user_info"];
//                [dresserArray1 addObjectsFromArray:arr];
//                NSLog(@"dresser.count:%d",dresserArray1.count);
//                
//            }
//[self freashView];
//        
//    }
//    else if (request.tag==102)
//    {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//        
//        NSLog(@"%@",jsonString);
//
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"发型师dic:%@",dic);
//        
//        pageCount2 = [dic objectForKey:@"page_count"];
//    
//            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
//            {
//                
//            }
//            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
//            {
//                arr= [dic objectForKey:@"user_info"];
//                [dresserArray2 addObjectsFromArray:arr];
//                NSLog(@"dresser.count:%d",dresserArray2.count);
//                
//            }
//[self freashView];
//    }
//    else if (request.tag==103)
//    {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//        
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"发型师dic:%@",dic);
//        
//        pageCount3 = [dic objectForKey:@"page_count"];
//        
//            if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
//            {
//                
//            }
//            else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
//            {
//                arr= [dic objectForKey:@"user_info"];
//                [dresserArray3 addObjectsFromArray:arr];
//                NSLog(@"dresser.count:%d",dresserArray3.count);
//                
//            }
//        [self freashView];
//
//    }
//    if (request.tag==2) {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"是否关注成功dic:%@",dic);
//        
//        [myTableView reloadData];
//        //            if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
//        //            {
//        //
//        //            }
//        //            else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
//        //            {
//        //                dresserArray = [dic objectForKey:@"message_list"];
//        //
//        //            }
//        
////        [self getData];
//    }
    
}
-(void)freashView
{
    [bottomRefreshView performSelector:@selector(finishedLoading)];
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if ([sign isEqualToString:@"all"])
//    {
//        return dresserArray.count;
//
//    }
//    else if([sign isEqualToString:@"sameCity"])
//    {
//        return dresserArray1.count;
//
//    }
//    else if([sign isEqualToString:@"introduce"])
//    {
//        return dresserArray2.count;
//
//    }
//    else if([sign isEqualToString:@"fouce"])
//    {
//        return dresserArray3.count;
//
//    }
    if (tableView==categryTableOne) {
        return categryOneArr.count;
    }
    else if (tableView==categryTableTwo)
    {
        return categryTwoArr.count;
    }
    else
    {
           return dresserArray.count;
    }
 

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==categryTableOne) {
        return 60;
    }
    else if (tableView==categryTableTwo) {
        return 60;
    }

    else
    {
        
        if (dresserArray.count==0) {
            return myTableView.frame.size.height;
        }
        else{
        NSString *_content;
        
        _content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
        
        
        UIFont *font = [UIFont systemFontOfSize:12.0];
        //设置一个行高上限
        CGSize size = CGSizeMake(260,200);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        
        if ([_content isEqualToString:@""]&&[[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
        {
            return   100;
        }
        else if (![_content isEqualToString:@""]&&[[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
        {
            return 100+labelsize.height;
        }
        else if ([_content isEqualToString:@""]&&[[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"worksInfo"] isKindOfClass:[NSArray class]])
        {
            return 80+120;
        }
        else
        {
            return 80+labelsize.height+120;
        }
    }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView==categryTableOne) {
        static NSString *cellID=@"cell";
        UITableViewCell *cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
        
        cell.textLabel.text = [categryOneArr objectAtIndex:row];
        
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        return cell;

    }
    else if (tableView==categryTableTwo)
    {
        static NSString *cellID=@"cell";
        UITableViewCell *cell=(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            //            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
        
        cell.textLabel.text = [categryTwoArr objectAtIndex:row];
        cell.textLabel.textAlignment=NSTextAlignmentCenter;

        
        return cell;

    }
    else
    {
        static NSString *cellID=@"cell";
        dresserCell *cell=(dresserCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[dresserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherController=self;
        }
        
        NSInteger row =[indexPath row];
        //    if ([sign isEqualToString:@"all"])
        //    {
        [cell setCell:dresserArray  andIndex:row andSign:sign];
        
        //    }
        //    else if([sign isEqualToString:@"sameCity"])
        //    {
        //        [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
        //
        //    }
        //    else if([sign isEqualToString:@"introduce"])
        //    {
        //        [cell setCell:[dresserArray2 objectAtIndex:row] andIndex:row];
        //
        //    }
        //    else if([sign isEqualToString:@"fouce"])
        //    {
        //        [cell setCell:[dresserArray3 objectAtIndex:row] andIndex:row];
        //        
        //    }
        
        return cell;
    }
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //查看发型师
    if (tableView == categryTableOne) {
        [oneButton setTitle:[categryOneArr objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
        categryOne.hidden=YES;
        if ([indexPath row]==0) {
            serviceStr  = @"洗剪吹";
                    }
        if ([serviceStr isEqualToString:[categryOneArr objectAtIndex:[indexPath row]]]) {
            
        }
        else
        {
        serviceStr=[categryOneArr objectAtIndex:[indexPath row]];
            if ([indexPath row]==0) {
                serviceStr  = @"洗剪吹";
            }
        page=@"1";
        [self getData];
        }
    }
    else if (tableView == categryTableTwo) {
        [twoButton setTitle:[categryTwoArr objectAtIndex:[indexPath row]] forState:UIControlStateNormal];
        categryTwo.hidden=YES;
        
        if ([indexPath row]!=0) {
            twoButton.titleLabel.textAlignment=NSTextAlignmentLeft;
        }
        else
        {
        twoButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        }
        
        if ([indexPath row]==0) {
            sortStr = @"0";
        }
        if ([sortStr isEqualToString:[NSString stringWithFormat:@"%d",[indexPath row]]]) {
            
        }
        else
        {
            sortStr = [NSString stringWithFormat:@"%d",[indexPath row]];
            if ([indexPath row]==0) {
                sortStr = @"0";
            }
            page=@"1";
            [self getData];
        }

       
    }
    
    
}

-(void)selectCell:(NSInteger)_index
{
    
    rightButton.enabled=YES;
    oneButton.enabled=YES;
    twoButton.enabled=YES;
    thirdButton.enabled=YES;
    forthButton.enabled=YES;
    [locateView removeFromSuperview];

    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView._hidden=@"yes";
        loginView.view.frame=self.view.bounds;
//        [loginView getBack:self andSuc:@selector(getDataback2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        [appDele pushToViewController:loginView ];
    }
    else
    {

        dreserView =nil;
        dreserView =[[dresserInforViewController alloc] init];
        dreserView._hidden=@"yes";
//        if ([sign isEqualToString:@"all"])
//        {
            dreserView.uid = [[dresserArray objectAtIndex:_index ] objectForKey:@"uid"];
//        }
//        else if([sign isEqualToString:@"sameCity"])
//        {
//            dreserView.uid = [[dresserArray1 objectAtIndex:_index ] objectForKey:@"uid"];
//        }
//        else if([sign isEqualToString:@"introduce"])
//        {
//            dreserView.uid = [[dresserArray2 objectAtIndex:_index ] objectForKey:@"uid"];
//        }
//        else if([sign isEqualToString:@"fouce"])
//        {
//            dreserView.uid = [[dresserArray3 objectAtIndex:_index ] objectForKey:@"uid"];
//        }
        NSLog(@"%@", dreserView.uid);
        if (![dreserView.uid isEqualToString:appDele.uid])
        {
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:dreserView ];
        }
      
    }
}

-(void)didFouce:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"yes";

        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView.view.frame=self.view.bounds;
//        [loginView getBack:self andSuc:@selector(getDataback2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
        
    }
    else
    {
        //新版跳转到预约发型师界面
        if ([appDele.type isEqualToString:@"2"]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"预约失败" message:@"发型师不可预约" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        else
        {
        addBeaspeakView = nil;
        addBeaspeakView = [[addBeaspeakViewController alloc] init];
        addBeaspeakView._hidden=@"yes";
        addBeaspeakView.inforDic=[dresserArray objectAtIndex:_index];

        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        if (![[[dresserArray objectAtIndex:_index] objectForKey:@"uid"] isEqualToString:appDele.uid])
        {
        [appDele pushToViewController:addBeaspeakView ];
        }
            
        }
//        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]]];
//        request.delegate=self;
//        request.tag=2;
       
        
//        if ([sign isEqualToString:@"all"])
//        {
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
//            [request setPostValue:appDele.type forKey:@"type"];
//            [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
//            if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
//                [request setPostValue:@"0" forKey:@"status"];
//            }
//            else
//            {
//                [request setPostValue:@"1" forKey:@"status"];
//            }
//            
//            if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
//            {
//                if ([[dresserArray objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray objectAtIndex:_index ]];
//                    [dict setObject:@"0" forKey:@"isconcerns"];
//                    [dresserArray replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//            else
//            {
//                if ([[dresserArray objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray objectAtIndex:_index ]];
//                    [dict setObject:@"1" forKey:@"isconcerns"];
//                    [dresserArray replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//            
//        }
//        else if([sign isEqualToString:@"sameCity"])
//        {
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            [request setPostValue:[[dresserArray1 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
//            [request setPostValue:appDele.type forKey:@"type"];
//            [request setPostValue:[[dresserArray1 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
//            if ([[[dresserArray1 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
//                [request setPostValue:@"0" forKey:@"status"];
//            }
//            else
//            {
//                [request setPostValue:@"1" forKey:@"status"];
//            }
//
//            if ([[[dresserArray1 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
//            {
//                if ([[dresserArray1 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray1 objectAtIndex:_index ]];
//                    [dict setObject:@"0" forKey:@"isconcerns"];
//                    [dresserArray1 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//            else
//            {
//                if ([[dresserArray1 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray1 objectAtIndex:_index ]];
//                    [dict setObject:@"1" forKey:@"isconcerns"];
//                    [dresserArray1 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//
//        }
//        else if([sign isEqualToString:@"introduce"])
//        {
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            [request setPostValue:[[dresserArray2 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
//            [request setPostValue:appDele.type forKey:@"type"];
//            [request setPostValue:[[dresserArray2 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
//            if ([[[dresserArray2 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
//                [request setPostValue:@"0" forKey:@"status"];
//            }
//            else
//            {
//                [request setPostValue:@"1" forKey:@"status"];
//            }
//
//            if ([[[dresserArray2 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
//            {
//                if ([[dresserArray2 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray2 objectAtIndex:_index ]];
//                    [dict setObject:@"0" forKey:@"isconcerns"];
//                    [dresserArray2 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//            else
//            {
//                if ([[dresserArray2 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray2 objectAtIndex:_index ]];
//                    [dict setObject:@"1" forKey:@"isconcerns"];
//                    [dresserArray2 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//
//        }
//        else if([sign isEqualToString:@"fouce"])
//        {
//            [request setPostValue:appDele.uid forKey:@"uid"];
//            [request setPostValue:[[dresserArray3 objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
//            [request setPostValue:appDele.type forKey:@"type"];
//            [request setPostValue:[[dresserArray3 objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
//            if ([[[dresserArray3 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
//                [request setPostValue:@"0" forKey:@"status"];
//            }
//            else
//            {
//                [request setPostValue:@"1" forKey:@"status"];
//            }
//
//            if ([[[dresserArray3 objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"])
//            {
//                if ([[dresserArray3 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray3 objectAtIndex:_index ]];
//                    [dict setObject:@"0" forKey:@"isconcerns"];
//                    [dresserArray3 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//            else
//            {
//                if ([[dresserArray3 objectAtIndex:_index ]isKindOfClass:[NSDictionary class]])
//                {
//                    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:[dresserArray3 objectAtIndex:_index ]];
//                    [dict setObject:@"1" forKey:@"isconcerns"];
//                    [dresserArray3 replaceObjectAtIndex:_index withObject:dict];
//                }
//            }
//
//        }
//        
//        [request startAsynchronous];
    }
}

-(void)selectImage:(NSInteger)_index
{
    scanView=nil;
    scanView = [[scanImageViewController alloc] init];
    scanView.uid=[[dresserArray objectAtIndex:_index] objectForKey:@"uid"];
    scanView._hidden = @"yes";

    scanView.worksOrsaveorCan = @"works";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    [appDele pushToViewController:scanView ];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
