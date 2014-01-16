//
//  beaspeakCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "beaspeakCell.h"
#import "UIImageView+WebCache.h"
@implementation beaspeakCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstView  =[[UIView alloc] init];
        firstView.backgroundColor =[UIColor clearColor];
        
        secondView  =[[UIView alloc] init];
        secondView.backgroundColor =[UIColor clearColor];
        
        headImage = [[UIImageView alloc] init];
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
        mobileLable = [[UILabel alloc] init];
        mobileLable.font=[UIFont systemFontOfSize:12];
        
        typeLable = [[UILabel alloc] init];
        typeLable.font=[UIFont systemFontOfSize:12];
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        statusLable = [[UILabel alloc] init];
        statusLable.font=[UIFont systemFontOfSize:12];
        
        [self addSubview:firstView];
        
        [firstView addSubview:headImage];
        [firstView addSubview:nameLable];
        [firstView addSubview:typeLable];
        [firstView addSubview:mobileLable];
        [firstView addSubview:timeLable];
        [firstView addSubview:statusLable];
        
        
        nameLable1 = [[UILabel alloc] init];
        nameLable1.font=[UIFont systemFontOfSize:12];
        
        
        mobileLable1 = [[UILabel alloc] init];
        mobileLable1.font=[UIFont systemFontOfSize:12];
        
        typeLable1 = [[UILabel alloc] init];
        typeLable1.font=[UIFont systemFontOfSize:12];
        
        timeLable1 = [[UILabel alloc] init];
        timeLable1.font=[UIFont systemFontOfSize:12];
        
        priceLable= [[UILabel alloc] init];
        priceLable.font=[UIFont systemFontOfSize:12];
        
        picImage = [[UIImageView alloc] init];
        
        [self addSubview:secondView];
        
        
        [secondView addSubview:nameLable1];
        [secondView addSubview:typeLable1];
        [secondView addSubview:mobileLable1];
        [secondView addSubview:timeLable1];
        [secondView addSubview:priceLable];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"my_name"];
    NSString * cityStr = [dic objectForKey:@"my_tel"];
    NSString * typeStr = [dic objectForKey:@"reserve_type"];
    NSString * timeStr = [dic objectForKey:@"reserve_time"];
     NSString * hourStr = [dic objectForKey:@"reserve_hour"];
    NSString * statusStr = [dic objectForKey:@"status"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    mobileLable.text =[NSString stringWithFormat:@"手机号码:%@",cityStr];
    typeLable.text = [NSString stringWithFormat:@"预约类型:%@",typeStr];
    timeLable.text =[NSString stringWithFormat:@"%@%@",timeStr,hourStr];
    if ([statusStr isEqualToString:@"0"]) {
        statusLable.text = @"用户取消";

    }
    else if ([statusStr isEqualToString:@"1"]) {
        statusLable.text = @"进行中";
        
    }
    else if ([statusStr isEqualToString:@"2"]) {
        statusLable.text = @"已完成，未评价";
        
    }
    else if ([statusStr isEqualToString:@"3"]) {
        statusLable.text = @"发型师取消";
        
    }
    else if ([statusStr isEqualToString:@"4"]) {
        statusLable.text = @"已完成，已评价";
        
    }
    
    firstView.frame = self.frame;
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    mobileLable.frame = CGRectMake(80, 35, 200, 15);
    typeLable.frame = CGRectMake(80, 55, 200, 15);
    timeLable.frame = CGRectMake(10, 75, 200, 20);
    statusLable.textAlignment =NSTextAlignmentCenter;
    statusLable.frame = CGRectMake(220,75, 100, 20);
    firstView.hidden=NO;
    secondView.hidden=YES;
}

-(void)setCell1:(NSDictionary *)dic andIndex:(NSInteger)index//当前预约
{
    NSString * nameStr = [dic objectForKey:@"to_username"];
    NSString * cityStr = [dic objectForKey:@"telephone"];
    NSString * orderStr = [dic objectForKey:@"order_type"];
    NSString * typeStr = [dic objectForKey:@"reserve_type"];
    NSString * imageStr= [dic objectForKey:@"image_path"];
    NSString * timeStr = [dic objectForKey:@"reserve_time"];
    NSString * hourStr = [dic objectForKey:@"reserve_hour"];
    NSString * priceStr = [dic objectForKey:@"reserve_price"];
    
    nameLable1.text=[NSString stringWithFormat:@"发型师名称:%@",nameStr];
    mobileLable1.text =[NSString stringWithFormat:@"手机号码:%@",cityStr];
    
    
    if ([orderStr isEqualToString:@"1"]) {
        typeLable1.text = [NSString stringWithFormat:@"预约类型:%@",typeStr];

    }
    else
    {
        typeLable1.text = [NSString stringWithFormat:@"预约如下图片"];
        [picImage setImageWithURL:[NSURL URLWithString:imageStr]];
        picImage.frame = CGRectMake(100, 100, 125, 160);

    }
    timeLable1.text =[NSString stringWithFormat:@"预约时间%@%@",timeStr,hourStr];
    priceLable.text =[NSString stringWithFormat:@"%@元",priceStr];
    
    nameLable1.frame = CGRectMake(10, 15, 200, 15);
    mobileLable1.frame = CGRectMake(10, 45, 200, 15);
    
    typeLable1.frame = CGRectMake(10, 105, 200, 15);
    timeLable1.frame = CGRectMake(10, 75, 200, 20);
    priceLable.textAlignment =NSTextAlignmentCenter;
    priceLable.frame = CGRectMake(220,105, 100, 20);
    secondView.hidden=NO;
    secondView.frame = self.frame;
    firstView.hidden=YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
