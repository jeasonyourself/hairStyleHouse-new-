//
//  myAnwserListViewController.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-13.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "myAnwserListViewController.h"
#import "myAnwserCenterViewController.h"
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
#import "BaiduMobStat.h"
@interface myAnwserListViewController ()

@end

@implementation myAnwserListViewController
@synthesize questionId;
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
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"my";
    
    
    myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height+50) style:UITableViewStylePlain];
    myTableView.allowsSelection=YES;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
         myTableView.frame= CGRectMake(0, 65, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height+50) ;
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"回答列表"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"回答列表"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

-(void)pullLoadMore
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
-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=answerList&page=%@",page]]];
    [request setPostValue:questionId forKey:@"pid"];
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:appDele.secret forKey:@"secret"];
    
    request.delegate=self;
    request.tag=1;
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
        NSLog(@"我的问题的回答dic:%@",dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSString class]])
        {
            return;
            //可在此处提示没有人回答过
        }
        else if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"answer_list"];
            [dresserArray addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray.count);
            
        }
        [self freashView];
    }
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
    
    NSLog(@"11111%lu",(unsigned long)dresserArray.count);
    if (dresserArray.count==0)
    {
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        return  0;
    }
    else
    {
        
        
        return dresserArray.count;
        
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    myAnwserListCell *cell=(myAnwserListCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[myAnwserListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row = [indexPath row];
    
    //    NSUInteger row3 = [indexPath row]*3+2;
    //    NSLog(@"row3:%d",row3);
    
    [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    
    
    //    if (row3<dresserArray.count)//防止可能越界
    //    {
    //        [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
    //    }
    
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request;
        
                   request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=answerDel"]];
            request.delegate=self;
            request.tag=202;
            [request setPostValue:[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"pid"] forKey:@"pid"];
        
        
        
        [request setPostValue:appDele.uid forKey:@"uid"];
        
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        [request startAsynchronous];
        
        [dresserArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    talkView=nil;
    talkView = [[talkViewController alloc] init];
    talkView.talkOrQuestion=@"question";
    talkView.questionId= [[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"pid"];
    talkView.uid = [[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"ta_id"];
    [self.navigationController pushViewController:talkView animated:NO];
    
}
-(void)leftButtonClick
{
    if ([_hidden isEqualToString:@"yes"]) {
        self.navigationController.navigationBar.hidden = YES;
    }
    else
    {
        self.navigationController.navigationBar.hidden = NO;
        
    }
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
    
    
    Lab.text = @"回答列表";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectCell:(NSInteger)_index
{
//    talkView=nil;
//    talkView = [[talkViewController alloc] init];
//    talkView.talkOrQuestion=@"question";
//    talkView.questionId= [[dresserArray objectAtIndex:_index] objectForKey:@"pid"];
//    talkView.uid = [[dresserArray objectAtIndex:_index] objectForKey:@"ta_id"];
//    [self.navigationController pushViewController:talkView animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end