//
//  sameCityViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "sameCityViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "AllAroundPullView.h"
@interface sameCityViewController ()

@end

@implementation sameCityViewController
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
    self.view.backgroundColor = [UIColor lightGrayColor];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setImage:[UIImage imageNamed:@"发型师.png"]];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    keyField = [[UITextField alloc] init];
    keyField.backgroundColor = [UIColor whiteColor];
    keyField.delegate =self;
    keyField.frame= CGRectMake(40, topImage.frame.origin.y+topImage.frame.size.height+10, 210, 30);
    
    UIButton * searchButton=[[UIButton alloc] init];
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton.layer setMasksToBounds:YES];
    [searchButton.layer setCornerRadius:3.0];
    [searchButton.layer setBorderWidth:1.0];
    [searchButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [searchButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(265,topImage.frame.origin.y+topImage.frame.size.height+10, 40, 30);
    
    [self.view addSubview:topImage];
    [self.view addSubview:keyField];
    [self.view addSubview:searchButton];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"hairstylist";
   
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 170, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-120) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
}

-(void)searchButtonClick
{
   [keyField resignFirstResponder];
   [self getData2];
}
-(void)pullLoadMore
{
//    NSInteger _pageCount= [pageCount integerValue];
//    
//    NSInteger _page = [page integerValue];
//    
//    NSLog(@"page:%@",page);
//    NSLog(@"pageCount:%@",pageCount);
//    
//    if (_page<_pageCount) {
//        _page++;
//        page = [NSString stringWithFormat:@"%d",_page];
//        NSLog(@"page:%@",page);
//        [self getData];
//    }
//    else
//    {
        [bottomRefreshView performSelector:@selector(finishedLoading)];
        
//    }
}

-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"发型师.png"]];
    sign =@"hairstylist";
    page=@"1";
    [dresserArray removeAllObjects];
    [self getData];
    
}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"个人用户.png"]];
    //    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    sign =@"person";
    page=@"1";
    [dresserArray removeAllObjects];
    [self getData];
}
-(void)thirdButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"店铺.png"]];
    sign =@"store";
    page=@"1";
    [dresserArray removeAllObjects];
    [self getData];
    
}

-(void)getData2
{
    page=@"1";
    [dresserArray removeAllObjects];
    
    [self getData];
}
-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Near&a=index"]]];
    if (!appDele.uid)
    {
        
    }
    else
    {
        [request setPostValue:appDele.uid forKey:@"uid"];
    }
    
    [request setPostValue:appDele.city forKey:@"city"];
    [request setPostValue:keyField.text forKey:@"keys"];
    [request setPostValue:sign forKey:@"condition"];
    
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
        NSLog(@"同城dic：%@",dic);
        
        pageCount = [dic objectForKey:@"count"];
        if ([[dic objectForKey:@"list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"list"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"list"];
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
    NSString *_content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(260,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    if ([_content isEqualToString:@""]) {
        return   80;
    }
    else
    {
        return 80+labelsize.height;
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    sameCityCell *cell=(sameCityCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[sameCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherController =self;
    }
    NSUInteger row = [indexPath row];
   
    cell.backgroundColor = [UIColor lightGrayColor];
    [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    
   
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
    
    UIButton * rightButton=[[UIButton alloc] init];
    rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton.layer setMasksToBounds:YES];
    [rightButton.layer setCornerRadius:3.0];
    [rightButton.layer setBorderWidth:1.0];
    [rightButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    [rightButton setTitle:appDele.city forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [rightButton setBackgroundColor:[UIColor clearColor]];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    rightButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *rightButtonItem=[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=rightButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"同城";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectCell:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
    }
    else
    {
        dreserView =nil;
        dreserView =[[dresserInforViewController alloc] init];
        dreserView._hidden=@"no";
        dreserView.uid = [[dresserArray objectAtIndex:_index ] objectForKey:@"id"];
        NSLog(@"%@", dreserView.uid);
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:dreserView ];
    }
}

-(void)didFouce:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView._hidden=@"no";
        
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData2) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
        
    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"id"] forKey:@"touid"];
        [request setPostValue:appDele.type forKey:@"type"];
        [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
        if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
            [request setPostValue:@"0" forKey:@"status"];
        }
        else
        {
            [request setPostValue:@"1" forKey:@"status"];
        }
        
        [request startAsynchronous];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [keyField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
