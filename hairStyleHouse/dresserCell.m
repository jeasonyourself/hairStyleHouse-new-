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
        headImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
        
        oldPriceLable = [[UILabel alloc] init];
        oldPriceLable.font=[UIFont systemFontOfSize:12];
        oldPriceLable.textColor = [UIColor colorWithRed:146.0/256.0 green:146.0/256.0 blue:146.0/256.0 alpha:1.0];
        oldPriceLable.textAlignment =NSTextAlignmentLeft;
        
        distanceLable = [[UILabel alloc] init];
        distanceLable.font=[UIFont systemFontOfSize:12];
        distanceLable.textColor = [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0];
        distanceLable.textAlignment =NSTextAlignmentRight;
        
        addressLable = [[UILabel alloc] init];
        addressLable.font=[UIFont systemFontOfSize:12];
        
        cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cellButton.layer.cornerRadius = 10;//设置那个圆角的有多圆
        cellButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        cellButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        cellButton.layer.masksToBounds = YES;//设为NO去试试
        [cellButton addTarget:self action:@selector(cellButtonClick:) forControlEvents:UIControlEventTouchUpInside];
       
        
        fouceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fouceButton.backgroundColor = [UIColor blackColor];
        fouceButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [fouceButton setTitle:@"预约" forState:UIControlStateNormal];
        [fouceButton setBackgroundColor:[UIColor clearColor]];
        [fouceButton setTitleColor: [UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] forState:UIControlStateNormal];
        fouceButton.layer.cornerRadius = 3;//设置那个圆角的有多圆
        fouceButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
        fouceButton.layer.borderColor = [[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
        workScroll.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
        workScroll.layer.masksToBounds = YES;//设为NO去试试
        
        
//        [self addSubview:headImage];
        [self addSubview:nameLable];
//        [self addSubview:assessLable];
//        [self addSubview:assessNumLable];
        [self addSubview:cityLable];
        [self addSubview:timeLable];
        [self addSubview:addressLable];
        [self addSubview:oldPriceLable];
        [self addSubview:priceLable];
        
        [self addSubview:distanceLable];

        [cellButton addSubview:fouceButton];
        [cellButton addSubview:fouceButton1];

        [cellButton addSubview:workScroll];
        [self addSubview:cellButton];
        [self addSubview:headImage];
        
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
    NSString * oldpriceStr = [[arr objectAtIndex:index] objectForKey:@"price"];
    NSString * rebateStr = [[arr objectAtIndex:index] objectForKey:@"rebate"];
    NSString * priceStr = [[arr objectAtIndex:index] objectForKey:@"reserve_price"];

//    NSString * concernsStr = [[arr objectAtIndex:index] objectForKey:@"isconcerns"];
    NSString * cityStr = [[arr objectAtIndex:index] objectForKey:@"works_num"];
    
    [headImage setImageWithURL:[NSURL URLWithString:headStr]];
    headImage.tag = index;
    headImage.userInteractionEnabled = YES;
    [headImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)]];
    headImage.clipsToBounds = YES;
    headImage.contentMode = UIViewContentModeScaleAspectFill;
    
    
    nameLable.text=nameStr;
    assessLable.text =[NSString stringWithFormat:@"用户评价（    ）"];
    assessNumLable.text =assessStr;

    cityLable.text =[NSString stringWithFormat:@"共有%@张作品",cityStr];
    timeLable.text = timeStr;
    addressLable.text = addressStr;
    distanceLable.text = distanceStr;
   
    oldPriceLable.text = [NSString stringWithFormat:@"平时：￥%@",oldpriceStr];
    priceLable.text = [NSString stringWithFormat:@"优惠：￥%@/%@折",priceStr,rebateStr];
    //    addressLable.lineBreakMode = UILineBreakModeWordWrap;
    addressLable.numberOfLines = 0;
    
    headImage.frame = CGRectMake(10, 10, 60, 60);
    nameLable.frame = CGRectMake(80, 10, 200, 15);
//    assessLable.frame = CGRectMake(80, 35, 200, 15);
//    assessNumLable.frame = CGRectMake(143, 35, 30, 15);

//    cityLable.frame = CGRectMake(80, 35, 200, 15);
    timeLable.frame = CGRectMake(80, 55, 200, 15);
    
    cellButton.tag=index;
    
    oldPriceLable.frame = CGRectMake(80, 25,100, 25);
    priceLable.frame = CGRectMake(170, 25,140, 25);

    fouceButton.frame = CGRectMake(260, 50, 50, 25);
    fouceButton1.frame = CGRectMake(250, 0, 70, 80);
    distanceLable.frame = CGRectMake(210, 5,100, 25);
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
    
    if ([addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
    {
        addressLable.frame = CGRectMake(10, 75, 0, 0);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height,0,0);
    }
    else if (![addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
    {
        addressLable.frame = CGRectMake(10, 75, labelsize.width, labelsize.height);
        cellButton.frame = CGRectMake(0, 0, self.frame.size.width, 80+labelsize.height);
        workScroll.frame = CGRectMake(0, addressLable.frame.origin.y+addressLable.frame.size.height,0,0);
    }
    else if ([addressStr isEqualToString:@""]&&[[[arr objectAtIndex:index] objectForKey:@"worksInfo"] isKindOfClass:[NSArray class]])
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
    if ([[[arr objectAtIndex:index] objectForKey:@"worksInfo"] isKindOfClass:[NSString class]])
    {
        
    }
    else if ([[[arr objectAtIndex:index] objectForKey:@"worksInfo"] isKindOfClass:[NSArray class]])
    {
        workArr = [[arr objectAtIndex:index] objectForKey:@"worksInfo"];
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
            workImage.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
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
     [fatherController didFouce:_btn.tag];
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
- (void)tapImage:(UITapGestureRecognizer *)tap
{
    [fatherController selectCell:tap.view.tag];
}
@end
