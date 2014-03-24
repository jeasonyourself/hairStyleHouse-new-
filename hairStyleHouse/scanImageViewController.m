//
//  scanImageViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanImageViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "BaiduMobStat.h"
@interface scanImageViewController ()

@end

@implementation scanImageViewController
@synthesize worksOrsaveorCan;
//@synthesize selfOrOther;
@synthesize uid;
@synthesize _hidden;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
//    self.view.backgroundColor = [UIColor blackColor];
//    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
//    dresserArray =[[NSMutableArray alloc] init];
//    cleandresserArray =[[NSMutableArray alloc] init];

    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    
    localData = YES;
    //数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSString *dbPath;
   
       dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@MyDatabase.db",uid,worksOrsaveorCan]];
        
        

    db = [FMDatabase databaseWithPath:dbPath] ;
    
    if (![db open]) {
        
        NSLog(@"Could not open db.");
        
    }
    
//    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) ];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
//    myTableView.backgroundColor=[UIColor redColor];
    [self freashView];//直接本地
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view)
    {
        NSLog(@"loadMore");
        [self pullLoadMore];
            myTableView.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) ;
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    NSLog(@"self.view1:%@",NSStringFromCGRect(self.view.frame));

    NSLog(@"mytable.frame1:%@",NSStringFromCGRect(myTableView.frame));
    
    [self getData];
    
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
    _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
    //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
    _activityIndicatorView.color = [UIColor grayColor];
    //设置活动指示器的颜色
    _activityIndicatorView.hidesWhenStopped = NO;
    //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
    [self.view addSubview:_activityIndicatorView];
    //将对象加入到view
    
    [_activityIndicatorView startAnimating];
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName ;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
    {
        if ([self.uid isEqualToString:appDele.uid]) {
            cName = [NSString stringWithFormat:@"我的作品"];
        }
        else
        {
            cName = [NSString stringWithFormat:@"他的作品"];

        }
        
    }
    else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
    {
        cName = [NSString stringWithFormat:@"会做作品"];

    }
    
    else//收藏作品
    {
        cName = [NSString stringWithFormat:@"收藏作品"];

    }

    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName ;
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
    {
        if ([self.uid isEqualToString:appDele.uid]) {
            cName = [NSString stringWithFormat:@"我的作品"];
        }
        else
        {
            cName = [NSString stringWithFormat:@"他的作品"];
            
        }
        
    }
    else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
    {
        cName = [NSString stringWithFormat:@"会做作品"];
        
    }
    
    else//收藏作品
    {
        cName = [NSString stringWithFormat:@"收藏作品"];
        
    }
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)pullLoadMore
{
    NSInteger _pageCount= [pageCount integerValue];
    
    FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
    while ([rs next]) {
        page  = [rs stringForColumn:@"Page"];
    }
    
    [rs close];
    NSInteger _page = [page integerValue];
    
    NSLog(@"page:%@",page);
    NSLog(@"pageCount:%@",pageCount);
    
    if (_page<_pageCount) {
        _page++;
        page = [NSString stringWithFormat:@"%d",_page];
        NSLog(@"page:%@",page);
        localData = NO;
        [self getData];
    }
    else
    {
        [bottomRefreshView performSelector:@selector(finishedLoading)];
    }
    
    NSLog(@"self.view2:%@",NSStringFromCGRect(self.view.frame));

    NSLog(@"mytable.frame2:%@",NSStringFromCGRect(myTableView.frame));

}
    -(void)refreashNav
    {
        UIButton * leftButton=[[UIButton alloc] init];
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton.layer setMasksToBounds:YES];
        [leftButton.layer setCornerRadius:3.0];
        [leftButton.layer setBorderWidth:1.0];
        [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [leftButton setBackgroundColor:[UIColor clearColor]];
        [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame = CGRectMake(0,28, 60, 25);
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem=leftButtonItem;
    }

-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden=YES;
        
    }
    else
    {
        self.navigationController.navigationBar.hidden=NO;
        
    }
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)refreashNavLab
    {
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
        if ([worksOrsaveorCan isEqualToString:@"works"])//自己作品
        {
            if ([self.uid isEqualToString:appDele.uid]) {
                Lab.text = @"我的作品";
            }
            else
            {
                Lab.text = @"他的作品";
            }
            
        }
        else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
        {
            Lab.text = @"会做作品";
        }
        
            else//收藏作品
            {
                Lab.text = @"收藏作品";
            }
            

        
        
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }
    
    
-(void)getData
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        ASIFormDataRequest* request;
//        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        if ([worksOrsaveorCan isEqualToString:@"works"])//原创作品
        {
            
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=workslist&page=%@",page]]];
            
            
        }
        else if ([worksOrsaveorCan isEqualToString:@"can"])//会做作品
        {
            
                request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Willdo&a=willDoList&page=%@",page]]];
            
            
        }
        else//收藏作品
        {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=user&a=collectlist&page=%@",page]]];
        }
        
            request.delegate=self;
        if (localData==YES) {
            request.tag=1;
            
        }
        else
        {
            request.tag=11;
            
        }
       
            [request setPostValue:self.uid forKey:@"uid"];
        [request setPostValue:appDele.secret forKey:@"secret"];
            [request startAsynchronous];

    }
    
