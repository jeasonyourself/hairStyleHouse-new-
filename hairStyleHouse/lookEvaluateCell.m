//
//  lookEvaluateCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "lookEvaluateCell.h"
#import "UIImageView+WebCache.h"
@implementation lookEvaluateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        backView = [[UIView alloc] init];
        backView.layer.cornerRadius = 5;//设置那个圆角的有多圆
        backView.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        backView.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        backView.layer.masksToBounds = YES;//设为NO去试试
        
        headImage = [[UIImageView alloc] init];
        headImage.frame = CGRectMake(10, 10, 70, 70);
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headImage.layer.masksToBounds = YES;//设为NO去试试
        
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        nameLable.frame = CGRectMake(100, 15, 100, 15);
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        timeLable.frame = CGRectMake(200, 15, 120, 15);
        
        serviceLable = [[UILabel alloc] init];
        serviceLable.text =@"服务态度：";
        serviceLable.font=[UIFont systemFontOfSize:12];
        serviceLable.frame = CGRectMake(100, 35, 60, 15);
        
        serviceImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 35, 120, 15)];
        
        priceLable = [[UILabel alloc] init];
        priceLable.text =@"评价：";
        priceLable.font=[UIFont systemFontOfSize:12];
        priceLable.frame = CGRectMake(100, 40, 200, 15);
//        priceImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 55, 120, 15)];

        
        milieuLable = [[UILabel alloc] init];
        milieuLable.text =@"评语：";
        milieuLable.font=[UIFont systemFontOfSize:12];
        milieuLable.frame = CGRectMake(100, 65, 60, 15);
//        milieuImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 75, 120, 15)];

        
        reaLable = [[UILabel alloc] init];
        reaLable.font=[UIFont systemFontOfSize:12];
        reaLable.frame = CGRectMake(220, 75, 60, 15);
        
        contentLable = [[UILabel alloc] init];
        contentLable.font=[UIFont systemFontOfSize:12];
       
        [self addSubview:backView];
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:timeLable];
//        [self addSubview:serviceLable];
//        [self addSubview:serviceImage];
        [self addSubview:priceLable];
//        [self addSubview:priceImage];
        [self addSubview:milieuLable];
        [self addSubview:contentLable];
//        [self addSubview:milieuImage];
//        [self addSubview:reaLable];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"username"];
    NSString * timeStr = [dic objectForKey:@"add_time"];
    NSString * serviceStr = [dic objectForKey:@"score"];
//    NSString * priceStr = [dic objectForKey:@"price"];
//    NSString * milieuStr = [dic objectForKey:@"milieu"];
//    NSString * infoStr = [dic objectForKey:@"info"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    timeLable.text =timeStr;
//    if ([serviceStr isEqualToString:@"5"])
//    {
//        [serviceImage setImage:[UIImage imageNamed:@"x5.png"]];
//    }
//    else if ([serviceStr isEqualToString:@"4"])
//    {
//        [serviceImage setImage:[UIImage imageNamed:@"x4.png"]];
//
//    }
     if ([serviceStr isEqualToString:@"3"])
    {
       priceLable.text =@"评价： 差评";

    }
    else if ([serviceStr isEqualToString:@"2"])
    {
priceLable.text =@"评价： 中评";
    }
    else if ([serviceStr isEqualToString:@"1"])
    {
priceLable.text =@"评价： 好评";
    }
    //
//    if ([priceStr isEqualToString:@"5"])
//    {
//        [priceImage setImage:[UIImage imageNamed:@"x5.png"]];
//    }
//    else if ([priceStr isEqualToString:@"4"])
//    {
//        [priceImage setImage:[UIImage imageNamed:@"x4.png"]];
//        
//    }
//    else if ([priceStr isEqualToString:@"3"])
//    {
//        [priceImage setImage:[UIImage imageNamed:@"x3.png"]];
//        
//    }
//    else if ([priceStr isEqualToString:@"2"])
//    {
//        [priceImage setImage:[UIImage imageNamed:@"x2.png"]];
//        
//    }
//    else if ([priceStr isEqualToString:@"1"])
//    {
//        [priceImage setImage:[UIImage imageNamed:@"x1.png"]];
//        
//    }
//    //
//    if ([milieuStr isEqualToString:@"5"])
//    {
//        [milieuImage setImage:[UIImage imageNamed:@"x5.png"]];
//    }
//    else if ([milieuStr isEqualToString:@"4"])
//    {
//        [milieuImage setImage:[UIImage imageNamed:@"x4.png"]];
//        
//    }
//    else if ([milieuStr isEqualToString:@"3"])
//    {
//        [milieuImage setImage:[UIImage imageNamed:@"x3.png"]];
//        
//    }
//    else if ([milieuStr isEqualToString:@"2"])
//    {
//        [milieuImage setImage:[UIImage imageNamed:@"x2.png"]];
//        
//    }
//    else if ([milieuStr isEqualToString:@"1"])
//    {
//        [milieuImage setImage:[UIImage imageNamed:@"x1.png"]];
//        
//    }

    
    NSString *_content =[dic objectForKey:@"info"];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(180,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    //设置自动行数与字符换行
    [contentLable setNumberOfLines:0];
    contentLable.text = _content;
//    contentLable.lineBreakMode = UILineBreakModeWordWrap;
    [contentLable setFrame:CGRectMake(140,65, labelsize.width, labelsize.height)];
    NSLog(@"呵呵%@",NSStringFromCGRect(contentLable.frame));
    
    backView.frame = CGRectMake(2, 5, 316, 70+labelsize.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
