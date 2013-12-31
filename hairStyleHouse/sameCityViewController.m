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

    self.view.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setBackgroundColor:[UIColor whiteColor]];
    topImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage.layer.masksToBounds = YES;//设为NO去试试
    
    topImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+72, 265, 45)];
    [topImage1 setBackgroundColor:[UIColor whiteColor]];
    topImage1.layer.cornerRadius = 5;//设置那个圆角的有多圆
    topImage1.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    topImage1.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    topImage1.layer.masksToBounds = YES;//设为NO去试试
    
    searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+72, 40, 40)];
    [searchImage setImage:[UIImage imageNamed:@"zhaofaxing1.png"]];
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
    [oneButton setTitle:@"发型师" forState:UIControlStateNormal];
    [twoButton setTitle:@"个人用户" forState:UIControlStateNormal];
    
    keyField = [[UITextField alloc] init];
    keyField.backgroundColor = [UIColor whiteColor];
    keyField.delegate =self;
    keyField.frame= CGRectMake(40, topImage1.frame.origin.y+2, 220, 40);
    
    UIButton * searchButton=[[UIButton alloc] init];
    searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton.layer setMasksToBounds:YES];
    [searchButton.layer setCornerRadius:5.0];
    [searchButton.layer setBorderWidth:1.0];
    [searchButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [searchButton setTitle:@"搜一下" forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [searchButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    searchButton.frame = CGRectMake(265,topImage1.frame.origin.y, 55, topImage1.frame.size.height);
    
    [self.view addSubview:topImage];
    [self.view addSubview:topImage1];
    [self.view addSubview:searchImage];

    [self.view addSubview:keyField];
    [self.view addSubview:searchButton];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    dresserArray2 =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    page=@"1";
    pageCount=[[NSString alloc] init];
    
    dresserArray1 =[[NSMutableArray alloc] init];
    dresserArray3 =[[NSMutableArray alloc] init];
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount1=[[NSString alloc] init];
    
    
    
    sign =[[NSString alloc] init];
    sign = @"hairstylist";
  keyFieldSign=[[NSString alloc] init];
    keyFieldSign=@"";
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 167, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-120) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    [self.view addSubview:myTableView];
    
    bottomRefreshView = [[AllAroundPullView alloc] initWithScrollView:myTableView position:AllAroundPullViewPositionBottom action:^(AllAroundPullView *view){
        NSLog(@"loadMore");
        [self pullLoadMore];
    }];
    bottomRefreshView.hidden=NO;
    [myTableView addSubview:bottomRefreshView];
    
    
    [self getData];
    [self getData1];
}

-(void)searchButtonClick
{
   [keyField resignFirstResponder];
    if ([keyField.text isEqualToString:@""])
    {
        [myTableView reloadData];
    }
    else
    {
        if ([keyField.text isEqualToString: keyFieldSign])
        {
            [myTableView reloadData];
        }
        else
        {
        [self getData2];
        }
    }
    keyFieldSign= keyField.text;
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
    //
    [keyField resignFirstResponder];

    [oneButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    
    sign = @"hairstylist";
    [myTableView reloadData];
    
}
-(void)twoButtonClick
{
    [keyField resignFirstResponder];

    [oneButton setTitleColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
    //    [topImage setImage:[UIImage imageNamed:@"同城发型.png"]];
    //    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    sign=@"person";
    
    [myTableView reloadData];
    
}

-(void)getData2
{
    page=@"1";
    page1=@"1";

    [self getData];
    [self getData1];
}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Near&a=index&page=%@",page]]];
    if (!appDele.uid)
    {
        
    }
    else
    {
        [request setPostValue:appDele.uid forKey:@"uid"];
    }
    
    [request setPostValue:appDele.city forKey:@"city"];
    [request setPostValue:keyField.text forKey:@"keys"];
    [request setPostValue:@"hairstylist" forKey:@"condition"];
    
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}

-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Near&a=index&page=%@",page]]];
    if (!appDele.uid)
    {
        
    }
    else
    {
        [request setPostValue:appDele.uid forKey:@"uid"];
    }
    
    [request setPostValue:appDele.city forKey:@"city"];
    [request setPostValue:keyField.text forKey:@"keys"];
    [request setPostValue:@"person" forKey:@"condition"];
    
    request.delegate=self;
    request.tag=2;
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.tag==1) {
        NSMutableArray * arr;

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
            if ([keyField.text isEqualToString:@""]) {
                [dresserArray addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray.count);


            }
            else
            {
                [dresserArray2 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray2.count);


            }
            
        }
        [self freashView];
    }
    
    else if (request.tag==2) {
        NSMutableArray * arr;

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
            if ([keyField.text isEqualToString:@""]) {
                [dresserArray1 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray1.count);

                
            }
            else
            {
                [dresserArray3 addObjectsFromArray:arr];
                NSLog(@"dresser.count:%d",dresserArray3.count);

            }
            
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
    if ([sign isEqualToString:@"person"])//个人用户
    {
        if ([keyField.text isEqualToString:@""])//未搜索
        {
            return dresserArray1.count;

        }
        else
        {
            return dresserArray3.count;

        }

    }
    else//发型师
    {
        if ([keyField.text isEqualToString:@""])//未搜索
        {
            return dresserArray.count;
            
        }
        else
        {
            return dresserArray2.count;
            
        }

    }
    
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
   
    cell.backgroundColor = [UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
    
    if ([sign isEqualToString:@"person"]) {
        
        if ([keyField.text isEqualToString:@""])//未搜索
        {
            
            [cell setCell:[dresserArray1 objectAtIndex:row] andIndex:row];

        }
        else
        {
            [cell setCell:[dresserArray3 objectAtIndex:row] andIndex:row];

        }
        
    }
    else
    {
        if ([keyField.text isEqualToString:@""])//未搜索
        {
            [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
            
        }
        else
        {
            [cell setCell:[dresserArray2 objectAtIndex:row] andIndex:row];
            
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
    [leftButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
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
