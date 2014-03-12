//
//  DemoViewController.m
//  SlideImageView
//
//  Created by rd on 12-12-17.
//  Copyright (c) 2012年 LXJ_成都. All rights reserved.
//

#import "DemoViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "BaiduMobStat.h"
@interface DemoViewController ()

@end

@implementation DemoViewController
@synthesize imageArr;
@synthesize getindex;
- (id)init
{
    self = [super init];
    if (self) {
        CGRect rect = {{20,100},{250,300}};
        slideImageView = [[SlideImageView alloc]initWithFrame:rect ZMarginValue:5 XMarginValue:10 AngleValue:0.3 Alpha:1000];
        slideImageView.borderColor = [UIColor whiteColor];
        slideImageView.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view addSubview:slideImageView];
//    indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 300, 40)];
//    indexLabel.font = [UIFont systemFontOfSize:20.f];
//    indexLabel.text = @"当前为第0张";
//    [self.view addSubview:indexLabel];
//    clickLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 430, 300, 40)];
//    clickLabel.font = [UIFont systemFontOfSize:18.f];
//    clickLabel.text = @"点击了第  张";
//    [self.view addSubview:clickLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self refreashNavLab];
    [self refreashNav];
	// Do any additional setup after loading the view.
    for(int i=0; i<imageArr.count; i++)
    {
        NSString * imageStr = [[imageArr objectAtIndex:i] objectForKey:@"work_image"];
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:imageStr]];
         UIImage* image = imageView.image;
        [slideImageView addImage:image];
    }
    NSLog(@"index:%@",getindex);
    slideImageView.page=getindex;
//    [slideImageView setImageShadowsWtihDirectionX:2 Y:2 Alpha:0.7];
    [slideImageView setImageShadowsWtihDirectionX:0 Y:0 Alpha:0];

    [slideImageView reLoadUIview];
    
    diction = [[NSDictionary alloc] init];
    dic = [[NSDictionary alloc] init];
    lineBack = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-120, 320, 120)];
//    lineBack.backgroundColor = [UIColor redColor];
    headBack = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    headBack.backgroundColor = [UIColor whiteColor];
    headImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
    [headBack addSubview: headImage];
    [lineBack addSubview:headBack];
    
    nameLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 25)];
    nameLable.textColor =[UIColor blackColor];
    nameLable.font = [UIFont systemFontOfSize:12.0];
    [lineBack addSubview:nameLable];
    cityLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 200, 25)];
    cityLable.textColor =[UIColor blackColor];
    cityLable.font = [UIFont systemFontOfSize:12.0];
    [lineBack addSubview:cityLable];

    
    messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 80, 30, 25)];
    messageImage.image = [UIImage imageNamed:@"sixin.png"];
    messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    messageButton.frame = messageImage.frame;
    
    commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 30, 25)];
    commentImage.image = [UIImage imageNamed:@"comment.png"];
    commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    commentButton.frame = commentImage.frame;

    likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(240, 80, 30, 25)];
    likeImage.image = [UIImage imageNamed:@"like.png"];
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    likeButton.frame = likeImage.frame;

    shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 80, 30, 25)];
    shareImage.image = [UIImage imageNamed:@"fenxiang.png"];
    shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    shareButton.frame = shareImage.frame;

    
    [lineBack addSubview:messageImage];
    [lineBack addSubview:commentImage];
    [lineBack addSubview:likeImage];
    [lineBack addSubview:shareImage];
    [lineBack addSubview:messageButton];
    [lineBack addSubview:commentButton];
    [lineBack addSubview:likeButton];
    [lineBack addSubview:shareButton];
    [self.view addSubview:lineBack];

    [self getData];
    
}


#pragma mark - View lifecycle

-(void) viewDidAppear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"%@",  self.tabBarItem.title, nil];
    [[BaiduMobStat defaultStat] pageviewStartWithName:cName];
    
}

-(void) viewDidDisappear:(BOOL)animated
{
    NSString* cName = [NSString stringWithFormat:@"%@", self.tabBarItem.title, nil];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
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
}
-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden =YES;
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = [NSString stringWithFormat:@"浏览图片(%d/%d)",[getindex integerValue]+1,imageArr.count];
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}


-(void)getData
{
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Dynamic&a=workinfo"]]];
    request.delegate=self;
    request.tag=1;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:[[imageArr objectAtIndex:[getindex integerValue]] objectForKey:@"work_id"] forKey:@"work_id"];
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
//    if (dresserArray!=nil) {
//        [dresserArray removeAllObjects];
//    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片详情：dic:%@",dic);
        
        diction =[dic objectForKey:@"works_info"];
        
    }
    else if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
            jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        dic=[jsonP objectWithString:jsonString];
        NSLog(@"收藏dic:%@",dic);
        [self getData];
    }
    [self freashView];

}
-(void)freashView
{
    [headImage setImageWithURL:[NSURL URLWithString:[diction objectForKey:@"head_photo"]]];
    nameLable.text = [diction objectForKey:@"username"];
    cityLable = [diction objectForKey:@"content"];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    if ([[diction objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        messageImage.hidden=YES;
    }
    else
    {
        messageImage.hidden=NO;
    }
    
    if ([[diction objectForKey:@"islike"] isEqualToString:@"0"])
    {
        likeButton.tag=0;
        likeImage.image = [UIImage imageNamed:@"like.png"];

    }
    else
    {
        likeButton.tag=1;
        likeImage.image = [UIImage imageNamed:@"like1.png"];
    }
}

-(void)messageButtonClick
{

}
-(void)commentButtonClick
{
    commentController= nil;
    commentController = [[commentViewController alloc] init];
    commentController.inforDic = dic;

    [self.navigationController pushViewController:commentController animated:NO];
}
-(void)likeButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Works&a=collection"]]];
    request.delegate=self;
    request.tag=2;
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:[diction objectForKey:@"uid"] forKey:@"to_uid"];
    [request setPostValue:[diction objectForKey:@"work_id"] forKey:@"work_id"];
    if (likeButton.tag==0)
    {
        likeButton.tag=1;
        likeImage.image = [UIImage imageNamed:@"like1.png"];
        [request setPostValue:@"1" forKey:@"status"];
        
    }
    else
    {
        likeButton.tag=0;
        likeImage.image = [UIImage imageNamed:@"like.png"];
        [request setPostValue:@"0" forKey:@"status"];

    }
    [request startAsynchronous];

}
-(void)shareButtonClick
{

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)SlideImageViewDidClickWithIndex:(int)index//点击图片
{

}

- (void)SlideImageViewDidEndScorllWithIndex:(int)index//滑动视图
{
    getindex=[NSString stringWithFormat:@"%d",index ];
    [self refreashNavLab];
    [self getData];
}
@end
