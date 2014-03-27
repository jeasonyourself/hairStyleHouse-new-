//
//  wayInforViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "wayInforViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "AllAroundPullView.h"
#import "BaiduMobStat.h"
@interface wayInforViewController ()

@end

@implementation wayInforViewController
@synthesize style;
@synthesize _hidden;
@synthesize myTableView;
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
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitle:@"全部" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton setTitle:@"同城" forState:UIControlStateNormal];
    
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton setTitle:@"我的" forState:UIControlStateNormal];
    
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    needFeash=NO;
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
//    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
//    [topImage setImage:[UIImage imageNamed:@"潮流学堂.png"]];
//    
//    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 80, 50);
//    oneButton.backgroundColor = [UIColor clearColor];
//    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    twoButton.frame = CGRectMake(80,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
//    twoButton.backgroundColor = [UIColor clearColor];
//    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    thirdButton.frame = CGRectMake(160,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
//    thirdButton.backgroundColor = [UIColor clearColor];
//    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton * forthButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    forthButton.frame = CGRectMake(240,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
//    forthButton.backgroundColor = [UIColor clearColor];
//    [forthButton addTarget:self action:@selector(forthButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:topImage];
//    [self.view addSubview:oneButton];
//    [self.view addSubview:twoButton];
//    [self.view addSubview:thirdButton];
//    [self.view addSubview:forthButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];
    page1 =[[NSString alloc] init];
    page1 =@"1";
    pageCount1 =[[NSString alloc] init];
    dresserArray2 =[[NSMutableArray alloc] init];
    page2 =[[NSString alloc] init];
    page2=@"1";
    pageCount2=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"1";
    
    myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-20) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
//        myTableView.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height) ;
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
    [self getData2];
}

-(void)oneButtonClick
{
    if (needFeash==YES) {
        page=@"0";
        [self getData];
        
    }
    else
    {
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"1";
    [myTableView reloadData];
    }
    
    
}
-(void)twoButtonClick
{
    if (needFeash==YES) {
        page=@"0";
        [self getData1];
        
    }
    else
    {

    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"2";
    [myTableView reloadData];
    }
    
}
-(void)thirdButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    sign =@"3";
    [myTableView reloadData];
    
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName;
    if ([self.style  isEqualToString:@"4"]) {
       cName = [NSString stringWithFormat:@"潮流学堂"];

      
        
    }
    else if ([self.style  isEqualToString:@"5"]) {
         cName = [NSString stringWithFormat:@"护理方法"];
        
    }
    else if ([self.style  isEqualToString:@"1"]) {
         cName = [NSString stringWithFormat:@"品牌沙龙"];
        
    }
    else if ([self.style  isEqualToString:@"3"]) {
         cName = [NSString stringWithFormat:@"行业情报"];
        
    }

    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName;
    if ([self.style  isEqualToString:@"4"]) {
        cName = [NSString stringWithFormat:@"潮流学堂"];
        
        
        
    }
    else if ([self.style  isEqualToString:@"5"]) {
        cName = [NSString stringWithFormat:@"护理方法"];
        
    }
    else if ([self.style  isEqualToString:@"1"]) {
        cName = [NSString stringWithFormat:@"品牌沙龙"];
        
    }
    else if ([self.style  isEqualToString:@"3"]) {
        cName = [NSString stringWithFormat:@"行业情报"];
        
    }
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)pullLoadMore
{
    if ([sign isEqualToString:@"1"]) {
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
    else if([sign isEqualToString:@"2"]) {
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
    else if([sign isEqualToString:@"3"]) {
        NSInteger _pageCount= [pageCount2 integerValue];
        
        NSInteger _page = [page2 integerValue];
        
        NSLog(@"page:%@",page2);
        NSLog(@"pageCount:%@",pageCount2);
        
        if (_page<_pageCount) {
            _page++;
            page2 = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page2);
            [self getData2];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
            
        }
        
    }

   }

//-(void)oneButtonClick
//{
//    [topImage setImage:[UIImage imageNamed:@"潮流学堂.png"]];
//    sign =@"4";
//    page=@"1";
//    [dresserArray removeAllObjects];
//    [self getData];
//    
//}
//-(void)twoButtonClick
//{
//    [topImage setImage:[UIImage imageNamed:@"洗护方法.png"]];
//    //    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    
//    sign =@"5";
//    page=@"1";
//    [dresserArray removeAllObjects];
//    [self getData];
//}
//-(void)thirdButtonClick
//{
//    [topImage setImage:[UIImage imageNamed:@"名人堂.png"]];
//    sign =@"2";
//    page=@"1";
//    [dresserArray removeAllObjects];
//    [self getData];
//    
//}
-(void)forthButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"品牌名店.png"]];
    sign =@"1";
    page=@"1";
    [dresserArray removeAllObjects];
    [self getData];
    
}
-(void)getData
{
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=news&a=newsList&page=%@",page]]];
    [request setPostValue:@"new" forKey:@"condition"];

        [request setPostValue:self.style forKey:@"news_type"];
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}
-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=news&a=newsList&page=%@",page1]]];
    
    [request setPostValue:@"city" forKey:@"condition"];
    NSLog(@"citycity:%@",appDele.city);
    [request setPostValue:appDele.city forKey:@"city"];
    [request setPostValue:self.style forKey:@"news_type"];
    request.delegate=self;
    request.tag=2;
    [request startAsynchronous];
}
-(void)getData2
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=news&a=newsList&page=%@",page2]]];
    [request setPostValue:@"my" forKey:@"condition"];
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:self.style forKey:@"news_type"];
    request.delegate=self;
    request.tag=3;
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSMutableArray * arr;
    
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@行业情报dic1:%@",sign,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"news_list"];
            [dresserArray addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray.count);
            
        }
