//
//  dresserCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-3.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserCell.h"
#import "UIImageView+WebCache.h"
#import "dresserViewController.h"
@implementation dresserCell
@synthesize fatherController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        headImage = [[UIImageView alloc] init];
        headImage.layer.cornerRadius = 5;//设置那个圆角的有多圆
        headImage.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        headImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        headImage.layer.masksToBounds = YES;//设为NO去试试
        
        nameLable = [[UILabel alloc] init];
        nameLable.font=[UIFont systemFontOfSize:12];
        [nameLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        
        assessLable = [[UILabel alloc] init];
        assessLable.font=[UIFont systemFontOfSize:12];
        [assessLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        assessNumLable = [[UILabel alloc] init];
        assessNumLable.font=[UIFont systemFontOfSize:12];
        [assessNumLable setTextColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        
        cityLable = [[UILabel alloc] init];
        cityLable.font=[UIFont systemFontOfSize:12];
        [cityLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        
        
        timeLable = [[UILabel alloc] init];
        timeLable.font=[UIFont systemFontOfSize:12];
        [timeLable setTextColor:[UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0]];
        
        priceLable = [[UILabel alloc] init];
        priceLable.font=[UIFont systemFontOfSize:12];
        priceLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        priceLable.textAlignment =NSTextAlignmentRight;
        
        
        distanceLable = [[UILabel alloc] init];
        distanceLable.font=[UIFont systemFontOfSize:12];
        distanceLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        distanceLable.textAlignment =NSTextAlignmentRight;
        
        addressLable = [[UILabel alloc] init];
        addressLable.font=[UIFont systemFontOfSize:12];
        
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cellButton.layer.cornerRadius = 10;//设置那个圆角的有多圆
        cellButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        cellButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        cellButton.layer.masksToBounds = YES;//设为NO去试试
        [cellButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       
        
        fouceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fouceButton.backgroundColor = [UIColor blackColor];
        fouceButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [fouceButton setTitle:@"预约" forState:UIControlStateNormal];
        [fouceButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
        fouceButton.layer.cornerRadius = 3;//设置那个圆角的有多圆
        fouceButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        fouceButton.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        fouceButton.layer.masksToBounds = YES;//设为NO去试试
        fouceButton.enabled=NO;
        
        fouceButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
        fouceButton1.backgroundColor = [UIColor clearColor];
        [fouceButton1 addTarget:self action:@selector(fouceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        workScroll=[[UIScrollView alloc] init];
        workScroll.delegate=self;
        workScroll.backgroundColor = [UIColor colorWithRed:235.0/256.0 green:235.0/256.0 blue:235.0/256.0 alpha:1.0];
        
        workScroll.layer.cornerRadius = 3;//设置那个圆角的有多圆
        workScroll.layer.borderWidth =0;//设置边框的宽度，当然可以不要
        workScroll.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        workScroll.layer.masksToBounds = YES;//设为NO去试试
        
        
        [self addSubview:headImage];
        [self addSubview:nameLable];
        [self addSubview:assessLable];
        [self addSubview:assessNumLable];
        [self addSubview:cityLable];
        [self addSubview:timeLable];
        [self addSubview:addressLable];
        [self addSubview:priceLable];
        [self addSubview:distanceLable];

        [cellButton addSubview:fouceButton];
        [cellButton addSubview:fouceButton1];

        [cellButton addSubview:workScroll];
        [self addSubview:cellButton];
        
        // Initialization code
    }
    return self;
}

-(void)setCell:(NSMutableArray *)arr andIndex:(NSInteger)index andSign:(NSString * )_sign
{
    
    NSString * headStr= [[arr objectAtIndex:index] objectForKey:@"head_photo"];
    NSString * nameStr = [[arr objectAtIndex:index] objectForKey:@"username"];
    NSString * assessStr = [[arr objectAtIndex:index] objectForKey:@"assess_num"];
    NSString * timeStr = [[arr objectAtIndex:index] objectForKey:@"store_name"];
    
    NSString * addressStr = [[arr objectAtIndex:index] objectForKey:@"store_address"];
    
    NSString * distanceStr = [[arr objectAtIndex:index] objectForKey:@"distance"];
    NSString * priceStr = [[arr objectAtIndex:index] objectForKey:@"price_info"];

//    NSString * concernsStr = [[arr objectAtIndex:index] objectForKey:@"isconcerns"];
    NSString * cityStr = [[arr objectAtIndex:index] objectForKey:@"works_num"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    nameLable.text=nameStr;
    assessLable.text =[NSString stringWithFormat:@"用户评价（    ）"];
    assessNumLable.text =assessStr;

    cityLable.text =[NSString stringWithFormat:@"共有%@张作品",cityStr];
    timeLable.text = timeStr;
    addressLable.text = addressStr;
    distanceLable.text = distanceStr;
   
    NSArray *array = [priceStr componentsSeparatedByString:@"_"];
    
        if ([_sign isEqualToString:@"all"])
        {
            priceLable.text = [NSString stringWithFormat:@"￥%@/%@折",[array objectAtIndex:0],[array objectAtIndex:4]];
        }
        else if([_sign isEqualToString:@"sameCity"])
        {
             priceLable.text = [NSString stringWithFormat:@"￥%@/%@折",[array objectAtIndex:1],[array objectAtIndex:5]];
        }
        else if([_sign isEqualToString:@"introduce"])
        {
             priceLable.text = [NSString stringWithFormat:@"￥%@/%@折",[array objectAtIndex:2],[array objectAtIndex:6]];
        }
       else if([_sign isEqualToString:@"fouce"])
       {
             priceLable.text = [NSString stringWithFormat:@"￥%@/%@折",[array objectAtIndex:3],[array objectAtIndex:7]];
       }
    
//    addressLable.lineBreakMode = UILineBreakModeWordWrap;
    addressLable.numberOfLines = 0;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 15, 200, 15);
    assessLable.frame = CGRectMake(80, 35, 200, 15);
    assessNumLable.frame = CGRectMake(143, 35, 30, 15);

//    cityLable.frame = CGRectMake(80, 35, 200, 15);
    timeLable.frame = CGRectMake(80, 55, 200, 15);
    
    cellButton.tag=index;
    
    priceLable.frame = CGRectMake(210, 5,100, 25);

    fouceButton.frame = CGRectMake(260, 30, 50, 25);
    fouceButton1.frame = CGRectMake(250, 0, 70, 80);
    distanceLable.frame = CGRectMake(210, 55,100, 25);
//    if ([concernsStr isEqualToString:@"0"]) {
//        [fouceButton setTitle:@"+ 关注" forState:UIControlStateNormal];
//    }
//    else
//    {
//    [fouceButton setTitle:@"取消关注" forState:UIControlStateNormal];
//    }
    
    fouceButton1.tag =index;
    
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(260,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [addressStr sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    
    if ([addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"works_list"] isKindOfClass:[NSString class]])
    {
        addressLable.frame = CGRectMake(10, 75, 0, 0);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height,0,0);
    }
    else if (![addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"works_list"] isKindOfClass:[NSString class]])
    {
        addressLable.frame = CGRectMake(10, 75, labelsize.width, labelsize.height);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80+labelsize.height);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height,0,0);
    }
    else if ([addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"works_list"] isKindOfClass:[NSArray class]])
    {
        addressLable.frame = CGRectMake(10, 75, 0, 0);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 60+120);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height+5,320,100);
    }
    else
    {
        addressLable.frame = CGRectMake(10, 75, labelsize.width, labelsize.height);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 60+labelsize.height+120);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height+5,320,100);
    }

   
    NSMutableArray * workArr;
    if ([[[arr objectAtIndex:index] objectForKey:@"works_list"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[[arr objectAtIndex:index] objectForKey:@"works_list"] isKindOfClass:[NSArray class]])
    {
        workArr = [[arr objectAtIndex:index] objectForKey:@"works_list"];
    }
    
    for (UIView* _sub in workScroll.subviews)
    {
        //        if ([_sub isKindOfClass:[AllAroundPullView class]]) {
        //            continue;
        //        }
        [_sub removeFromSuperview];
    }
    
    NSLog(@"workScroll.frame:%@",NSStringFromCGRect(workScroll.frame));
    
    
    if (workArr.count>0)
    {
        [workScroll setContentSize:CGSizeMake(workArr.count*(60+5), 80)];
        if (workScroll.contentSize.width<workScroll.frame.size.width)
        {
            [workScroll setContentSize:CGSizeMake(workScroll.frame.size.width+1, workScroll.frame.size.height)];
        }
        CGRect rect=CGRectZero;
        for (int i=0; i<workArr.count; i++)
        {
            rect=CGRectMake(60*i+5*(i+1), 10, 60, 80);
            UIImageView * workImage = [[UIImageView alloc] initWithFrame:rect];
            
            workImage.layer.cornerRadius = 3;//设置那个圆角的有多圆
            workImage.layer.borderWidth =0;//设置边框的宽度，当然可以不要
            workImage.layer.borderColor = [[UIColor colorWithRed:154.0/256.0 green:154.0/256.0 blue:154.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
            workImage.layer.masksToBounds = YES;//设为NO去试试
            
            [workImage setImageWithURL:[[workArr objectAtIndex:i] objectForKey:@"work_image"]];
            UIButton *newvideobutton=[UIButton buttonWithType:UIButtonTypeCustom];
            newvideobutton.backgroundColor=[UIColor clearColor];
            newvideobutton.tag=index;
            [newvideobutton addTarget:self  action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
            [newvideobutton setFrame:rect];
            [workScroll addSubview:workImage];
            [workScroll addSubview:newvideobutton];
        }
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
-(void)selectImage:(UIButton*)_btn
{
    [fatherController selectImage:_btn.tag];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
