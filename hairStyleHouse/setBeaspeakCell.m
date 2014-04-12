//
//  setBeaspeakCell.m
//  hairStyleHouse
//
//  Created by jeason on 14-4-10.
//  Copyright (c) 2014年 jeason. All rights reserved.
//

#import "setBeaspeakCell.h"
#import "setBeaspeakViewController.h"
@implementation setBeaspeakCell
@synthesize fatherViewController;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundColor=[UIColor colorWithRed:231.0/256.0 green:231.0/256.0 blue:231.0/256.0 alpha:1.0];
        firstLable = [[UILabel alloc] init];
        firstLable.textAlignment=NSTextAlignmentCenter;
        firstLable.font=[UIFont systemFontOfSize:12.0];
        secondLable = [[UILabel alloc] init];
        secondLable.textAlignment=NSTextAlignmentCenter;
        secondLable.font=[UIFont systemFontOfSize:12.0];
        thirdLable = [[UILabel alloc] init];
        thirdLable.textAlignment=NSTextAlignmentCenter;
        thirdLable.font=[UIFont systemFontOfSize:12.0];
        forthLable = [[UILabel alloc] init];
        forthLable.textAlignment=NSTextAlignmentCenter;
        forthLable.font=[UIFont systemFontOfSize:12.0];
        
        firstField = [[UITextField alloc] init];
        firstField.font=[UIFont systemFontOfSize:12.0];
        secondField = [[UITextField alloc] init];
        secondField.font=[UIFont systemFontOfSize:12.0];
        thirdField = [[UITextField alloc] init];
        thirdField.font=[UIFont systemFontOfSize:12.0];
        forthField = [[UITextField alloc] init];
        forthField.font=[UIFont systemFontOfSize:12.0];
        
        secondField.keyboardType=UIKeyboardTypeDecimalPad;
        thirdField.keyboardType=UIKeyboardTypeDecimalPad;
        forthField.keyboardType=UIKeyboardTypeDecimalPad;
        
        firstField.placeholder=@"请输入";
        secondField.placeholder=@"请输入";
        thirdField.placeholder=@"请输入";
        forthField.placeholder=@"请输入";
        
        deleButton = [[UIButton alloc] init];
        deleteButton = [[UIButton alloc] init];
        cellButton = [[UIButton alloc] init];
        sendButton= [[UIButton alloc] init];
        signLable = [[UILabel alloc] init];
        
        
        
        [self addSubview:firstLable];
        [self addSubview:secondLable];
        [self addSubview:thirdLable];
        [self addSubview:forthLable];
        
        
//         [self addSubview:cellButton];
        [self addSubview:firstField];
        [self addSubview:secondField];
        [self addSubview:thirdField];
        [self addSubview:forthField];
       [self addSubview:deleteButton];
        [self addSubview:deleButton];
        [self addSubview:sendButton];
        [self addSubview:signLable];

        // Initialization code
    }
    return self;
}

