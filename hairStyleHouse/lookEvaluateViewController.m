//
//  lookEvaluateViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "lookEvaluateViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "BaiduMobStat.h"
@interface lookEvaluateViewController ()

@end

@implementation lookEvaluateViewController
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/4, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton setTitle:@"全部" forState:UIControlStateNormal];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/4,self.navigationController.navigationBar.frame.size.height+20, 320/4, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton setTitle:@"好评" forState:UIControlStateNormal];
    
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/4,self.navigationController.navigationBar.frame.size.height+20, 320/4, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton setTitle:@"中评" forState:UIControlStateNormal];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    forthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forthButton.frame = CGRectMake(320*3/4,self.navigationController.navigationBar.frame.size.height+20, 320/4, 50);
    forthButton.backgroundColor = [UIColor clearColor];
    [forthButton setTitle:@"差评" forState:UIControlStateNormal];
    
    [forthButton addTarget:self action:@selector(forthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    [self.view addSubview:forthButton];
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
    dresserArray3 =[[NSMutableArray alloc] init];
    page3 =[[NSString alloc] init];
    page3=@"1";
    pageCount3=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"1";
    myTableView=[[YFJLeftSwipeDeleteTableView alloc] initWithFrame:CGRectMake(0, topImage.frame.size.height+topImage.frame.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-topImage.frame.size.height-20) style:UITableViewStylePlain];
    myTableView.allowsSelection=YES;
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
    [self getData3];
}

-(void)oneButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"1";
    
    
    
        [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
     [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign =@"2";
    
    
        [myTableView reloadData];
    
}
-(void)thirdButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
     [forthButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign=@"3";
    
        [myTableView reloadData];
    
    
}
-(void)forthButtonClick
{
    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [thirdButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [forthButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    sign=@"4";
    
    [myTableView reloadData];
    
    
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
    else if([sign isEqualToString:@"4"]) {
        NSInteger _pageCount= [pageCount3 integerValue];
        
        NSInteger _page = [page3 integerValue];
        
        NSLog(@"page:%@",page3);
        NSLog(@"pageCount:%@",pageCount3);
        
        if (_page<_pageCount) {
            _page++;
            page3 = [NSString stringWithFormat:@"%d",_page];
            NSLog(@"page:%@",page3);
            [self getData3];
        }
        else
        {
            [bottomRefreshView performSelector:@selector(finishedLoading)];
            
        }
        
    }
}

#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"评价列表"];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"评价列表"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}

    -(void)leftButtonClick
    {
        if ([_hidden isEqualToString:@"yes"]) {
            self.navigationController.navigationBar.hidden =YES;
        }
        else
        {
            self.navigationController.navigationBar.hidden =NO;

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
        Lab.text = @"评价列表";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }
    -(void)getData
    {
        
           NSURL * urlString= [NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=evaluateList&%@",page]];
            ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
            request.delegate=self;
            request.tag=1;
            [request setPostValue:self.uid forKey:@"uid"];
        [request setPostValue:@"0" forKey:@"score"];
            [request startAsynchronous];
    }
-(void)getData1
{
    
    NSURL * urlString= [NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=evaluateList&%@",page1]];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=2;
    [request setPostValue:self.uid forKey:@"uid"];
    [request setPostValue:@"1" forKey:@"score"];
    [request startAsynchronous];
}

-(void)getData2
{
    
    NSURL * urlString= [NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=evaluateList&%@",page2]];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=3;
    [request setPostValue:self.uid forKey:@"uid"];
    [request setPostValue:@"2" forKey:@"score"];
    [request startAsynchronous];
}

-(void)getData3
{
    
   NSURL * urlString= [NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/wapapp.php?g=wap&m=reserve&a=evaluateList&%@",page3]];
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:urlString];
    request.delegate=self;
    request.tag=4;
    [request setPostValue:self.uid forKey:@"uid"];
    [request setPostValue:@"3" forKey:@"score"];
    [request startAsynchronous];
}


    -(void)requestFinished:(ASIHTTPRequest *)request
    {
        
        if (request.tag==1) {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"评价列表dic:%@",dic);
            pageCount=[dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSArray class]])
            {
                NSArray * arr;
                arr = [dic objectForKey:@"assessList"];//评价列表
                [dresserArray addObjectsFromArray:arr];
            }
            [self freashView];
        }
        else if (request.tag==2) {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"评价列表dic:%@",dic);
            pageCount1=[dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSArray class]])
            {
                NSArray * arr;
                arr = [dic objectForKey:@"assessList"];//评价列表
                [dresserArray1 addObjectsFromArray:arr];
            }
            [self freashView];
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
            NSLog(@"评价列表dic:%@",dic);
            pageCount2=[dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSArray class]])
            {
                NSArray * arr;
                arr = [dic objectForKey:@"assessList"];//评价列表
                [dresserArray2 addObjectsFromArray:arr];
            }
            [self freashView];
        }
        else if (request.tag==4) {
            NSLog(@"%@",request.responseString);
            NSData*jsondata = [request responseData];
            NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            SBJsonParser* jsonP=[[SBJsonParser alloc] init];
            NSDictionary* dic=[jsonP objectWithString:jsonString];
            NSLog(@"评价列表dic:%@",dic);
            pageCount3=[dic objectForKey:@"page_count"];
            if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"assessList"] isKindOfClass:[NSArray class]])
            {
                NSArray * arr;
                arr = [dic objectForKey:@"assessList"];//评价列表
                [dresserArray3 addObjectsFromArray:arr];
            }
            [self freashView];
        }

    }
    -(void)freashView
    {
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
        else if([sign isEqualToString:@"4"]) {
            return dresserArray3.count;

        }
        else{
            return 0;
        }
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        //初始化label
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,0,0)];
        //设置自动行数与字符换行
//        [label setNumberOfLines:0];
//        label.lineBreakMode = UILineBreakModeWordWrap;
//        [label setFrame:CGRectMake(0,0, labelsize.width, labelsize.height)];
        
        
        // 测试字串
        NSString *_content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"info"];
        UIFont *font = [UIFont systemFontOfSize:12.0];
        //设置一个行高上限
        CGSize size = CGSizeMake(180,2000);
        //计算实际frame大小，并将label的frame变成实际大小
        CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];

        if ([_content isEqualToString:@""]) {
            return 100;
        }
        else
        {
        return   85+labelsize.height;
        }
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellID=@"cell";
        lookEvaluateCell *cell=(lookEvaluateCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[lookEvaluateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        NSInteger row =[indexPath row];
        if ([sign isEqualToString:@"1"]) {
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
            
        }
        else if([sign isEqualToString:@"2"]) {
           [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];
            
        }
        else if([sign isEqualToString:@"3"]) {
            [cell setCell:[dresserArray2 objectAtIndex:row] andIndex:row];
            
        }
        else if([sign isEqualToString:@"4"]) {
            [cell setCell:[dresserArray3 objectAtIndex:row] andIndex:row];
            
        }
        
        return cell;
    }
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
