//
//  ShareMessageFirstCell.m
//  ThinkSharer
//
//  Created by 张德凯 on 2017/6/1.
//  Copyright © 2017年 张德凯. All rights reserved.
//

#import "ShareMessageFirstCell.h"

@interface ShareMessageFirstCell ()<UITextViewDelegate>

@end

@implementation ShareMessageFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 0, ScreenWidth - 30, 30)];
        [self.contentView addSubview:_textView];
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.delegate = self;
        
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth - 60, 15, 25, 15)];
        [_textView addSubview:_numLabel];
        _numLabel.text = @"100";
        
//
//        numLabel = UILabel(frame: CGRect(x: ScreenWidth - 40, y: 15, width: 25, height: 15))
//        textView.addSubview(numLabel)
//        numLabel.text = "100"
//        numLabel.font = UIFont.systemFont(ofSize: 14)
//        numLabel.textColor = UIColor.generalTitleFontGray()
        

    }
    
    return self;
}


-(void)textViewDidChange:(UITextView *)textView{
    //获取文本中字体的size
    CGSize size = [TSPublicTool sizeWithString:textView.text font:[UIFont systemFontOfSize:15] width:textView.width];
    NSLog(@"height = %f",size.height);
    //获取一行的高度
    CGSize size1 = [TSPublicTool sizeWithString:@"Hello" font:[UIFont systemFontOfSize:15] width:textView.width];
    NSInteger i = size.height/size1.height;
    if (i==1) {
        //设置全局的变量存储数字如果换行就改变这个全局变量
        self.number = i;
    }
    if (self.number!=i) {
        self.number = i;
        NSLog(@"self num = %ld",self.number);
        textView.height = size.height;
      
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