-(void)setFirstCell
{
    firstLable.text = @"服务项目";
    secondLable.text=@"平时价格";
    thirdLable.text=@"折扣";
    forthLable.text=@"优惠价格";
    firstLable.frame=CGRectMake(5, 10, 70, 40);secondLable.frame=CGRectMake(85, 10, 70, 40);thirdLable.frame=CGRectMake(165, 10, 70, 40);forthLable.frame=CGRectMake(245, 10, 70, 40);
    firstField.frame=CGRectMake(0, 0, 0, 0);
    secondField.frame=CGRectMake(0, 0, 0, 0);
    thirdField.frame=CGRectMake(0, 0, 0, 0);
    forthField.frame=CGRectMake(0, 0, 0, 0);
    deleButton.frame=CGRectMake(0, 0, 0, 0);
    deleteButton.frame=CGRectMake(0, 0, 0, 0);
    cellButton.frame = CGRectMake(0, 0, 0, 0);
    signLable.frame= CGRectMake(0, 0, 0, 0);
     sendButton.frame= CGRectMake(0, 0, 0, 0);
}
-(void)setOtherCell:(NSMutableArray *)arr andIndex:(NSInteger)index
{
    firstLable.frame=CGRectMake(0, 0, 0, 0);secondLable.frame=CGRectMake(0, 0, 0, 0);thirdLable.frame=CGRectMake(0, 0, 0, 0);forthLable.frame=CGRectMake(0, 0, 0, 0);
    firstField.frame=CGRectMake(5, 10, 70, 40);secondField.frame=CGRectMake(85, 10, 70, 40);thirdField.frame=CGRectMake(165, 10, 70, 40);forthField.frame=CGRectMake(245, 10, 70, 40);
    deleteButton.frame=CGRectMake(65, 0, 20, 20);
    [deleteButton setImage:[UIImage imageNamed:@"image_delete.png"] forState:UIControlStateNormal];
    deleteButton.tag=index;
    [deleteButton addTarget:self action:@selector(deleteView:) forControlEvents:UIControlEventTouchUpInside];
    deleButton.frame=CGRectMake(0, 0, 0, 0);
    cellButton.frame = CGRectMake(0, 0, 320, 60);
    signLable.frame= CGRectMake(0, 0, 0, 0);
    sendButton.frame= CGRectMake(0, 0, 0, 0);


    firstField.text = [[arr objectAtIndex:index] objectForKey:@"goods_name"];
    secondField.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:index] objectForKey:@"price"]];
    thirdField.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:index] objectForKey:@"rebate"]];
    forthField.text=[NSString stringWithFormat:@"%@",[[arr objectAtIndex:index] objectForKey:@"reserve_price"]];
    
    firstField.delegate = fatherViewController;
    [firstField addTarget:fatherViewController action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    firstField.tag=index*4;
    firstField.returnKeyType = UIReturnKeyDone;
    firstField.borderStyle = UITextBorderStyleRoundedRect;
    firstField.backgroundColor=[UIColor whiteColor];
    firstField.layer.cornerRadius = 0;//设置那个圆角的有多圆
    firstField.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    firstField.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    firstField.layer.masksToBounds = YES;//设为NO去试试
    
    secondField.delegate = fatherViewController;
    [secondField addTarget:fatherViewController action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    secondField.returnKeyType = UIReturnKeyDone;
    secondField.borderStyle = UITextBorderStyleRoundedRect;
    secondField.backgroundColor=[UIColor whiteColor];
secondField.tag=index*4+1;
    secondField.layer.cornerRadius = 0;//设置那个圆角的有多圆
    secondField.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    secondField.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    secondField.layer.masksToBounds = YES;//设为NO去试试
    
    thirdField.delegate = fatherViewController;
    [thirdField addTarget:fatherViewController action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    thirdField.returnKeyType = UIReturnKeyDone;
    thirdField.borderStyle = UITextBorderStyleRoundedRect;
    thirdField.backgroundColor=[UIColor whiteColor];
    thirdField.tag=index*4+2;

    thirdField.layer.cornerRadius = 0;//设置那个圆角的有多圆
    thirdField.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    thirdField.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    thirdField.layer.masksToBounds = YES;//设为NO去试试
    
    forthField.delegate = fatherViewController;
    [forthField addTarget:fatherViewController action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
    forthField.returnKeyType = UIReturnKeyDone;
    forthField.borderStyle = UITextBorderStyleRoundedRect;
    forthField.backgroundColor=[UIColor whiteColor];
    forthField.tag=index*4+3;

    forthField.layer.cornerRadius = 0;//设置那个圆角的有多圆
    forthField.layer.borderWidth =0;//设置边框的宽度，当然可以不要
    forthField.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    forthField.layer.masksToBounds = YES;//设为NO去试试

}
-(void)setLastCell
{
    
    firstLable.frame=CGRectMake(0, 0, 0, 0);secondLable.frame=CGRectMake(0, 0, 0, 0);thirdLable.frame=CGRectMake(0, 0, 0, 0);forthLable.frame=CGRectMake(0, 0, 0, 0);
    firstField.frame=CGRectMake(0, 0, 0, 0);
    secondField.frame=CGRectMake(0, 0, 0, 0);
    thirdField.frame=CGRectMake(0, 0, 0, 0);
    forthField.frame=CGRectMake(0, 0, 0, 0);
    deleteButton.frame=CGRectMake(0, 0, 0, 0);
    cellButton.frame = CGRectMake(0, 0, 320, 60);
    deleButton.frame=CGRectMake(5, 10, 80, 40);
    signLable.frame= CGRectMake(100, 20, 220, 30);
    sendButton.frame= CGRectMake(0, 0, 0, 0);

    signLable.text=@"添加擅长的服务项目";
    signLable.textColor = [UIColor lightGrayColor];
     signLable.font=[UIFont systemFontOfSize:12.0];
    
    [deleButton setTitle:@"添加服务项目" forState:UIControlStateNormal];
    [deleButton setBackgroundColor:[UIColor whiteColor]];
    deleButton.titleLabel.font=[UIFont systemFontOfSize:12.0];
    [deleButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    deleButton.layer.cornerRadius = 0;//设置那个圆角的有多圆
    deleButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    deleButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    deleButton.layer.masksToBounds = YES;//设为NO去试试
    [deleButton addTarget:self action:@selector(addNew) forControlEvents:UIControlEventTouchUpInside];

}
-(void)setLastCell1
{

    firstLable.frame=CGRectMake(0, 0, 0, 0);secondLable.frame=CGRectMake(0, 0, 0, 0);thirdLable.frame=CGRectMake(0, 0, 0, 0);forthLable.frame=CGRectMake(0, 0, 0, 0);
    firstField.frame=CGRectMake(0, 0, 0, 0);
    secondField.frame=CGRectMake(0, 0, 0, 0);
    thirdField.frame=CGRectMake(0, 0, 0, 0);
    forthField.frame=CGRectMake(0, 0, 0, 0);
    deleteButton.frame=CGRectMake(0, 0, 0, 0);
    cellButton.frame = CGRectMake(0, 0, 320, 60);
    deleButton.frame=CGRectMake(0, 0, 0, 0);
    signLable.frame= CGRectMake(0, 0, 0, 0);
    sendButton.frame =CGRectMake(40, 10, 240, 40);
//    signLable.text=@"添加擅长的服务项目";
//    signLable.textColor = [UIColor lightGrayColor];
//    signLable.font=[UIFont systemFontOfSize:12.0];
    
    [sendButton setTitle:@"确定添加" forState:UIControlStateNormal];
    [sendButton setBackgroundColor:[UIColor colorWithRed:245.0/256.0 green:35.0/256.0 blue:96.0/256.0 alpha:1.0]];
    sendButton.titleLabel.font=[UIFont systemFontOfSize:16.0];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sendButton.layer.cornerRadius = 0;//设置那个圆角的有多圆
    sendButton.layer.borderWidth =1;//设置边框的宽度，当然可以不要
    sendButton.layer.borderColor = [[UIColor colorWithRed:212.0/256.0 green:212.0/256.0 blue:212.0/256.0 alpha:1.0] CGColor];//设置边框的颜色
    sendButton.layer.masksToBounds = YES;//设为NO去试试
    [sendButton addTarget:self action:@selector(sendButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)addNew
{
   
    [fatherViewController addNew];
   
}
-(void)deleteView:(UIButton*)btn
{
   
    
    [firstField resignFirstResponder];
    [secondField resignFirstResponder];
    [thirdField resignFirstResponder];
    [forthField resignFirstResponder];
 [fatherViewController deleteView:btn.tag];
    
}
-(void)sendButtonClick
{
//    if (array.count==0) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"添加失败" message:@"尚未添加任何项目" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
//        [alert show];
    
    [firstField resignFirstResponder];
    [secondField resignFirstResponder];
    [thirdField resignFirstResponder];
    [forthField resignFirstResponder];
    
    [fatherViewController lookAllcell];
        
        
//    }

}
@end
