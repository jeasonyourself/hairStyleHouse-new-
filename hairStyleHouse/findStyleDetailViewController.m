//
//  findStyleDetailViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-4.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "findStyleDetailViewController.h"
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
@interface findStyleDetailViewController ()

@end

@implementation findStyleDetailViewController
@synthesize style;
@synthesize bcid;
@synthesize scid;

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
    self.view.backgroundColor = [UIColor whiteColor];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 70)];
    topImage.backgroundColor = [UIColor whiteColor];
//    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/2, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];

    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
     twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/2,self.navigationController.navigationBar.frame.size.height+20, 320/2, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.bcid isEqualToString:@"1"]||[self.bcid isEqualToString:@"2"])
    {
        [oneButton setTitle:@"最新作品" forState:UIControlStateNormal];
        [twoButton setTitle:@"推荐作品" forState:UIControlStateNormal];
    }
    else
    {
        [oneButton setTitle:@"女生" forState:UIControlStateNormal];
        [twoButton setTitle:@"男生" forState:UIControlStateNormal];

    }
    
    
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
   

    
    
    
    
//    dresserArray =[[NSMutableArray alloc] init];
//    dresserArray1 =[[NSMutableArray alloc] init];
//    cleandresserArray =[[NSMutableArray alloc] init];
//    cleandresserArray1 =[[NSMutableArray alloc] init];

    page =[[NSString alloc] init];
    page=@"1";
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount=[[NSString alloc] init];
    pageCount1=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign=@"1";
    
    localData = YES;
//    canSelect = NO;
    //数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@1MyDatabase.db",bcid,scid]];
    
     NSString *dbPath2 = [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@2MyDatabase.db",bcid,scid]];
    
    db = [FMDatabase databaseWithPath:dbPath] ;
    
    if (![db open]) {
        
        NSLog(@"Could not open db.");
        
    }

    dbTwo = [FMDatabase databaseWithPath:dbPath2] ;
    
    if (![dbTwo open]) {
        
        NSLog(@"Could not open dbTwo.");
        
    }
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 110, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
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
    bottomRefreshView.hidden=YES;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
}
-(void)pullLoadMore
{
    
    if ([sign isEqualToString:@"1"])
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
            localData=NO;
            [self getData];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
        }
    }
    else
    {
        NSInteger _pageCount= [pageCount1 integerValue];
        
        FMResultSet *rs = [dbTwo executeQuery:@"select * from PersonListtwo"];
        while ([rs next]) {
            page1  = [rs stringForColumn:@"Page"];
        }
        
        [rs close];
        NSInteger _page = [page1 integerValue];
        
        NSLog(@"page:%@",page1);
        NSLog(@"pageCount:%@",pageCount1);
        
        if (_page<_pageCount) {
            _page++;
            page1 = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page1);
            localData=NO;

            [self getData1];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];

        }
    }
    
}

-(void)oneButtonClick
{
//    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    sign=@"1";
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
//    [topImage setImage:[UIImage imageNamed:@"同城发型.png"]];
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    sign=@"2";

    [myTableView reloadData];

}

-(void)getData
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Forhair&a=newCate&page=%@",page]]];
    
    [request setPostValue:self.bcid forKey:@"bcid"];
    [request setPostValue:self.scid forKey:@"scid"];

    if ([self.bcid isEqualToString:@"1"]||[self.bcid isEqualToString:@"2"])
    {
        [request setPostValue:@"new" forKey:@"condition"];
    }
    else
    {
        [request setPostValue:@"woman" forKey:@"condition"];
    }

    request.delegate=self;
    if (localData==YES) {
        request.tag=1;

    }
    else
    {
        request.tag=11;

    }
    [request startAsynchronous];
}

