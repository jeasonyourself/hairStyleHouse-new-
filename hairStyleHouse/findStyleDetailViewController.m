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
    
    dresserArray =[[NSMutableArray alloc] init];
    dresserArray1 =[[NSMutableArray alloc] init];
    cleandresserArray =[[NSMutableArray alloc] init];
    cleandresserArray1 =[[NSMutableArray alloc] init];

    page =[[NSString alloc] init];
    page=@"1";
    page1 =[[NSString alloc] init];
    page1=@"1";
    pageCount=[[NSString alloc] init];
    pageCount1=[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign=@"1";
    
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
    request.tag=1;
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
    request.tag=2;
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    
    if (request.tag==1)
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
        if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
        {
            arr= [dic objectForKey:@"works_info"];
            [dresserArray addObjectsFromArray:arr];
            NSLog(@"dresser.count:%d",dresserArray.count);
            
        }
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            cleanarr= [dic objectForKey:@"image_list"];
            [cleandresserArray addObjectsFromArray:cleanarr];
            NSLog(@"dresser1.count:%d",cleandresserArray.count);
            
        }
        [self freashView];
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
       if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
       {
           
       }
       else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
       {
           arr= [dic objectForKey:@"works_info"];
           [dresserArray1 addObjectsFromArray:arr];
           NSLog(@"dresser.count:%d",dresserArray1.count);
           
       }
       if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
       {
           
       }
       else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
       {
           cleanarr= [dic objectForKey:@"image_list"];
           [cleandresserArray1 addObjectsFromArray:cleanarr];
           NSLog(@"dresser1.count:%d",cleandresserArray1.count);
           
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
    if ([sign isEqualToString:@"1"]) {
        if (dresserArray.count%3==0)
        {
            return dresserArray.count/3;
        }
        else
        {
            return dresserArray.count/3+1;
        }
        
    }
    else
    {
        if (dresserArray1.count%3==0)
        {
            return dresserArray1.count/3;
        }
        else
        {
            return dresserArray1.count/3+1;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   122;

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
        [cell setCell:[dresserArray objectAtIndex:row1] andIndex:row1];
        
        if (row2<dresserArray.count)//防止可能越界
        {
            [cell setCell:[dresserArray objectAtIndex:row2] andIndex:row2];
        }
        if (row3<dresserArray.count)//防止可能越界
        {
            [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
        }
    }
    else
    {
        [cell setCell:[dresserArray1 objectAtIndex:row1] andIndex:row1];
        
        if (row2<dresserArray1.count)//防止可能越界
        {
            [cell setCell:[dresserArray1 objectAtIndex:row2] andIndex:row2];
        }
        if (row3<dresserArray1.count)//防止可能越界
        {
            [cell setCell:[dresserArray1 objectAtIndex:row3] andIndex:row3];
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
    if ([sign isEqualToString:@"1"]) {
        int count = cleandresserArray.count;
        // 1.封装图片数据
        NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
        for (int i = 0; i<count; i++) {
            // 替换为中等尺寸图片
            NSString *url = [[cleandresserArray[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.work_id =[cleandresserArray[i] objectForKey:@"work_id"];
            photo.url = [NSURL URLWithString:url]; // 图片路径
            //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
            [photos addObject:photo];
        }
        
        // 2.显示相册
        browser=nil;
        browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = _index; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
    }
   else
   {
       int count = cleandresserArray1.count;
       // 1.封装图片数据
       NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
       for (int i = 0; i<count; i++) {
           // 替换为中等尺寸图片
           NSString *url = [[cleandresserArray1[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
           MJPhoto *photo = [[MJPhoto alloc] init];
           photo.work_id =[cleandresserArray1[i] objectForKey:@"work_id"];
           photo.url = [NSURL URLWithString:url]; // 图片路径
           //        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
           [photos addObject:photo];
       }
       
       // 2.显示相册
       browser=nil;
       browser = [[MJPhotoBrowser alloc] init];
       browser.currentPhotoIndex = _index; // 弹出相册时显示的第一张图片是？
       browser.photos = photos; // 设置所有的图片
   }
    [self.navigationController pushViewController:browser animated:YES];
//    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
