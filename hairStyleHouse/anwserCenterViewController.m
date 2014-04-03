//
//  anwserCenterViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "anwserCenterViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface anwserCenterViewController ()

@end

@implementation anwserCenterViewController
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
    leftButton=[[UIButton alloc] init];
//    self.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, 320, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height);
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (!appDele.uid) {
        
        [myTableView removeFromSuperview];
        [oneButton removeFromSuperview];
        [twoButton removeFromSuperview];
        [thirdButton removeFromSuperview];
        [topImage removeFromSuperview];
        myTableView=nil;
        
        signImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+100, 320, 172)];
        [signImage setImage:[UIImage imageNamed:@"signIma.png"]];
        [self.view addSubview:signImage];
    }
    else
    {
        if ([appDele.type isEqualToString:@"1"]) {
            dresserArray2=nil;
            dresserArray2 =[[NSMutableArray alloc] init];
            page2=nil;
            page2 =[[NSString alloc] init];
            page2=@"1";
            pageCount2=nil;
            pageCount2=[[NSString alloc] init];
            myTableView=nil;
            myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-40) style:UITableViewStylePlain];
            myTableView.allowsSelection=YES;
            [myTableView setSeparatorInset:UIEdgeInsetsZero];
            myTableView.dataSource=self;
            myTableView.delegate=self;
            myTableView.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:myTableView];
            
            bottomRefreshView=nil;
            bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
                NSLog(@"loadMore");
                [self pullLoadMore];
                myTableView.frame=CGRectMake(0,self.navigationController.navigationBar.frame.size.height+20, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-60);
            }];
            bottomRefreshView.hidden=NO;
            [myTableView addSubview:bottomRefreshView];
            [self getData2];
            appDele.ifSinceLogOut =@"no";
            
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
            _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
            //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
            _activityIndicatorView.color = [UIColor grayColor];
            //设置活动指示器的颜色
            
            [self.view addSubview:_activityIndicatorView];
            //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
            
        }
        else
        {
            _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            //创建一个UIActivityIndicatorView对象：_activityIndicatorView，并初始化风格。
            _activityIndicatorView.frame = CGRectMake(160, self.view.center.y, 0, 0);
            //设置对象的位置，大小是固定不变的。WhiteLarge为37 * 37，White为20 * 20
            _activityIndicatorView.color = [UIColor grayColor];
            //设置活动指示器的颜色
            _activityIndicatorView.hidesWhenStopped = YES;
            [self.view addSubview:_activityIndicatorView];
            //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
            //将对象加入到view
           
            topImage=nil;
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
            oneButton=nil;
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitle:@"全部" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
            twoButton=nil;
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton setTitle:@"同城" forState:UIControlStateNormal];
    
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
            thirdButton=nil;
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton setTitle:@"我的回答" forState:UIControlStateNormal];
    
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    needFeash=NO;
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
            dresserArray=nil;
    dresserArray =[[NSMutableArray alloc] init];
            page=nil;
    page =[[NSString alloc] init];
    page=@"1";
            pageCount=nil;
    pageCount=[[NSString alloc] init];
            dresserArray1=nil;
    dresserArray1 =[[NSMutableArray alloc] init];
            page1=nil;
    page1 =[[NSString alloc] init];
    page1 =@"1";
            pageCount1=nil;
    pageCount1 =[[NSString alloc] init];
            dresserArray2=nil;
    dresserArray2 =[[NSMutableArray alloc] init];
            page2=nil;
    page2 =[[NSString alloc] init];
    page2=@"1";
            pageCount2=nil;
    pageCount2=[[NSString alloc] init];
            sign=nil;
    sign =[[NSString alloc] init];
    sign = @"1";
    
            myTableView=nil;
    myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-80) style:UITableViewStylePlain];
    myTableView.allowsSelection=YES;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
            bottomRefreshView=nil;
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
        myTableView.frame=CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-80);
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
    [self getData2];
            appDele.ifSinceLogOut =@"no";

        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if (!appDele.uid) {
        [self viewDidLoad];
    }
    else
    {
        if ([appDele.ifSinceLogOut isEqualToString:@"yes"]) {
            [self viewNeedRefreash];
            
            
            appDele.ifSinceLogOut =@"no";
        }
        else
        {
        
        }
        
    }
    
    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//    if ([appDele.type isEqualToString:@"1"]) {
