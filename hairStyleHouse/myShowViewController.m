//
//  myShowViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-9.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "myShowViewController.h"
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
#import "BaiduMobStat.h"
@interface myShowViewController ()

@end

@implementation myShowViewController
@synthesize style;
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
    self.view.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 40)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 0;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 40);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitle:@"全部" forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 40);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitle:@"排名" forState:UIControlStateNormal];

    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 40);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton setTitle:@"介绍" forState:UIControlStateNormal];
     [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    
    
    localDresserArray=[[NSMutableArray alloc] init];
    localcleanDresserArray=[[NSMutableArray alloc] init];
    localDresserArray1=[[NSMutableArray alloc] init];
    localcleanDresserArray1=[[NSMutableArray alloc] init];
//    dresserArray =[[NSMutableArray alloc] init];
//    cleandresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
//    dresserArray1 =[[NSMutableArray alloc] init];
//    cleandresserArray1 =[[NSMutableArray alloc] init];
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount1=[[NSString alloc] init];
//    dresserArray2 =[[NSMutableArray alloc] init];
//    cleandresserArray2 =[[NSMutableArray alloc] init];

    page2 =[[NSString alloc] init];
    page2=@"1";
    pageCount2=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"add_time";
    


    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 105, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-60) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
    
    [self freashView];//直接本地
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
//    [self getData2];
    
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
    NSString* cName = [NSString stringWithFormat:@"我型我秀"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"我型我秀"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)pullLoadMore
{
    if ([sign isEqualToString:@"add_time"])
    {
        NSInteger _pageCount= [pageCount integerValue];
        
//        FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
//        while ([rs next]) {
//            page  = [rs stringForColumn:@"Page"];
//        }
//        
//        [rs close];
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
        if ([sign isEqualToString:@"comment_num"])
        {
            NSInteger _pageCount= [pageCount1 integerValue];
            
//            FMResultSet *rs = [dbTwo executeQuery:@"select * from PersonListtwo"];
//            while ([rs next]) {
//                page1  = [rs stringForColumn:@"Page"];
//            }
//            
//            [rs close];
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
        else
            if ([sign isEqualToString:@"collect_num"])
            {
//                NSInteger _pageCount= [pageCount2 integerValue];
//                
//                FMResultSet *rs = [dbThree executeQuery:@"select * from PersonListthree"];
//                while ([rs next]) {
//                    page2  = [rs stringForColumn:@"Page"];
//                }
//                
//                [rs close];
//                NSInteger _page = [page2 integerValue];
//                
//                NSLog(@"page:%@",page2);
//                NSLog(@"pageCount:%@",pageCount2);
//                
//                if (_page<_pageCount) {
//                    _page++;
//                    page2 = [NSString stringWithFormat:@"%d",_page];
//                    NSLog(@"page:%@",page2);
//                    localData=NO;
//
//                    [self getData2];
//                }
//                else
//                {
//                    [bottomRefreshView performSelector:@selector(finishedLoading)];
//                    
//                }
//
            }
    }


-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign = @"add_time";
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"comment_num";
    
    [myTableView reloadData];
}
-(void)thirdButtonClick
{
    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign = @"collect_num";
//    [myTableView reloadData];
    
}
-(void)getData
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=worksShow&page=%@",page]]];
    
    
    [request setPostValue:@"add_time" forKey:@"condition"];
    
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
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=worksShow&page=%@",page1]]];
    
    
    [request setPostValue:@"votes" forKey:@"condition"];
    
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
-(void)getData2
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=worksShow&page=%@",page2]]];
    
    
    [request setPostValue:@"collect_num" forKey:@"condition"];
    
    request.delegate=self;
    if (localData==YES) {
        request.tag=3;
        
    }
    else
    {
        request.tag=33;
        
    }
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.tag==0)
    {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否投票成功dic:%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
        {
            if ([sign isEqualToString:@"add_time"])
            {
                NSInteger _index = [[[localDresserArray objectAtIndex:voteIndex] objectForKey:@"votes"] integerValue];
                NSMutableDictionary * _Dic = [localDresserArray objectAtIndex:voteIndex];
                _index++;
                NSString * indexStr = [NSString stringWithFormat:@"%d",_index];
                [_Dic setValue:indexStr forKey:@"votes"];
                [localDresserArray replaceObjectAtIndex:_index-1 withObject:_Dic];
                [myTableView reloadData];
                UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"投票成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];

            }
            else
                if ([sign isEqualToString:@"comment_num"])
                {
                    NSInteger _index = [[[localDresserArray1 objectAtIndex:voteIndex] objectForKey:@"votes"] integerValue];
                    NSMutableDictionary * _Dic = [localDresserArray1 objectAtIndex:voteIndex];
                    _index++;
                    NSString * indexStr = [NSString stringWithFormat:@"%d",_index];
                    [_Dic setValue:indexStr forKey:@"votes"];
                    [localDresserArray1 replaceObjectAtIndex:_index-1 withObject:_Dic];
                    [myTableView reloadData];
                    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"投票成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
            
                   }
        else if ([[dic objectForKey:@"code"] isEqualToString:@"105"]) {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"你已对该作品投过票，一小时后可对该作品再次投票" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"投票出现错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }

    else if (request.tag ==1 || request.tag ==11)
    {
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
        
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
        NSLog(@"%@分类发型dic:%@",style,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
        {
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
        {
            arr= [dic objectForKey:@"works_info"];
            [localDresserArray addObjectsFromArray:arr];
        }
            if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
            {
                
            }
            else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
            {
                cleanarr= [dic objectForKey:@"image_list"];
                [localcleanDresserArray addObjectsFromArray:cleanarr];
            }
        [myTableView reloadData];
         [bottomRefreshView performSelector:@selector(finishedLoading)];
    }
    else if (request.tag ==2 || request.tag ==22)
    {
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.hidesWhenStopped = YES;
        
        NSMutableArray * arr1;
        NSMutableArray * cleanarr1;
        
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类发型dic:%@",style,dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
        {
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
        {
            arr1= [dic objectForKey:@"works_info"];
            [localDresserArray1 addObjectsFromArray:arr1];
        }
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            cleanarr1= [dic objectForKey:@"image_list"];
            [localcleanDresserArray1 addObjectsFromArray:cleanarr1];
        }
        [myTableView reloadData];
         [bottomRefreshView performSelector:@selector(finishedLoading)];
    }
    
    else  if (request.tag ==10101)//原本地数据
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
            NSString *likeString = [db stringForQuery:@"SELECT LikeNum FROM PersonList WHERE Name = ?",@"0"];
            NSString *commentString = [db stringForQuery:@"SELECT CommentNum FROM PersonList WHERE Name = ?",@"0"];
            NSLog(@"%@",IdString);
             NSLog(@"%@",likeString);
            NSLog(@"%@",commentString);
            
            if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]]&&[likeString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"votes"]]&&[commentString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"rank"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
            {
                needRefeashCleanPic = NO;
                
            }
            else//否则更新本地数据库
            {
                needRefeashCleanPic = YES;
                NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList"];
                if (![db executeUpdate:sqlstr])//删除原有数据库
                {
                    NSLog(@"Delete table error!");
                    
                }
                [db executeUpdate:@"CREATE TABLE PersonList (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
                page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                for (int i = 0; i<arr.count; i++)//重新写入数据库
                {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                    BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"votes"],[[arr objectAtIndex:i] objectForKey:@"rank"],page,data];//插入所在数组位置，id，图片
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
            if ([IdString isEqualToString:[[cleanarr objectAtIndex:0] objectForKey:@"work_id"]]&&needRefeashCleanPic==NO)//返回没有更新数据，则不需要重新写入数据库，直接本地
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
            [db executeUpdate:@"CREATE TABLE PersonList (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
            //            page=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
            for (int i = 0; i<arr.count; i++)//重新写入数据库
            {
                
                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                BOOL res =[db executeUpdate:@"INSERT INTO PersonList (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"votes"],[[arr objectAtIndex:i] objectForKey:@"rank"],page,data];//插入所在数组位置，id，图片
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
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
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
            NSString *likeString = [dbTwo stringForQuery:@"SELECT LikeNum FROM PersonListtwo WHERE Name = ?",@"0"];
            NSString *commentString = [dbTwo stringForQuery:@"SELECT CommentNum FROM PersonListtwo WHERE Name = ?",@"0"];
            
            
            if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]]&&[likeString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"votes"]]&&[commentString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"rank"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
            {
                
                needRefeashCleanPic1= NO;

            }
            else//否则更新本地数据库
            {
                needRefeashCleanPic1=YES;

                NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonListtwo"];
                if (![dbTwo executeUpdate:sqlstr])//删除原有数据库
                {
                    NSLog(@"Delete table error!");
                    
                }
                [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
                page1=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
                for (int i = 0; i<arr.count; i++)//重新写入数据库
                {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                    BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListtwo (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"votes"],[[arr objectAtIndex:i] objectForKey:@"rank"],page1,data];//插入所在数组位置，id，图片
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
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]]&&needRefeashCleanPic1==NO)
        {
            cleanarr= [dic objectForKey:@"image_list"];
            //            [cleandresserArray addObjectsFromArray:cleanarr];
            //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
            
            
            NSString *IdString = [dbTwo stringForQuery:@"SELECT Id FROM PersonListtwo1 WHERE Name = ?",@"0"];
            if ([IdString isEqualToString:[[cleanarr objectAtIndex:0] objectForKey:@"work_id"]]&&needRefeashCleanPic1==NO)//返回没有更新数据，则不需要重新写入数据库，直接本地
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
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
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
            
                [dbTwo executeUpdate:@"CREATE TABLE PersonListtwo (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
            
                for (int i = 0; i<arr.count; i++)//重新写入数据库
                {
                    
                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
                    BOOL res =[dbTwo executeUpdate:@"INSERT INTO PersonListtwo (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"votes"],[[arr objectAtIndex:i] objectForKey:@"rank"],page1,data];//插入所在数组位置，id，图片
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
        
        //        [self freashView];
    }
//    else if (request.tag==3)
//    {
//        NSMutableArray * arr;
//        NSMutableArray * cleanarr;
//        
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"%@分类发型dic:%@",style,dic);
//        
//        pageCount2 = [dic objectForKey:@"page_count"];
//        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
//        {
//        }
//        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
//        {
//            arr= [dic objectForKey:@"works_info"];
//            //            [dresserArray addObjectsFromArray:arr];
//            //            NSLog(@"dresser.count:%d",dresserArray.count);
//            
//            //            NSString  *str = [NSString stringWithFormat:@"CREATE TABLE %@%@%@ (Name text, id text, Photo blob)",bcid,scid,sign ]; FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
//            
//            
//            
//            NSString *IdString = [dbThree stringForQuery:@"SELECT Id FROM PersonListthree WHERE Name = ?",@"0"];
//            NSString *likeString = [dbThree stringForQuery:@"SELECT LikeNum FROM PersonListthree WHERE Name = ?",@"0"];
//            NSString *commentString = [dbThree stringForQuery:@"SELECT CommentNum FROM PersonListthree WHERE Name = ?",@"0"];
//            
//            
//            if ([IdString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"work_id"]]&&[likeString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"collect_num"]]&&[commentString isEqualToString:[[arr objectAtIndex:0] objectForKey:@"comment_num"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
//            {
//                
//                needRefeashCleanPic2=NO;
//            }
//            else//否则更新本地数据库
//            {
//                needRefeashCleanPic2 =YES;
//                NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonListthree"];
//                if (![dbThree executeUpdate:sqlstr])//删除原有数据库
//                {
//                    NSLog(@"Delete table error!");
//                    
//                }
//                [dbThree executeUpdate:@"CREATE TABLE PersonListthree (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
//                page2=@"1";//下拉刷新时候有新的数据返回，则从头开始请求
//                for (int i = 0; i<arr.count; i++)//重新写入数据库
//                {
//                    
//                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
//                    BOOL res =[dbThree executeUpdate:@"INSERT INTO PersonListthree (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"collect_num"],[[arr objectAtIndex:i] objectForKey:@"comment_num"],page2,data];//插入所在数组位置，id，图片
//                    if (res == NO)
//                    {
//                        NSLog(@"插入失败");
//                    }
//                    else
//                    {
//                        NSLog(@"插入成功");
//                    }
//                }
//            }
//        }
//        
//        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
//        {
//            
//        }
//        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]]&&needRefeashCleanPic2==NO)
//        {
//            cleanarr= [dic objectForKey:@"image_list"];
//            //            [cleandresserArray addObjectsFromArray:cleanarr];
//            //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
//            
//            
//            NSString *IdString = [dbThree stringForQuery:@"SELECT Id FROM PersonListthree1 WHERE Name = ?",@"0"];
//            if ([IdString isEqualToString:[[cleanarr objectAtIndex:0] objectForKey:@"work_id"]])//返回没有更新数据，则不需要重新写入数据库，直接本地
//            {
//                
//                
//            }
//            else//否则更新本地数据库
//            {
//                
//                NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonListthree1"];
//                if (![dbThree executeUpdate:sqlstr])//删除原有数据库
//                {
//                    NSLog(@"Delete table error!");
//                    
//                }
//                
//                [dbThree executeUpdate:@"CREATE TABLE PersonListthree1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
//                page2=@"1";//有新的数据返回，则从头开始请求
//                for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
//                {
//                    
//                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
//                   BOOL res =[dbThree executeUpdate:@"INSERT INTO PersonListthree1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page2,data];//插入所在数组位置，id，图片id，图片
//                    if (res == NO)
//                    {
//                        NSLog(@"插入失败");
//                    }
//                    else
//                    {
//                        NSLog(@"插入成功");
//                        
//                    }
//                }
//            }
//            
//        }
//        
//    }
//    
//    else if (request.tag==33)//刷新右列表
//    {
//        NSMutableArray * arr;
//        NSMutableArray * cleanarr;
//        
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        NSDictionary* dic=[jsonP objectWithString:jsonString];
//        NSLog(@"%@分类发型dic:%@",style,dic);
//        
//        pageCount2 = [dic objectForKey:@"page_count"];
//        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])//返回为空
//        {
//            
//        }
//        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])//有返回
//        {
//            arr= [dic objectForKey:@"works_info"];
//            //            [dresserArray addObjectsFromArray:arr];
//            //            NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE PersonList"];
//            //            if (![db executeUpdate:sqlstr])//删除原有数据库
//            //            {
//            //                NSLog(@"Delete table error!");
//            //
//            //            }
//            [dbThree executeUpdate:@"CREATE TABLE PersonListthree (Name text, Id text,Url text,LikeNum text,CommentNum text,Page text, Photo blob)"];//创建
//                for (int i = 0; i<arr.count; i++)//重新写入数据库
//                {
//                    
//                    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[arr objectAtIndex:i] objectForKey:@"work_image"]]];
//                    BOOL res =[dbThree executeUpdate:@"INSERT INTO PersonListthree (Name, Id,Url,LikeNum,CommentNum, Page, Photo) VALUES (?,?,?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[arr objectAtIndex:i] objectForKey:@"work_id"],[[arr objectAtIndex:i] objectForKey:@"work_image"],[[arr objectAtIndex:i] objectForKey:@"collect_num"],[[arr objectAtIndex:i] objectForKey:@"comment_num"],page2,data];//插入所在数组位置，id，图片
//                    if (res == NO)
//                    {
//                        NSLog(@"插入失败");
//                    }
//                    else
//                    {
//                        NSLog(@"插入成功");
//                    }
//                }
//        }
//        
//        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
//        {
//            
//        }
//        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
//        {
//            cleanarr= [dic objectForKey:@"image_list"];
//            //            [cleandresserArray addObjectsFromArray:cleanarr];
//            //            NSLog(@"cleandresserArray.count:%d",cleandresserArray.count);
//            [dbThree executeUpdate:@"CREATE TABLE PersonListthree1 (Name text, Id text,Url text,Page text, Photo blob)"];//创建
//            for (int i = 0; i<cleanarr.count; i++)//重新写入数据库
//            {
//                
//                NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[[cleanarr objectAtIndex:i] objectForKey:@"work_image"]]];
//                BOOL res =[dbThree executeUpdate:@"INSERT INTO PersonListthree1 (Name, Id,Url, Page, Photo) VALUES (?,?,?,?,?)",[NSString stringWithFormat:@"%d",i], [[cleanarr objectAtIndex:i] objectForKey:@"work_id"],[[cleanarr objectAtIndex:i] objectForKey:@"work_image"],page2,data];//插入所在数组位置，id，图片
//                if (res == NO)
//                {
//                    NSLog(@"插入失败");
//                }
//                else
//                {
//                    NSLog(@"插入成功");
//                }
//            }
//        }
//        
//        //        [self freashView];
//    }

    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;

    [self freashView];
   }
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    //    canSelect = NO;
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;

//    [self freashView];
}

//效率更好，可能要分开三个freashView
-(void)freashView
{
//    [bottomRefreshView performSelector:@selector(finishedLoading)];
//    //1--本地简略图
//    FMResultSet *rs = [db executeQuery:@"select * from PersonList"];
//    localDresserArray=nil;
//    localDresserArray=[[NSMutableArray alloc] init];
//    
//    while ([rs next]) {
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//        NSString *name = [rs stringForColumn:@"Name"];
//        
//        NSString *workId  = [rs stringForColumn:@"Id"];
//        NSString *imageUrl = [rs stringForColumn:@"Url"];
//        NSString *likeNum = [rs stringForColumn:@"LikeNum"];
//        NSString *commentNum = [rs stringForColumn:@"CommentNum"];
//
//        
//        NSData * imageData = [rs dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic setObject:name forKey:@"name"];
//        [dic setObject:workId forKey:@"work_id"];
//        [dic setObject:imageUrl forKey:@"work_image"];
//        [dic setObject:likeNum forKey:@"collect_num"];
//        [dic setObject:commentNum forKey:@"comment_num"];
//        
//        [dic setObject:aimage forKey:@"image"];
//        NSLog(@"dic:%@",dic);
//        
//        [localDresserArray addObject:dic];
//    }
//    
//    [rs close];
//    NSLog(@"localDresserArray.count:%d",localDresserArray.count);
//    
//    //1--本地高清图
//    FMResultSet *rs1 = [db executeQuery:@"select * from PersonList1"];
//    
//    
//    //    NSLog(@"[rs next]:%hhd",[rs next]);
//    localcleanDresserArray=nil;
//    localcleanDresserArray=[[NSMutableArray alloc] init];
//    
//    while ([rs1 next]) {
//        NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
//        NSString *name = [rs1 stringForColumn:@"Name"];
//        
//        NSString *workId  = [rs1 stringForColumn:@"Id"];
//        NSString *imageUrl = [rs1 stringForColumn:@"Url"];
//        
//        
//        NSData * imageData = [rs1 dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic1 setObject:name forKey:@"name"];
//        [dic1 setObject:workId forKey:@"work_id"];
//        [dic1 setObject:imageUrl forKey:@"work_image"];
//        
//        [dic1 setObject:aimage forKey:@"image"];
//        NSLog(@"dic1:%@",dic1);
//        
//        [localcleanDresserArray addObject:dic1];
//    }
//    
//    [rs1 close];
//    NSLog(@"localDresserArray.count:%d",localcleanDresserArray.count);
//    
//    
//    //2--本地简略图
//    FMResultSet *rstwo = [dbTwo executeQuery:@"select * from PersonListtwo"];
//    
//    
//    //    NSLog(@"[rs next]:%hhd",[rs next]);
//    localDresserArray1=nil;
//    localDresserArray1=[[NSMutableArray alloc] init];
//    
//    while ([rstwo next]) {
//        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
//        NSString *name = [rstwo stringForColumn:@"Name"];
//        
//        NSString *workId  = [rstwo stringForColumn:@"Id"];
//        NSString *imageUrl = [rstwo stringForColumn:@"Url"];
//        NSString *likeNum = [rstwo stringForColumn:@"LikeNum"];
//        NSString *commentNum = [rstwo stringForColumn:@"CommentNum"];
//        
//        
//        NSData * imageData = [rstwo dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic setObject:name forKey:@"name"];
//        [dic setObject:workId forKey:@"work_id"];
//        [dic setObject:likeNum forKey:@"collect_num"];
//        [dic setObject:commentNum forKey:@"comment_num"];
//        [dic setObject:imageUrl forKey:@"work_image"];
//        
//        [dic setObject:aimage forKey:@"image"];
//        NSLog(@"dic:%@",dic);
//        
//        [localDresserArray1 addObject:dic];
//    }
//    
//    [rstwo close];
//    
//    //2--高清图
//    FMResultSet *rstwo1 = [dbTwo executeQuery:@"select * from PersonListtwo1"];
//    
//    
//    //    NSLog(@"[rs next]:%hhd",[rs next]);
//    localcleanDresserArray1=nil;
//    localcleanDresserArray1=[[NSMutableArray alloc] init];
//    
//    while ([rstwo1 next]) {
//        NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
//        NSString *name = [rstwo1 stringForColumn:@"Name"];
//        
//        NSString *workId  = [rstwo1 stringForColumn:@"Id"];
//        NSString *imageUrl = [rstwo1 stringForColumn:@"Url"];
//        
//        
//        NSData * imageData = [rstwo1 dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic1 setObject:name forKey:@"name"];
//        [dic1 setObject:workId forKey:@"work_id"];
//        [dic1 setObject:imageUrl forKey:@"work_image"];
//        
//        [dic1 setObject:aimage forKey:@"image"];
//        NSLog(@"dic:%@",dic1);
//        
//        [localcleanDresserArray1 addObject:dic1];
//    }
//    
//    [rstwo1 close];
//    
//    
//    //3--本地简略图
////    FMResultSet *rsthree = [dbThree executeQuery:@"select * from PersonListthree"];
////    
////    
////    //    NSLog(@"[rs next]:%hhd",[rs next]);
////    localDresserArray2=nil;
////    localDresserArray2=[[NSMutableArray alloc] init];
////    
////    while ([rsthree next]) {
////        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
////        NSString *name = [rsthree stringForColumn:@"Name"];
////        
////        NSString *workId  = [rsthree stringForColumn:@"Id"];
////        NSString *imageUrl = [rsthree stringForColumn:@"Url"];
////        NSString *likeNum = [rsthree stringForColumn:@"LikeNum"];
////        NSString *commentNum = [rsthree stringForColumn:@"CommentNum"];
////        
////        NSData * imageData = [rsthree dataForColumn:@"Photo"];
////        
////        UIImage *aimage =[UIImage imageWithData: imageData];
////        
////        [dic setObject:name forKey:@"name"];
////        [dic setObject:workId forKey:@"work_id"];
////        [dic setObject:imageUrl forKey:@"work_image"];
////        
////        [dic setObject:likeNum forKey:@"collect_num"];
////        [dic setObject:commentNum forKey:@"comment_num"];
////        [dic setObject:aimage forKey:@"image"];
////        NSLog(@"dic:%@",dic);
////        
////        [localDresserArray2 addObject:dic];
////    }
////    
////    [rsthree close];
////    
////    //3--高清图
////    FMResultSet *rsthree1 = [dbThree executeQuery:@"select * from PersonListthree1"];
////    
////    
////    //    NSLog(@"[rs next]:%hhd",[rs next]);
////    localcleanDresserArray2=nil;
////    localcleanDresserArray2=[[NSMutableArray alloc] init];
////    
////    while ([rsthree1 next]) {
////        NSMutableDictionary * dic1 = [[NSMutableDictionary alloc] init];
////        NSString *name = [rsthree1 stringForColumn:@"Name"];
////        
////        NSString *workId  = [rsthree1 stringForColumn:@"Id"];
////        NSString *imageUrl = [rsthree1 stringForColumn:@"Url"];
////        
////        
////        NSData * imageData = [rsthree1 dataForColumn:@"Photo"];
////        
////        UIImage *aimage =[UIImage imageWithData: imageData];
////        
////        [dic1 setObject:name forKey:@"name"];
////        [dic1 setObject:workId forKey:@"work_id"];
////        [dic1 setObject:imageUrl forKey:@"work_image"];
////        
////        [dic1 setObject:aimage forKey:@"image"];
////        NSLog(@"dic:%@",dic1);
////        
////        [localcleanDresserArray2 addObject:dic1];
////    }
//    
////    [rsthree1 close];
//    
//    [myTableView reloadData];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([sign isEqualToString:@"add_time"])
    {
        if (localDresserArray.count%2==0)
        {
            return localDresserArray.count/2;
        }
        else
        {
            return localDresserArray.count/2+1;
        }
    }
    else
        if ([sign isEqualToString:@"comment_num"])
        {
            if (localDresserArray1.count%2==0)
            {
                return localDresserArray1.count/2;
            }
            else
            {
                return localDresserArray1.count/2+1;
            }
        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                if (localDresserArray2.count%2==0)
                {
                    return localDresserArray2.count/2;
                }
                else
                {
                    return localDresserArray2.count/2+1;
                }
            }
   else
   {
      
       return 0;
   }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   230;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    myShowCell *cell=(myShowCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[myShowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row1 = [indexPath row]*2;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*2+1;
    NSLog(@"row2:%d",row2);
//    NSUInteger row3 = [indexPath row]*3+2;
//    NSLog(@"row3:%d",row3);
    cell.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
    if ([sign isEqualToString:@"add_time"])
    {
        if (row1<localDresserArray.count)//防止可能越界
        {
        
        [cell setCell:[localDresserArray objectAtIndex:row1] andIndex:row1];
        }
        if (row2<localDresserArray.count)//防止可能越界
        {
            [cell setCell:[localDresserArray objectAtIndex:row2] andIndex:row2];
        }
    }
    else
        if ([sign isEqualToString:@"comment_num"])
        {
            if (row1<localDresserArray1.count)//防止可能越界
            {
            
            [cell setCell:[localDresserArray1 objectAtIndex:row1] andIndex:row1];
            }
            if (row2<localDresserArray1.count)//防止可能越界
            {
                [cell setCell:[localDresserArray1 objectAtIndex:row2] andIndex:row2];
            }
        }
        else
            if ([sign isEqualToString:@"collect_num"])
            {
                if (row1<localDresserArray2.count)//防止可能越界
                {
                
                [cell setCell:[localDresserArray2 objectAtIndex:row1] andIndex:row1];
                }
                if (row2<localDresserArray2.count)//防止可能越界
                {
                    [cell setCell:[localDresserArray2 objectAtIndex:row2] andIndex:row2];
                }
                }

    
    return cell;
    
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
-(void)rightButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        loginView.view.frame=self.view.bounds;
        //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
    }
    else
    {

    pubImage = nil;
    pubImage = [[pubImageViewController alloc] init];
    pubImage._hidden =@"no";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDele pushToViewController:pubImage];
        
    }
    
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
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton.layer setMasksToBounds:YES];
    [rightButton.layer setCornerRadius:3.0];
    [rightButton.layer setBorderWidth:1.0];
    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [rightButton setTitle:@"上传图片" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    
    
        Lab.text = @"我型我秀";

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
    if ([sign isEqualToString:@"add_time"])
    {
        int count = localcleanDresserArray.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i<count; i++)
        {
            // 替换为中等尺寸图片
            NSString *string1 = [localcleanDresserArray[i] objectForKey:@"work_image"];
            
            NSString *url = [string1 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.work_id =[localcleanDresserArray[i] objectForKey:@"work_id"];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
            [photos addObject:photo];
            
        }
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
        browser.photos = photos;
//        NSLog(@"photos:%@",photos);

    }
    else if ([sign isEqualToString:@"comment_num"])
        {
            int count = localcleanDresserArray1.count;
            // 1.封装图片数据
            NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
            for (int i = 0; i<count; i++)
            {
                // 替换为中等尺寸图片
                NSString *string1 = [localcleanDresserArray1[i] objectForKey:@"work_image"];
                
                NSString *url = [string1 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
                MJPhoto *photo = [[MJPhoto alloc] init];
                photo.work_id =[localcleanDresserArray1[i] objectForKey:@"work_id"];
                photo.url = [NSURL URLWithString:url]; // 图片路径
                //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
                [photos addObject:photo];
               
            }
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
            browser.photos = photos;
        }
//    else if ([sign isEqualToString:@"collect_num"])
//            {
//                int count = localcleanDresserArray2.count;
//                // 1.封装图片数据
//                NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
//                for (int i = 0; i<count; i++) {
//                    // 替换为中等尺寸图片
//                    NSString *string1 = [localcleanDresserArray2[i] objectForKey:@"work_image"];
//                    
//                    NSString *url = [string1 stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
//                    MJPhoto *photo = [[MJPhoto alloc] init];
//                    photo.work_id =[localcleanDresserArray2[i] objectForKey:@"work_id"];
//                    photo.url = [NSURL URLWithString:url]; // 图片路径
//                    //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
//                    [photos addObject:photo];
//                   
//            }
//                browser=nil;
//                browser = [[MJPhotoBrowser alloc] init];
//                NSInteger reallIndex;
//                NSString * str = [localDresserArray2[_index] objectForKey:@"work_id"];
//                for (int i = 0; i<count; i++)
//                {
//                    // 替换为中等尺寸图片
//                    NSString *string1 = [localcleanDresserArray2[i] objectForKey:@"work_id"];
//                    if ([string1 isEqualToString:str])
//                    {
//                        reallIndex =i;
//                        break;
//                    }
//                }
//                browser.currentPhotoIndex = reallIndex; // 弹出相册时显示的第一张图片是？
//                browser.photos = photos;
//    
//            }
    // 2.显示相册
    // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
    }
    //    [browser show];
}

-(void)selectVote:(NSInteger)_index
{
    voteIndex=_index;
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=works&a=worksVote"]]];
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    if ([sign isEqualToString:@"add_time"])
    {
        [request setPostValue:[localDresserArray[_index] objectForKey:@"work_id"] forKey:@"work_id"];
    }
        if ([sign isEqualToString:@"comment_num"])
        {
            [request setPostValue:[localDresserArray1[_index] objectForKey:@"work_id"] forKey:@"work_id"];
        }
    request.delegate=self;
    request.tag=0;
    [request startAsynchronous];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
