//
//  myAnwserCenterViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

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
@interface myAnwserCenterViewController ()

@end

@implementation myAnwserCenterViewController
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
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
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
    
    
    [self getData];
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
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Infostation&a=skilllist"]]];
    if ([sign isEqualToString:@"my"])
    {
        [request setPostValue:appDele.uid forKey:@"uid"];
        
    }
    
    if (![sign isEqualToString:@""]) {
        [request setPostValue:sign forKey:@"condition"];
        
    }
    
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
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@话题dic:%@",sign,dic);
        
        pageCount = [dic objectForKey:@"page_count"];
        if ([[dic objectForKey:@"skill_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"skill_list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"skill_list"];
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
    return dresserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    myAnwserCenterCell *cell=(myAnwserCenterCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[myAnwserCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
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

-(void)leftButtonClick
{
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
    
    
    Lab.text = @"我的提问";
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectCell:(NSInteger)_index
{
    questionDetailView = nil;
    questionDetailView= [[questionDetailViewController alloc] init];
    questionDetailView.inforDic = [dresserArray objectAtIndex:_index];
    [self.navigationController pushViewController:questionDetailView animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end