//
//  sameCityCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-10.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "sameCityCell.h"

#import "UIImageView+WebCache.h"
#import "sameCityViewController.h"
@implementation sameCityCell

@synthesize fatherController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headImage.layer.masksToBounds = YES;//设为NO去试试

        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        
        
        cityLable = [[UILabel alloc] init];
        cityLable.font=[UIFont systemFontOfSize:12];
        
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        
        
        addressLable = [[UILabel alloc] init];
        addressLable.font=[UIFont systemFontOfSize:12];
        
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cellButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        fouceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fouceButton.backgroundColor = [UIColor blackColor];
        fouceButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [fouceButton addTarget:self action:@selector(fouceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:cityLable];
        [self addSubview:timeLable];
        [self addSubview:addressLable];
//        [cellButton addSubview:fouceButton];
        [self addSubview:cellButton];
        
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    NSString * headStr= [dic objectForKey:@"head_photo"];
    NSString * nameStr = [dic objectForKey:@"username"];
    
    NSString * timeStr = [dic objectForKey:@"signature"];
    NSString * addressStr = [dic objectForKey:@"store_address"];
    NSString * concernsStr = [dic objectForKey:@"isconcerns"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    
    if ([[dic objectForKey:@"type"] isEqualToString:@"1"])
    {
        cityLable.text =[NSString stringWithFormat:@"TA的问题：%@",[dic objectForKey:@"problem_num"]];
        ;
        
    }
    else
    {
        cityLable.text =[NSString stringWithFormat:@"%@",[dic objectForKey:@"store_name"]];
        
    }
    timeLable.text = timeStr;
    addressLable.text = addressStr;
    //    addressLable.lineBreakMode = UILineBreakModeWordWrap;
    addressLable.numberOfLines = 0;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 20, 200, 15);
    cityLable.frame = CGRectMake(80, 45, 200, 15);
    timeLable.frame = CGRectMake(80, 55, 200, 15);
    
    cellButton.tag=index;
    
    
    fouceButton.frame = CGRectMake(260, 25, 50, 25);
    
    if ([concernsStr isEqualToString:@"0"]) {
        [fouceButton setTitle:@"+ 关注" forState:UIControlStateNormal];
    }
    else
    {
        [fouceButton setTitle:@"取消关注" forState:UIControlStateNormal];
    }
    
    fouceButton.tag =index;
    
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(260,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    if ([addressStr isEqualToString:@""]) {
        addressLable.frame = CGRectMake(10, 75, labelsize.width, labelsize.height);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80);
    }
    else
    {
        addressLable.frame = CGRectMake(10, 75, labelsize.width, labelsize.height);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80+labelsize.height);
    }
    
    
    
}

-(void)cellButtonClick:(UIButton*)_btn
{
    [fatherController selectCell:_btn.tag];
}

-(void)fouceButtonClick:(UIButton*)_btn
{
    [fatherController didFouce:_btn.tag];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