-(void)requestFinished:(ASIHTTPRequest *)request
    {
        if (request.tag==1)//左列表
        {
            NSMutableArray * arr;
            NSMutableArray * cleanarr;
            
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            
            NSLog(@"Dic111:%@",dic);
            
            pageCount = [dic objectForKey:@"page_count"];
            if ([worksOrsaveorCan isEqualToString:@"works"]||[worksOrsaveorCan isEqualToString:@"save"])//作品或者收藏返回列表
            
            {
                
            
            if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
            {
                
            }
            else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
            {
                arr= [dic objectForKey:@"works_info"];
                //            [dresserArray addObjectsFromArray:arr];
                //            NSLog(@"dresser.count:%d",dresserArray.count);
                
                //            NSString  *str = [NSString stringWithFormat:@"CREATE TABLE %@%@%@ (Name text, id text, Photo blob)",bcid,scid,sign ]; FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
                
                
                
                NSString *IdString = [db stringForQuery:@"SELECT Id FROM PersonList WHERE Name = ?",@"0"];
                if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
                {
                    
                    
                }
                else//否则更新本地数据库
                {
                    
                    
                    
                    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList"];
                    if (![db executeUpdate:sqlstr])//删除原有数据库
                    {
                        NSLog(@"Delete table error!");
                        
                    }
                    [db executeUpdate:@"CREATE TABLE PersonList (Name text, Id text,Url text,Page text, Photo blob)"];//创建
                    page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                    for (int i = 0; i<arr.count; i++)//重新写入数据库
                    {
                        
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                        BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],page,data];//插入所在数组位置，id，图片
                        if (res == NO)
                        {
                            NSLog(@"插入失败");
                        }
                        else
                        {
                            NSLog(@"插入成功");
                        }
                    }
                }
              }
            }
        
            else//会做列表返回
            {
                    if ([[dic objectForKey:@"willdo_info"] isKindOfClass:[NSString class]])//返回为空
                    {
                        
                    }
                    else if ([[dic objectForKey:@"willdo_info"] isKindOfClass:[NSArray class]])//有返回
                    {
                        arr= [dic objectForKey:@"willdo_info"];
                        //            [dresserArray addObjectsFromArray:arr];
                        //            NSLog(@"dresser.count:%d",dresserArray.count);
                        
                        //            NSString  *str = [NSString stringWithFormat:@"CREATE TABLE %@%@%@ (Name text, id text, Photo blob)",bcid,scid,sign ]; FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
                        
                        
                        
                        NSString *IdString = [db stringForQuery:@"SELECT Id FROM PersonList WHERE Name = ?",@"0"];
                        if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
                        {
                            
                            
                        }
                        else//否则更新本地数据库
                        {
                            
                            
                            
                            NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList"];
                            if (![db executeUpdate:sqlstr])//删除原有数据库
                            {
                                NSLog(@"Delete table error!");
                                
                            }
                            [db executeUpdate:@"CREATE TABLE PersonList (Name text, Id text,Url text,Page text, Photo blob)"];//创建
                            page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                            for (int i = 0; i<arr.count; i++)//重新写入数据库
                            {
                                
                                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                                BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],page,data];//插入所在数组位置，id，图片
                                if (res == NO)
                                {
                                    NSLog(@"插入失败");
                                }
                                else
                                {
                                    NSLog(@"插入成功");
                                }
                            }
                        }
                    
                }
            }
            
            if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
            {
                
            }
            else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
            {
                cleanarr= [dic objectForKey:@"image_list"];
                //            [cleandresserArray addObjectsFromArray:cleanarr];
                //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
                
                
                NSString *IdString = [db stringForQuery:@"SELECT Id FROM PersonList1 WHERE Name = ?",@"0"];
                if ([IdString isEqualToString:[[cleanarr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
                {
                    
                    
                }
                else//否则更新本地数据库
                {
                    
                    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList1"];
                    if (![db executeUpdate:sqlstr])//删除原有数据库
                    {
                        NSLog(@"Delete table error!");
                        
                    }
                    
                    [db executeUpdate:@"CREATE TABLE PersonList1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
                    page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                    for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
                    {
                        
                        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
                        BOOL res =[db executeUpdate:@"INSERT INTO PersonList1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page,data];//插入所在数组位置，id，图片
                        if (res == NO)
                        {
                            NSLog(@"插入失败");
                        }
                        else
                        {
                            NSLog(@"插入成功");
                        }
                    }
                }
                
            }
            
            
            //        [self freashView];
        }
        
        
        else if (request.tag==11)//刷新左列表
        {
            NSMutableArray * arr;
            NSMutableArray * cleanarr;
            
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            
            pageCount = [dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
            {
                
            }
            else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
            {
                arr= [dic objectForKey:@"works_info"];
                //            [dresserArray addObjectsFromArray:arr];
                //            NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList"];
                //            if (![db executeUpdate:sqlstr])//删除原有数据库
                //            {
                //                NSLog(@"Delete table error!");
                //
                //            }
                [db executeUpdate:@"CREATE TABLE PersonList (Name text, Id text,Url text,Page text, Photo blob)"];//创建
                //            page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                for (int i = 0; i<arr.count; i++)//重新写入数据库
                {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                    BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],page,data];//插入所在数组位置，id，图片
                    if (res == NO)
                    {
                        NSLog(@"插入失败");
                    }
                    else
                    {
                        NSLog(@"插入成功");
                    }
                }
                NSLog(@"localDresserArray.count:%d",localDresserArray.count);
            }
            
            if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
            {
                
            }
            else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
            {
                cleanarr= [dic objectForKey:@"image_list"];
                //            [cleandresserArray addObjectsFromArray:cleanarr];
                //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
                [db executeUpdate:@"CREATE TABLE PersonList1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
                for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
                {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
                    BOOL res =[db executeUpdate:@"INSERT INTO PersonList1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page,data];//插入所在数组位置，id，图片
                    if (res == NO)
                    {
                        NSLog(@"插入失败");
                    }
                    else
                    {
                        NSLog(@"插入成功");
                    }
                }
            }
            
            //        [self freashView];
        }
        
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;

        [self freashView];
        
        
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;

     [self freashView];
}

    -(void)freashView
    {
        
        [bottomRefreshView performSelector:@selector(finishedLoading)];
        //1--本地简略图
        FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
        localDresserArray=nil;
        localDresserArray=[[NSMutableArray alloc] init];
        
        while ([rs next]) {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            NSString *name = [rs stringForColumn:@"Name"];
            
            NSString *workId  = [rs stringForColumn:@"Id"];
            NSString *imageUrl = [rs stringForColumn:@"Url"];
            
            
            NSData * imageData = [rs dataForColumn:@"Photo"];
            
            UIImage *aimage =[UIImage imageWithData: imageData];
            
            [dic setObject:name forKey:@"name"];
            [dic setObject:workId forKey:@"work_id"];
            [dic setObject:imageUrl forKey:@"work_image"];
            
            [dic setObject:aimage forKey:@"image"];
            NSLog(@"dic:%@",dic);
            
            [localDresserArray addObject:dic];
        }
        
        [rs close];
        NSLog(@"localDresserArray.count:%d",localDresserArray.count);
        
        //1--本地高清图
        FMResultSet *rs1 = [db executeQuery:@"select * from PersonList1"];
        
        
        //    NSLog(@"[rs next]:%hhd",[rs next]);
        localcleanDresserArray=nil;
        localcleanDresserArray=[[NSMutableArray alloc] init];
        
        while ([rs1 next]) {
            NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
            NSString *name = [rs1 stringForColumn:@"Name"];
            
            NSString *workId  = [rs1 stringForColumn:@"Id"];
            NSString *imageUrl = [rs1 stringForColumn:@"Url"];
            
            
            NSData * imageData = [rs1 dataForColumn:@"Photo"];
            
            UIImage *aimage =[UIImage imageWithData: imageData];
            
            [dic1 setObject:name forKey:@"name"];
            [dic1 setObject:workId forKey:@"work_id"];
            [dic1 setObject:imageUrl forKey:@"work_image"];
            
            [dic1 setObject:aimage forKey:@"image"];
            NSLog(@"dic1:%@",dic1);
            
            [localcleanDresserArray addObject:dic1];
        }
        
        [rs1 close];
        NSLog(@"localDresserArray.count:%d",localcleanDresserArray.count);
        [myTableView reloadData];

    }



    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        return 1;
    }
    
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        
        if (localDresserArray.count%3==0)
        {
            return localDresserArray.count/3;
        }
        else
        {
            return localDresserArray.count/3+1;
        }
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return   165;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellID=@"cell";
        scanCell *cell=(scanCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[scanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherView =self;
        }
        NSUInteger row1 = [indexPath row]*3;
        NSLog(@"row1:%d",row1);
        NSUInteger row2 = [indexPath row]*3+1;
        NSLog(@"row2:%d",row2);
        NSUInteger row3 = [indexPath row]*3+2;
        NSLog(@"row3:%d",row3);
//        cell.backgroundColor = [UIColor blueColor];
        if (row1<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row1] andIndex:row1];
        }
        if (row2<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row2] andIndex:row2];
        }
        if (row3<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row3] andIndex:row3];
        }

    return cell;
    }



-(void)selectImage:(NSInteger)_index
{
    int count = localcleanDresserArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [[localcleanDresserArray[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.work_id =[localcleanDresserArray[i] objectForKey:@"work_id"];
        photo.url = [NSURL URLWithString:url]; // 图片路径
        //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    browser=nil;
    browser = [[MJPhotoBrowser alloc] init];
    NSInteger reallIndex;
    NSString * str = [localDresserArray[_index] objectForKey:@"work_id"];
    for (int i = 0; i<count; i++)//获得真实位置
    {
        // 替换为中等尺寸图片
        NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_id"];
        if ([string1 isEqualToString:str])
        {
            reallIndex =i;
            break;
        }
    }
    
    browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？ // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
    //    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