//        [questionButton setTitle:@"我要提问" forState:UIControlStateNormal];
//        
//    }
//    else
//    {
//        [questionButton setTitle:@"同城问题" forState:UIControlStateNormal];
//        
//    }
//    if ([appDele.type isEqualToString:@"1"]) {
//        [anwserButton setTitle:@"我的问题" forState:UIControlStateNormal];
//        
//    }
//    else
//    {
//        [anwserButton setTitle:@"我的回答" forState:UIControlStateNormal];
//        
//    }
}

- (void)viewNeedRefreash
{
    [super viewDidLoad];
    //    self.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, 320, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height);
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if (!appDele.uid) {
        
        [myTableView removeFromSuperview];
        [oneButton removeFromSuperview];
        [twoButton removeFromSuperview];
        [thirdButton removeFromSuperview];
        [topImage removeFromSuperview];
        myTableView=nil;
    }
    else
    {
        if ([appDele.type isEqualToString:@"1"]) {
            dresserArray2=nil;
            dresserArray2 =[[NSMutableArray alloc] init];
            page2=nil;
            page2 =[[NSString alloc] init];
            page2=@"1";
            pageCount2=nil;
            pageCount2=[[NSString alloc] init];
            myTableView=nil;
            myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-60) style:UITableViewStylePlain];
            myTableView.allowsSelection=YES;
            [myTableView setSeparatorInset:UIEdgeInsetsZero];
            myTableView.dataSource=self;
            myTableView.delegate=self;
            myTableView.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:myTableView];
            
            bottomRefreshView=nil;
            bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
                NSLog(@"loadMore");
                [self pullLoadMore];
                myTableView.frame=CGRectMake(0,self.navigationController.navigationBar.frame.size.height+20, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-60);
            }];
            bottomRefreshView.hidden=NO;
            [myTableView addSubview:bottomRefreshView];
            [self getData2];
            appDele.ifSinceLogOut =@"no";
        }
        else
        {
            topImage=nil;
            topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
            [topImage setBackgroundColor:[UIColor whiteColor]];
            topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
            topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
            topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
            topImage.layer.masksToBounds = YES;//设为NO去试试
            
            oneButton=nil;
            oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
            oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
            oneButton.backgroundColor = [UIColor clearColor];
            [oneButton setTitle:@"全部" forState:UIControlStateNormal];
            [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            twoButton=nil;
            twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
            twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
            twoButton.backgroundColor = [UIColor clearColor];
            [twoButton setTitle:@"同城" forState:UIControlStateNormal];
            
            [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            thirdButton=nil;
            thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
            thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
            thirdButton.backgroundColor = [UIColor clearColor];
            [thirdButton setTitle:@"我的回答" forState:UIControlStateNormal];
            
            [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
            
            needFeash=NO;
            [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
            [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
            [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
            [self.view addSubview:topImage];
            [self.view addSubview:oneButton];
            [self.view addSubview:twoButton];
            [self.view addSubview:thirdButton];
            dresserArray=nil;
            dresserArray =[[NSMutableArray alloc] init];
            page=nil;
            page =[[NSString alloc] init];
            page=@"1";
            pageCount=nil;
            pageCount=[[NSString alloc] init];
            dresserArray1=nil;
            dresserArray1 =[[NSMutableArray alloc] init];
            page1=nil;
            page1 =[[NSString alloc] init];
            page1 =@"1";
            pageCount1=nil;
            pageCount1 =[[NSString alloc] init];
            dresserArray2=nil;
            dresserArray2 =[[NSMutableArray alloc] init];
            page2=nil;
            page2 =[[NSString alloc] init];
            page2=@"1";
            pageCount2=nil;
            pageCount2=[[NSString alloc] init];
            sign=nil;
            sign =[[NSString alloc] init];
            sign = @"1";
            
            myTableView=nil;
            myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-80) style:UITableViewStylePlain];
            myTableView.allowsSelection=YES;
            [myTableView setSeparatorInset:UIEdgeInsetsZero];
            myTableView.dataSource=self;
            myTableView.delegate=self;
            myTableView.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:myTableView];
            
            bottomRefreshView=nil;
            bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
                NSLog(@"loadMore");
                [self pullLoadMore];
                myTableView.frame=CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-80);
            }];
            bottomRefreshView.hidden=NO;
            [myTableView addSubview:bottomRefreshView];
            
            
            [self getData];
            [self getData1];
            [self getData2];
            appDele.ifSinceLogOut =@"no";
        }
    }
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"问答中心"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}


