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
@implementation addbeaspeakHairStyleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        picBackView = [[UIView alloc] init];
        picBackView.layer.cornerRadius = 5;//设置那个圆角的有多圆
        picBackView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        picBackView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        picBackView.layer.masksToBounds = YES;//设为NO去试试
        
        picImage  = [[UIImageView alloc] init];
        picImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        picImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        picImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        picImage.layer.masksToBounds = YES;//设为NO去试试
        
        headBack = [[UIView alloc] init];
        headBack.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headBack.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headBack.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headBack.layer.masksToBounds = YES;//设为NO去试试
        
        headImage = [[UIImageView alloc] init];
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
        [beaspeakButton setBackgroundColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
       
        beaspeakButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        beaspeakButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        beaspeakButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        beaspeakButton.layer.masksToBounds = YES;//设为NO去试试
        
        askButton = [[UIButton alloc]init];
        [askButton setTitle:@"咨询" forState:UIControlStateNormal];
        [askButton setBackgroundColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        askButton.layer.cornerRadius = 5;//设置那个圆角的有多圆
        askButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        askButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
    
    beaspeakButton.frame = CGRectMake(200, 250, 50, 30);
    askButton.frame = CGRectMake(260, 250, 50, 30);

    
    NSString* contentStr = [_dic  objectForKey:@"long_service"];
    if ([contentStr isEqualToString:@"0"]) {
        contentLable.text=@"服务时长:暂无";
    }
    else
    {
    contentLable.text=[NSString stringWithFormat:@"服务时长约：%@小时",contentStr];
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
    oldPriceLable.frame = CGRectMake(85, 285, 100, 20);
    
    
    NSString* nowPriceStr = [_dic  objectForKey:@"reserve_price"];
    if ([nowPriceStr isEqualToString:@"0.00"]) {
        nowPriceLable.text=@"优惠价格：暂无";
    }
    else
    {
        nowPriceLable.text=[NSString stringWithFormat:@"优惠价格：%@元（%@折扣）",nowPriceStr,[_dic  objectForKey:@"rebate"]];
    }
    nowPriceLable.font = [UIFont systemFontOfSize:12];
    nowPriceLable.frame = CGRectMake(180, 285, 100, 20);
    
    NSString* addressStr = [_dic objectForKey:@"store_address"] ;
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if (labelsize.height<20)
    {
       addressLable.frame = CGRectMake(15, 310, 200, 20);
        howMuchLable.frame = CGRectMake(10, 330, 200, 20);
    }
    else
    {
       addressLable.frame = CGRectMake(15, 310, 200, labelsize.height);
        howMuchLable.frame = CGRectMake(10, 315+labelsize.height, 200, 20);
    }
    addressLable.text = addressStr;
    addressLable.font = [UIFont systemFontOfSize:12];


    NSString* distanceStr = [_dic objectForKey:@"distance"] ;
    distanceLable.text = distanceStr;
    distanceLable.font = [UIFont systemFontOfSize:12];
     distanceLable.frame = CGRectMake(250, 310, 100, 20);
    
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
//明天在这改，其他cell还没设置
-(void)setOtherCell:(NSMutableArray *)_arr and:(NSInteger)_index
{
    picImage.frame = CGRectMake(0, 0, 0, 0);
    NSString* headStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"head_photo"];
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.frame = CGRectMake(5, 5, 50, 50);
    headButton=[UIButton buttonWithType:UIButtonTypeCustom];
    headButton.backgroundColor=[UIColor clearColor];
    headButton.frame=headImage.frame;
    [headButton addTarget:self  action:@selector(selectHeadImage1:) forControlEvents:UIControlEventTouchUpInside];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if ([[[_arr objectAtIndex:_index-1]objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        headButton.userInteractionEnabled=NO;
    }
    else
    {
        headButton.userInteractionEnabled=YES;
    }
    NSString* nameStr = [[_arr objectAtIndex:_index-1] objectForKey:@"from_name"];
    nameLable.text=nameStr;
    nameLable.font = [UIFont systemFontOfSize:12];
    nameLable.frame = CGRectMake(65, 10, 200, 15);
    
    NSString* timeStr = [[_arr objectAtIndex:_index-1] objectForKey:@"add_time"];
    timeLable.text=timeStr;
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.frame = CGRectMake(240, 15, 120, 20);
    
    NSString* contentStr = [[_arr objectAtIndex:_index-1]  objectForKey:@"content"];
    contentLable.text=contentStr;
    contentLable.font = [UIFont systemFontOfSize:12];
    contentLable.numberOfLines = 0;
    
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(200,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [contentStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    contentLable.frame = CGRectMake(65, 35, 200, labelsize.height);
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