-(void)getData1
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Forhair&a=newCate&page=%@",page]]];
    
    [request setPostValue:self.bcid forKey:@"bcid"];
    [request setPostValue:self.scid forKey:@"scid"];
    
    if ([self.bcid isEqualToString:@"1"]||[self.bcid isEqualToString:@"2"])
    {
        [request setPostValue:@"recommend" forKey:@"condition"];
    }
    else
    {
        [request setPostValue:@"man" forKey:@"condition"];
    }
    
    request.delegate=self;
    if (localData==YES) {
        request.tag=2;
        
    }
    else
    {
        request.tag=22;
        
    }
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
//    canSelect = YES;

    
    if (request.tag==1)//左列表
    {
        NSMutableArray * arr;
        NSMutableArray * cleanarr;

        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类发型dic:%@",style,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
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
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类发型dic:%@",style,dic);
        
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
    
   else if (request.tag==2)
   {
       NSMutableArray * arr;
       NSMutableArray * cleanarr;
       
       NSLog(@"%@",request.responseString);
       NSData*jsondata = [request responseData];
       NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
       
       SBJsonParser* jsonP=[[SBJsonParser alloc] init];
       NSDictionary* dic=[jsonP objectWithString:jsonString];
       NSLog(@"%@分类发型dic:%@",style,dic);
       
       pageCount1 = [dic objectForKey:@"page_count"];
       if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
       {
           
       }
       else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
       {
           arr= [dic objectForKey:@"works_info"];
           //            [dresserArray addObjectsFromArray:arr];
           //            NSLog(@"dresser.count:%d",dresserArray.count);
           
           //            NSString  *str = [NSString stringWithFormat:@"CREATE TABLE %@%@%@ (Name text, id text, Photo blob)",bcid,scid,sign ]; FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
           
           
           
           NSString *IdString = [dbTwo stringForQuery:@"SELECT Id FROM PersonListtwo WHERE Name = ?",@"0"];
           if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
           {
               
               
           }
           else//否则更新本地数据库
           {
               
               
               
               NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonListtwo"];
               if (![dbTwo executeUpdate:sqlstr])//删除原有数据库
               {
                   NSLog(@"Delete table error!");
                   
               }
               [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo (Name text, Id text,Url text,Page text, Photo blob)"];//创建
               page1=@"1";//有新的数据返回，则从头开始请求
               for (int i = 0; i<arr.count; i++)//重新写入数据库
               {
                   
                   NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                   BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListtwo (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],page1,data];//插入所在数组位置，id，图片
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
       
       if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
       {
           
       }
       else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
       {
           cleanarr= [dic objectForKey:@"image_list"];
           //            [cleandresserArray addObjectsFromArray:cleanarr];
           //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
           
           
           NSString *IdString = [dbTwo stringForQuery:@"SELECT Id FROM PersonListtwo1 WHERE Name = ?",@"0"];
           if ([IdString isEqualToString:[[cleanarr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
           {
               
               
           }
           else//否则更新本地数据库
           {
               
               NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonListtwo1"];
               if (![dbTwo executeUpdate:sqlstr])//删除原有数据库
               {
                   NSLog(@"Delete table error!");
                   
               }
               
               [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
               page1=@"1";//有新的数据返回，则从头开始请求
               for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
               {
                   
                   NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
                   BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListtwo1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page1,data];//插入所在数组位置，id，图片
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
    
   else if (request.tag==22)//刷新右列表
   {
       NSMutableArray * arr;
       NSMutableArray * cleanarr;
       
       NSLog(@"%@",request.responseString);
       NSData*jsondata = [request responseData];
       NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
       
       SBJsonParser* jsonP=[[SBJsonParser alloc] init];
       NSDictionary* dic=[jsonP objectWithString:jsonString];
       NSLog(@"%@分类发型dic:%@",style,dic);
       
       pageCount1 = [dic objectForKey:@"page_count"];
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
           [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo (Name text, Id text,Url text,Page text, Photo blob)"];//创建
           //            page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
           for (int i = 0; i<arr.count; i++)//重新写入数据库
           {
               
               NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
               BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListtwo (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],page1,data];//插入所在数组位置，id，图片
               if (res == NO)
               {
                   NSLog(@"插入失败");
               }
               else
               {
                   NSLog(@"插入成功");
               }
           }
           NSLog(@"localDresserArray.count:%d",localDresserArray1.count);
       }
       
       if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
       {
           
       }
       else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
       {
           cleanarr= [dic objectForKey:@"image_list"];
           //            [cleandresserArray addObjectsFromArray:cleanarr];
           //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
           [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
           for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
           {
               
               NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
               BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListwo1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page1,data];//插入所在数组位置，id，图片
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
        [self freashView];

}
       
-(void)requestFailed:(ASIHTTPRequest *)request
{
//    canSelect = NO;
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
        NSLog(@"dic:%@",dic1);
        
        [localcleanDresserArray addObject:dic1];
    }
    
    [rs1 close];
    NSLog(@"localDresserArray.count:%d",localcleanDresserArray.count);
    
    
    //2--本地简略图
    FMResultSet *rstwo = [dbTwo executeQuery:@"select * from PersonListtwo"];
    
    
    //    NSLog(@"[rs next]:%hhd",[rs next]);
    localDresserArray1=nil;
    localDresserArray1=[[NSMutableArray alloc] init];
    
    while ([rstwo next]) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        NSString *name = [rstwo stringForColumn:@"Name"];
        
        NSString *workId  = [rstwo stringForColumn:@"Id"];
        NSString *imageUrl = [rstwo stringForColumn:@"Url"];
        
        
        NSData * imageData = [rstwo dataForColumn:@"Photo"];
        
        UIImage *aimage =[UIImage imageWithData: imageData];
        
        [dic setObject:name forKey:@"name"];
        [dic setObject:workId forKey:@"work_id"];
        [dic setObject:imageUrl forKey:@"work_image"];
        
        [dic setObject:aimage forKey:@"image"];
        NSLog(@"dic:%@",dic);
        
        [localDresserArray1 addObject:dic];
    }
    
    [rstwo close];
    
    
    FMResultSet *rstwo1 = [dbTwo executeQuery:@"select * from PersonListtwo1"];
    
    
    //    NSLog(@"[rs next]:%hhd",[rs next]);
    localcleanDresserArray1=nil;
    localcleanDresserArray1=[[NSMutableArray alloc] init];
    
    while ([rstwo1 next]) {
        NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
        NSString *name = [rstwo1 stringForColumn:@"Name"];
        
        NSString *workId  = [rstwo1 stringForColumn:@"Id"];
        NSString *imageUrl = [rstwo1 stringForColumn:@"Url"];
        
        
        NSData * imageData = [rstwo1 dataForColumn:@"Photo"];
        
        UIImage *aimage =[UIImage imageWithData: imageData];
        
        [dic1 setObject:name forKey:@"name"];
        [dic1 setObject:workId forKey:@"work_id"];
        [dic1 setObject:imageUrl forKey:@"work_image"];
        
        [dic1 setObject:aimage forKey:@"image"];
        NSLog(@"dic:%@",dic1);
        
        [localcleanDresserArray1 addObject:dic1];
    }
    
    [rstwo1 close];
    
    [myTableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([sign isEqualToString:@"1"]) {
        if (localDresserArray.count%3==0)
        {
            return localDresserArray.count/3;
        }
        else
        {
            return localDresserArray.count/3+1;
        }
        
    }
    else
    {
        if (localDresserArray1.count%3==0)
        {
            return localDresserArray1.count/3;
        }
        else
        {
            return localDresserArray1.count/3+1;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   150;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    hairStyleCategoryScanImageCell *cell=(hairStyleCategoryScanImageCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[hairStyleCategoryScanImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row1 = [indexPath row]*3;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*3+1;
    NSLog(@"row2:%d",row2);
    NSUInteger row3 = [indexPath row]*3+2;
    NSLog(@"row3:%d",row3);
    if ([sign isEqualToString:@"1"])
    {
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
    }
    else
    {
        if (row1<localDresserArray1.count)//防止可能越界
        {
            [cell setCell:[localDresserArray1 objectAtIndex:row1] andIndex:row1];

        }
        if (row2<localDresserArray1.count)//防止可能越界
        {
            [cell setCell:[localDresserArray1 objectAtIndex:row2] andIndex:row2];
        }
        if (row3<localDresserArray1.count)//防止可能越界
        {
            [cell setCell:[localDresserArray1 objectAtIndex:row3] andIndex:row3];
        }
    }
   

    return cell;

}

-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:NO];
    
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
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    NSLog(@"style:%@",self.style);
    Lab.text = self.style;
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectImage:(NSInteger)_index
{

    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(!appDlg.isReachable)
    {
        NSLog(@"网络连接异常");//执行网络异常时的代码
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常,无法查看详情" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
       
    }
    else
    {
       NSLog(@"网络已连接");//执行网络正常时的代码
        
    
    if ([sign isEqualToString:@"1"]) {
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
        
        browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
    }
   else
   {
       int count = localcleanDresserArray1.count;
       // 1.封装图片数据
       NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
       for (int i = 0; i<count; i++)
       {
           // 替换为中等尺寸图片
           NSString *url = [[localcleanDresserArray1[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
           MJPhoto *photo = [[MJPhoto alloc] init];
           photo.work_id =[localcleanDresserArray1[i] objectForKey:@"work_id"];
           photo.url = [NSURL URLWithString:url]; // 图片路径
           //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
           [photos addObject:photo];
       }
       
       // 2.显示相册
       browser=nil;
       browser = [[MJPhotoBrowser alloc] init];
       NSInteger reallIndex;
       NSString * str = [localDresserArray1[_index] objectForKey:@"work_id"];
       for (int i = 0; i<count; i++)//获得真实位置
       {
           // 替换为中等尺寸图片
           NSString *string1 = [localcleanDresserArray1[i] objectForKey:@"work_id"];
           if ([string1 isEqualToString:str])
           {
               reallIndex =i;
               break;
           }
       }
       
       browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
       browser.photos = photos; // 设置所有的图片
        }
    [self.navigationController pushViewController:browser animated:YES];
    }
//    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