-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"1";
    
    if (needFeash == YES) {
        page = @"1";
        [self getData];
        page1 = @"1";
        [self getData1];
        page2 = @"1";
        [self getData2];
    }
    else
    {
        [myTableView reloadData];
    }
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"2";
    
    if (needFeash == YES) {
        page = @"1";
        [self getData];
        page1 = @"1";
        [self getData1];
        page2 = @"1";
        [self getData2];
    }
    else
    {
        [myTableView reloadData];
    }
}
-(void)thirdButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    sign =@"3";
    if (needFeash == YES) {
        page = @"1";
        [self getData];
        page1 = @"1";
        [self getData1];
        page2 = @"1";
        [self getData2];
    }
    else
    {
        [myTableView reloadData];
    }
    
}
-(void)pullLoadMore
{
    
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"1"])
    {
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
    else 
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
    
}
-(void)getData
{
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=allIssues&page=%@",page]]];
    [request setPostValue:@"new" forKey:@"condition"];
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
    _activityIndicatorView.hidesWhenStopped = NO;
    [_activityIndicatorView startAnimating];
    
}
-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=allIssues&page=%@",page1]]];
    
    [request setPostValue:@"city" forKey:@"condition"];
    NSLog(@"citycity:%@",appDele.city);
    [request setPostValue:appDele.city forKey:@"city"];
    request.delegate=self;
    request.tag=2;
    [request startAsynchronous];
    _activityIndicatorView.hidesWhenStopped = NO;

    [_activityIndicatorView startAnimating];
    
}
-(void)getData2
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request;
    if ([appDele.type isEqualToString:@"1"]) {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=myQuestion&page=%@",page2]]];
    }
    else
    {
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=answerList&page=%@",page2]]];
        [request setPostValue:appDele.secret forKey:@"secret"];
    }
    [request setPostValue:appDele.uid forKey:@"uid"];
    request.delegate=self;
    request.tag=3;
    [request startAsynchronous];
    _activityIndicatorView.hidesWhenStopped = NO;

    [_activityIndicatorView startAnimating];
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"1"]) {
    }
    else
    {
        if (needFeash == YES) {
            needFeash = NO;
            
            [dresserArray removeAllObjects];
            [dresserArray1 removeAllObjects];
            [dresserArray2 removeAllObjects];
        }
    }
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
        NSLog(@"dic1111:%@",dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"problem_list"];
            [dresserArray addObjectsFromArray:arr];
            NSLog(@"dresserArray.count:%d",dresserArray.count);
            
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
        NSLog(@"dic2:%@",dic);
        
        pageCount1 = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"problem_list"];
            [dresserArray1 addObjectsFromArray:arr];
            NSLog(@"dresserArray1.count:%d",dresserArray1.count);
            
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
        NSLog(@"dic3:%@",dic);
        
        pageCount2 = [dic objectForKey:@"page_count"];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        if ([appDele.type isEqualToString:@"1"]) {
            leftButton.userInteractionEnabled=YES;

            if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"problem_list"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"problem_list"];
                [dresserArray2 addObjectsFromArray:arr];
                NSLog(@"dresserArray2.count:%d",dresserArray2.count);
                
            }

            
        }
        else
        {
            if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"answer_list"] isKindOfClass:[NSArray class]])
            {
                arr= [dic objectForKey:@"answer_list"];
                [dresserArray2 addObjectsFromArray:arr];
                NSLog(@"dresserArray2.count:%d",dresserArray2.count);
                
            }

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
        if ([[dic objectForKey:@"code"] isEqualToString:@"101"]) {
            if ([appDele.type isEqualToString:@"1"]) {
            }
            else
            {
                needFeash  = YES;
            }
            
        }
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
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([appDele.type isEqualToString:@"1"]) {
        return dresserArray2.count;
    }
    else
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([appDele.type isEqualToString:@"1"]) {
        return   80;
    }
    else
    {
        return   100;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    anwserCell *cell=(anwserCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[anwserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row = [indexPath row];
    
    //    NSUInteger row3 = [indexPath row]*3+2;
    //    NSLog(@"row3:%d",row3);
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([appDele.type isEqualToString:@"1"]) {
         [cell setCell2:[dresserArray2 objectAtIndex:row] andIndex:row];
    }
    else
    {
        if ([sign isEqualToString:@"1"]) {
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
            
        }
        else if([sign isEqualToString:@"2"]) {
            [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
            
        }
        else if([sign isEqualToString:@"3"]) {
            [cell setCell1:[dresserArray2 objectAtIndex:row] andIndex:row];
            
        }

    }
    
    
    //    if (row3<dresserArray.count)//防止可能越界
    //    {
    //        [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
    //    }
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([appDele.type isEqualToString:@"1"]) {
        return YES;

    }
    else
    {

    if ([sign isEqualToString:@"3"]) {
        return YES;
    }
    else
    {
        return NO;
    }
    }
    // Return NO if you do not want the specified item to be editable.
    
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request;
        
        if ([appDele.type isEqualToString:@"1"]) {
            request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=questionDel"]];
            request.delegate=self;
            request.tag=202;
            [request setPostValue:[[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"id"] forKey:@"id"];
        }
        else
        {
            request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=wenda&a=answerDel"]];
            request.delegate=self;
            request.tag=202;
            [request setPostValue:[[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"pid"] forKey:@"pid"];
        }
        
        
        
        [request setPostValue:appDele.uid forKey:@"uid"];
        
        [request setPostValue:appDele.secret forKey:@"secret"];
        
        [request startAsynchronous];
        
        [dresserArray2 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


-(void)refreashNav
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if (!appDele.uid)
    {
        self.navigationItem.rightBarButtonItem=nil;
    }
    else
    {
        if ([appDele.type isEqualToString:@"1"]) {
            
            leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [leftButton.layer setMasksToBounds:YES];
            [leftButton.layer setCornerRadius:3.0];
            [leftButton.layer setBorderWidth:1.0];
            [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
            [leftButton setTitle:@"刷新" forState:UIControlStateNormal];
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
        else
        {
            self.navigationItem.leftBarButtonItem=nil;
            self.navigationItem.rightBarButtonItem=nil;

        }
    
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([appDele.type isEqualToString:@"1"]) {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        myAnwserList = nil;
        myAnwserList= [[myAnwserListViewController alloc] init];
        myAnwserList._hidden  =@"yes";
        myAnwserList.questionId = [[dresserArray2  objectAtIndex:[indexPath row]] objectForKey:@"id"];
        [appDele pushToViewController:myAnwserList  ];
    }
    else//发型师的回答
    {
        if ([sign isEqualToString:@"1"]) {
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"pid"];
            talkView.uid = [[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }
        else if([sign isEqualToString:@"2"]) {
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray1 objectAtIndex:[indexPath row]] objectForKey:@"pid"];
            talkView.uid = [[dresserArray1 objectAtIndex:[indexPath row]] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }
        else if([sign isEqualToString:@"3"]) {

            
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"pid"];
            talkView.uid = [[dresserArray2 objectAtIndex:[indexPath row]] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }

    }
    
    
    
}
-(void)anwserQ:(NSInteger)row
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([appDele.type isEqualToString:@"1"]) {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        myAnwserList = nil;
        myAnwserList= [[myAnwserListViewController alloc] init];
        myAnwserList._hidden  =@"yes";
        myAnwserList.questionId = [[dresserArray2  objectAtIndex:row] objectForKey:@"id"];
        [appDele pushToViewController:myAnwserList  ];
    }
    else//发型师的回答
    {
        if ([sign isEqualToString:@"1"]) {
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray objectAtIndex:row] objectForKey:@"pid"];
            talkView.uid = [[dresserArray objectAtIndex:row] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }
        else if([sign isEqualToString:@"2"]) {
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray1 objectAtIndex:row] objectForKey:@"pid"];
            talkView.uid = [[dresserArray1 objectAtIndex:row] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }
        else if([sign isEqualToString:@"3"]) {
            
            
            talkView=nil;
            talkView = [[talkViewController alloc] init];
            talkView.talkOrQuestion=@"question";
            talkView._hidden  =@"yes";
            talkView.questionId= [[dresserArray2 objectAtIndex:row] objectForKey:@"pid"];
            talkView.uid = [[dresserArray2 objectAtIndex:row] objectForKey:@"ta_id"];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:talkView];
            
        }
        
    }

}
-(void)selectCell:(NSInteger)_index
{
    //    wayDeatil = nil;
    //    wayDeatil = [[wayDetailViewController alloc] init];
    //    wayDeatil.inforDic = [dresserArray objectAtIndex:_index];
    //    [self.navigationController pushViewController:wayDeatil animated:NO];
}

-(void)getSmameCityQuestion
{
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    NSURL * urlString= [NSURL URLWithString:@"hhttp://wap.faxingw.cn/index.php?m=Problem&a=findissue"];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.city forKey:@"city"];
    [request startAsynchronous];
    
}

//-(void)requestFinished:(ASIHTTPRequest *)request
//{
//    if (request.tag==1) {
//        NSLog(@"%@",request.responseString);
//        NSData*jsondata = [request responseData];
//        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
//            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
//        dic=[jsonP objectWithString:jsonString];
//        NSLog(@"获取同城问题dic:%@",dic);
//        if ([[dic objectForKey:@"code"] isEqualToString:@"101"])
//        {
//
//            talkView=nil;
//            talkView = [[talkViewController alloc] init];
//            talkView._hidden =@"yes";
//            talkView.talkOrQuestion=@"question";
//            talkView.sameCityQuestion=@"samecity";
//            talkView.questionId= [dic objectForKey:@"pid"];
//            talkView.uid = [dic objectForKey:@"uid"];
//            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
//            
//            [appDele pushToViewController:talkView ];
//        }
//        else
//        {
//            UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"定位失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alert show];
//        }
//        
//    }
//    
//}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidesWhenStopped = YES;
    leftButton.userInteractionEnabled=YES;

    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"出错了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

-(void)questionButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"yes";
        loginView.view.frame=self.view.bounds;
        //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
    }
    else
    {

    if ([appDele.type isEqualToString:@"1"])
    {
        pubQ = nil;
        pubQ = [[pubQViewController alloc] init];
        pubQ._hidden  =@"yes";
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:pubQ];
    }
    else//发型师的同城提问
    {
        [self getSmameCityQuestion];
    }
    }
    
}

-(void)anwserButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"yes";
        loginView.view.frame=self.view.bounds;
        //                [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
    }
    else
    {


    if ([appDele.type isEqualToString:@"1"]) {
        myAnwserView= nil;
        myAnwserView = [[myAnwserCenterViewController alloc] init];
        myAnwserView._hidden  =@"yes";
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        myAnwserView.uid = appDele.uid;
        
        myAnwserView.whoLookQuestion=@"self";
        [appDele pushToViewController:myAnwserView  ];
    }
     else//发型师的回答
    {
        myAnwserList = nil;
        myAnwserList= [[myAnwserListViewController alloc] init];
        myAnwserList._hidden = @"yes";
//        myAnwserList.questionId = [[dresserArray  objectAtIndex:_index] objectForKey:@"id"];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:myAnwserList  ];
    }
        
    }
   
}
-(void)leftButtonClick
{
    [dresserArray2 removeAllObjects];
    leftButton.userInteractionEnabled=NO;
    [self getData2];
    
}
-(void)rightButtonClick
{
    pubQ = nil;
    pubQ = [[pubQViewController alloc] init];
    pubQ._hidden  =@"yes";
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    [appDele pushToViewController:pubQ];
}

-(void)refreashNavLab
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

   
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 7, 100, 30)];
    
    if(!appDele.uid)
    {
    Lab.text = @"问答中心";
    }
    else
    {
    if ([appDele.type isEqualToString:@"1"]) {
        Lab.text = @"我的提问";
    }
    else
    {
        Lab.text = @"问答中心";

    }
    }
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
