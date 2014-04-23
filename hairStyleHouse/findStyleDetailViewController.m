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

#import "MobClick.h"
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
    self.view.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    topImage.backgroundColor = [UIColor whiteColor];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
//    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
     twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/2,self.navigationController.navigationBar.frame.size.height+25, 320/2, 40);
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
   

    
    
    
    localDresserArray=[[NSMutableArray alloc] init];
    localcleanDresserArray=[[NSMutableArray alloc] init];
    localDresserArray1=[[NSMutableArray alloc] init];
    localcleanDresserArray1=[[NSMutableArray alloc] init];
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
    
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 115, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-70) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];
//    [self freashView];//直接本地
    [self.view addSubview:myTableView];
    
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
    
    
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
    //开始动画
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"%@",  self.style, nil];
    [MobClick beginLogPageView:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"%@", self.style, nil];
    [MobClick endLogPageView:cName];
}

-(void)pullLoadMore
{
    
    if ([sign isEqualToString:@"1"])
    {
        NSInteger _pageCount= [pageCount integerValue];
        
        NSInteger _page = [page integerValue];
        
        NSLog(@"page:%@",page);
        NSLog(@"pageCount:%@",pageCount);
        
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
    }
    else
    {
        NSInteger _pageCount= [pageCount1 integerValue];
        NSInteger _page = [page1 integerValue];
        
        NSLog(@"page:%@",page1);
        NSLog(@"pageCount:%@",pageCount1);
        
        if (_page<_pageCount) {
            _page++;
            page1 = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page1);
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
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=forhair&a=hairCate&page=%@",page]]];
    
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
    request.tag=1;
    [request startAsynchronous];
}

-(void)getData1
{
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=forhair&a=hairCate&page=%@",page1]]];
    
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
    request.tag=2;
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
           [localDresserArray1 addObjectsFromArray:arr];
       }
       
       if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])//高清图
       {
           
       }
       else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
       {
           cleanarr= [dic objectForKey:@"image_list"];
           [localcleanDresserArray1 addObjectsFromArray:cleanarr];

       }
       
   }
    
 
    
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;
    [bottomRefreshView performSelector:@selector(finishedLoading)];
        [myTableView reloadData];

}
       
-(void)requestFailed:(ASIHTTPRequest *)request
{
//    canSelect = NO;
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;

//    [self freashView];
}
-(void)freashView
{
//    [bottomRefreshView performSelector:@selector(finishedLoading)];
// leftButton.userInteractionEnabled=YES;
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
//
//        
//        NSData * imageData = [rs dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic setObject:name forKey:@"name"];
//        [dic setObject:workId forKey:@"work_id"];
//        [dic setObject:imageUrl forKey:@"work_image"];
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
//        NSLog(@"dic:%@",dic1);
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
//        
//        
//        NSData * imageData = [rstwo dataForColumn:@"Photo"];
//        
//        UIImage *aimage =[UIImage imageWithData: imageData];
//        
//        [dic setObject:name forKey:@"name"];
//        [dic setObject:workId forKey:@"work_id"];
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
//    
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
//    NSLog(@"localcleanDresserArray1.count:%d",localcleanDresserArray1.count);
//
//    [myTableView reloadData];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([sign isEqualToString:@"1"]) {
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
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   235;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    hairStyleCategoryScanImageCell *cell=(hairStyleCategoryScanImageCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[hairStyleCategoryScanImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    cell.backgroundColor = [UIColor colorWithRed:230.0/256.0 green:230.0/256.0 blue:230.0/256.0 alpha:1.0];

    NSUInteger row1 = [indexPath row]*2;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*2+1;
    NSLog(@"row2:%d",row2);
//    NSUInteger row3 = [indexPath row]*3+2;
//    NSLog(@"row3:%d",row3);
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
//        if (row3<localDresserArray.count)//防止可能越界
//        {
//            [cell setCell:[localDresserArray objectAtIndex:row3] andIndex:row3];
//        }
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
//        if (row3<localDresserArray1.count)//防止可能越界
//        {
//            [cell setCell:[localDresserArray1 objectAtIndex:row3] andIndex:row3];
//        }
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
    leftButton.userInteractionEnabled=NO;
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setImage:[UIImage imageNamed:@"返回.png"]  forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [leftButton setBackgroundColor:[UIColor clearColor]];
    [leftButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(0,28, 24, 26);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
    
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
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
        
    
    if ([sign isEqualToString:@"1"])
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
