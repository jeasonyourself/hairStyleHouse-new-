//
//  addbeaspeakHairStyleCell.m
//  hairStyleHouse
//
//  Created by jeason on 14-1-11.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "addbeaspeakHairStyleCell.h"
#import "addBeaspeakHairStyleViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "addBeaspeakHairStyleViewController.h"
@implementation addbeaspeakHairStyleCell
@synthesize fatherController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        
        picBackView = [[UIView alloc] init];
        picBackView.layer.cornerRadius = 5;//设置那个圆角的有多圆
        picBackView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        picBackView.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        picBackView.layer.masksToBounds = YES;//设为NO去试试
        
        picImage  = [[UIImageView alloc] init];
        picImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        picImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        picImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        picImage.layer.masksToBounds = YES;//设为NO去试试
        
        headBack = [[UIView alloc] init];
        headBack.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headBack.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headBack.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headBack.layer.masksToBounds = YES;//设为NO去试试
        
        headImage = [[UIImageView alloc] init];
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headImage.layer.masksToBounds = YES;//设为NO去试试
        
        headButton = [[UIButton alloc] init];
        
        nameLable= [[UILabel alloc] init];
        
        oldPriceLable= [[UILabel alloc] init];
        nowPriceLable= [[UILabel alloc] init];
        
        
        addressLable = [[UILabel alloc] init];
        distanceLable = [[UILabel alloc] init];
        
        contentLable= [[UILabel alloc] init];
        likeScroll= [[UIScrollView alloc] init];
        howMuchLable= [[UILabel alloc] init];
        howMuchLable.font = [UIFont systemFontOfSize:12.0];
        timeLable= [[UILabel alloc] init];
        
        
        beaspeakButton = [[UIButton alloc]init];
        [beaspeakButton setTitle:@"预约" forState:UIControlStateNormal];
        [beaspeakButton addTarget:self  action:@selector(beaspeakButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        beaspeakButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [beaspeakButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
       
        beaspeakButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        beaspeakButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        beaspeakButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        beaspeakButton.layer.masksToBounds = YES;//设为NO去试试
        
        askButton = [[UIButton alloc]init];
        [askButton setTitle:@"咨询" forState:UIControlStateNormal];
        [askButton addTarget:self  action:@selector(askButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        askButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [askButton setBackgroundColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        askButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        askButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        askButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        askButton.layer.masksToBounds = YES;//设为NO去试试

        [self addSubview:picImage];
        [self addSubview:headBack];
        [self addSubview:headImage];
        [self addSubview:headButton];
        [self addSubview:nameLable];
        [self addSubview:oldPriceLable];
        [self addSubview:nowPriceLable];
        [self addSubview:contentLable];
        [self addSubview:addressLable];
        [self addSubview:distanceLable];
        [self addSubview:likeScroll];
        [self addSubview:howMuchLable];
        [self addSubview:timeLable];
        [self addSubview:beaspeakButton];
        [self addSubview:askButton];

        // Initialization code
    }
    return self;
}

-(void)setFirstCell:(NSDictionary * )_dic andArr:(NSMutableArray *)_arr
{

    picBackView.frame = CGRectMake(55, 5, 210, 230);
    
    NSString* picStr = [_dic objectForKey:@"work_image"];
    [picImage setImageWithURL:[NSURL URLWithString:picStr]];
    picImage.frame = CGRectMake(60, 10, 200, 220);
    
    NSString* headStr = [_dic objectForKey:@"head_photo"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(10, 240, 70, 70);
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor=[UIColor clearColor];
    headButton.frame=headImage.frame;
    [headButton addTarget:self  action:@selector(selectHeadImage) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[_dic objectForKey:@"works_info"] objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        headButton.userInteractionEnabled=NO;
    }
    else
    {
        headButton.userInteractionEnabled=YES;
    }
    
    NSString* nameStr = [_dic objectForKey:@"username"] ;
    nameLable.text=[NSString stringWithFormat:@"发型师：%@",nameStr];
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(85, 245, 200, 20);
    
    beaspeakButton.frame = CGRectMake(220, 250, 40, 25);
    beaspeakButton.tag=-1;
    askButton.frame = CGRectMake(270, 250, 40, 25);
    askButton.tag=-1;
    
    NSString* contentStr = [_dic  objectForKey:@"long_service"];
    if ([contentStr isEqualToString:@"0"]) {
        contentLable.text=@"服务时长:暂无";
    }
    else
    {
    contentLable.text=[NSString stringWithFormat:@"服务时长约：%@",contentStr];
    }
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.frame = CGRectMake(85, 265, 200, 20);
    
    
    NSString* oldPriceStr = [_dic  objectForKey:@"price"];
    if ([oldPriceStr isEqualToString:@"0.00"]) {
        oldPriceLable.text=@"平时价格：暂无";
    }
    else
    {
        oldPriceLable.text=[NSString stringWithFormat:@"平时价格：%@元",oldPriceStr];
    }
    oldPriceLable.font = [UIFont systemFontOfSize:12];
    oldPriceLable.frame = CGRectMake(85, 285, 120, 20);
    
    
    NSString* nowPriceStr = [_dic  objectForKey:@"reserve_price"];
    if ([nowPriceStr isEqualToString:@"0.00"]) {
        nowPriceLable.text=@"优惠价格：暂无";
    }
    else
    {
        nowPriceLable.text=[NSString stringWithFormat:@"优惠价格：%@元（%@折扣）",nowPriceStr,[_dic  objectForKey:@"rebate"]];
    }
    nowPriceLable.font = [UIFont systemFontOfSize:12];
    nowPriceLable.frame = CGRectMake(210, 285, 120, 20);
    
    NSString* addressStr = [_dic objectForKey:@"store_address"] ;
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if (labelsize.height<20)
    {
       addressLable.frame = CGRectMake(15, 310, 200, 20);
        howMuchLable.frame = CGRectMake(10, 330, 300, 20);
    }
    else
    {
       addressLable.frame = CGRectMake(15, 310, 200, labelsize.height);
        howMuchLable.frame = CGRectMake(10, 315+labelsize.height, 300, 20);
    }
    addressLable.text = addressStr;
    addressLable.numberOfLines = 0;
    addressLable.font = [UIFont systemFontOfSize:12];


    NSString* distanceStr = [_dic objectForKey:@"distance"] ;
    distanceLable.text = distanceStr;
    distanceLable.textAlignment = NSTextAlignmentCenter;

    distanceLable.font = [UIFont systemFontOfSize:12];
     distanceLable.frame = CGRectMake(220, 310, 100, 20);
    
    if (_arr.count==0)
    {
        howMuchLable.text=@"暂无会做此款发型的同城其他发型师";
    }
    else
    {
        howMuchLable.text=[NSString stringWithFormat:@"以下是同城会做此款发型的发型师及优惠信息"];
    }
    
    
    timeLable.frame = CGRectMake(0, 0, 0, 0);
    
    
}

-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index
{
    picImage.frame = CGRectMake(0, 0, 0, 0);
    picBackView.frame = CGRectMake(0, 0, 0, 0);
    
    NSString* picStr = [[_arr objectAtIndex:_index-1] objectForKey:@"work_image"];
    [picImage setImageWithURL:[NSURL URLWithString:picStr]];
    picImage.frame = CGRectMake(0, 0, 0, 0);
    
    NSString* headStr = [[_arr objectAtIndex:_index-1] objectForKey:@"head_photo"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(10, 5, 70, 70);
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor=[UIColor clearColor];
    headButton.frame=headImage.frame;
    [headButton addTarget:self  action:@selector(selectHeadImage) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[[_arr objectAtIndex:_index-1] objectForKey:@"works_info"] objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        headButton.userInteractionEnabled=NO;
    }
    else
    {
        headButton.userInteractionEnabled=YES;
    }
    
    NSString* nameStr = [[_arr objectAtIndex:_index-1] objectForKey:@"username"] ;
    nameLable.text=[NSString stringWithFormat:@"发型师：%@",nameStr];
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(85, 10, 200, 20);
    
    beaspeakButton.frame = CGRectMake(220, 15, 40, 25);
    askButton.frame = CGRectMake(270, 15, 40, 25);
    beaspeakButton.tag=_index-1;
    askButton.tag=_index-1;
    
    NSString* contentStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"long_service"];
    if ([contentStr isEqualToString:@"0"]) {
        contentLable.text=@"服务时长:暂无";
    }
    else
    {
        contentLable.text=[NSString stringWithFormat:@"服务时长约：%@",contentStr];
    }
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.frame = CGRectMake(85, 30, 200, 20);
    
    
    NSString* oldPriceStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"price"];
    if ([oldPriceStr isEqualToString:@"0.00"]) {
        oldPriceLable.text=@"平时价格：暂无";
    }
    else
    {
        oldPriceLable.text=[NSString stringWithFormat:@"平时价格：%@元",oldPriceStr];
    }
    oldPriceLable.font = [UIFont systemFontOfSize:12];
    oldPriceLable.frame = CGRectMake(85, 50, 100, 20);
    
    
    NSString* nowPriceStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"reserve_price"];
    if ([nowPriceStr isEqualToString:@"0.00"]) {
        nowPriceLable.text=@"优惠价格：暂无";
    }
    else
    {
        nowPriceLable.text=[NSString stringWithFormat:@"优惠价格：%@元（%@折扣）",nowPriceStr,[[_arr objectAtIndex:_index-1]  objectForKey:@"rebate"]];
    }
    nowPriceLable.font = [UIFont systemFontOfSize:12];
    nowPriceLable.frame = CGRectMake(180, 50, 100, 20);
    
    NSString* addressStr = [[_arr objectAtIndex:_index-1] objectForKey:@"store_address"] ;
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if (labelsize.height<20)
    {
        addressLable.frame = CGRectMake(15, 75, 200, 20);
        howMuchLable.frame = CGRectMake(0, 0, 0, 0);
    }
    else
    {
        addressLable.frame = CGRectMake(15, 75, 200, labelsize.height);
        howMuchLable.frame = CGRectMake(0, 0, 0, 0);
    }
    addressLable.text = addressStr;
    addressLable.numberOfLines = 0;

    addressLable.font = [UIFont systemFontOfSize:12];
    
    
    NSString* distanceStr = [[_arr objectAtIndex:_index-1] objectForKey:@"distance"] ;
    distanceLable.text = distanceStr;
    distanceLable.textAlignment = NSTextAlignmentCenter;
    
    distanceLable.font = [UIFont systemFontOfSize:12];
    distanceLable.frame = CGRectMake(220, 75, 100, 20);
    
    if (_arr.count==0)
    {
        howMuchLable.text=@"暂无会做此款发型的同城其他发型师";
    }
    else
    {
        howMuchLable.text=[NSString stringWithFormat:@"以下是同城会做此款发型的发型师及优惠信息"];
    }
    
    
    timeLable.frame = CGRectMake(0, 0, 0, 0);
}

-(void)selectHeadImage
{
    
}
-(void)selectImage:(UIButton *)_btn
{
    
}
-(void)selectHeadImage1:(UIButton *)_btn
{
    
}

-(void)beaspeakButtonClick:(UIButton*)btn 
{
 [fatherController beaspeakButtonClick:btn.tag andImage:picImage];
}

-(void)askButtonClick:(UIButton*)btn
{
    [fatherController askButtonClick:btn.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