//        [self freashView];
    }
   else  if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@行业情报dic2:%@",sign,dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"news_list"];
            [dresserArray1 addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray1.count);
            
        }
//        [self freashView];
    }
    else if (request.tag==3) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@行业情报dic3:%@",sign,dic);
        
        pageCount2 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"news_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"news_list"];
            [dresserArray2 addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray2.count);
            
        }
    }
    if (request.tag==202) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"删除成功dic:%@",dic);
        needFeash=YES;
    }

    [self freashView];

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
    if ([sign isEqualToString:@"1"]) {
        return dresserArray.count;

    }
    else if([sign isEqualToString:@"2"]) {
        return dresserArray1.count;
        
    }
    else if([sign isEqualToString:@"3"]) {
        return dresserArray2.count;
        
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    wayInforCell *cell=(wayInforCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[wayInforCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row = [indexPath row];
    
    //    NSUInteger row3 = [indexPath row]*3+2;
    //    NSLog(@"row3:%d",row3);
    if ([sign isEqualToString:@"1"]) {
        [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];

    }
    else if([sign isEqualToString:@"2"]) {
        [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];

    }
    else if([sign isEqualToString:@"3"]) {
        [cell setCell:[dresserArray2 objectAtIndex:row] andIndex:row];

    }
    
    
    //    if (row3<dresserArray.count)//防止可能越界
    //    {
    //        [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
    //    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([sign isEqualToString:@"3"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    // Return NO if you do not want the specified item to be editable.
    
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=news&a=newsDel"]];
        
        request.delegate=self;
        request.tag=202;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"news_id"] forKey:@"news_id"];
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        [request startAsynchronous];
        
        [dresserArray2 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
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
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
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
    
    if ([self.style  isEqualToString:@"4"]) {
        Lab.text = @"潮流学堂";

    }
    else if ([self.style  isEqualToString:@"5"]) {
            Lab.text = @"护理方法";
            
        }
        else if ([self.style  isEqualToString:@"1"]) {
            Lab.text = @"品牌沙龙";
            
        }
        else if ([self.style  isEqualToString:@"3"]) {
            Lab.text = @"行业情报";
            
        }

    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    wayDeatil = nil;
    wayDeatil = [[wayDetailViewController alloc] init];
    wayDeatil.inforDic = [dresserArray objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:wayDeatil animated:NO];
}
-(void)selectCell:(NSInteger)_index
{
//    wayDeatil = nil;
//    wayDeatil = [[wayDetailViewController alloc] init];
//    wayDeatil.inforDic = [dresserArray objectAtIndex:_index];
//    [self.navigationController pushViewController:wayDeatil animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
