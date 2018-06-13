//
//  AutoCompleteShowList.m
//  AutoCompleteTextViewDemo
//
//  Created by 白仕云 on 2018/6/13.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "AutoCompleteShowList.h"

@interface AutoCompleteShowListCell()
@property (nonatomic ,strong)UIView *bottomLine;
@end
@implementation AutoCompleteShowListCell

/**
 根据不同的cell类型显示不同的cell模版
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = 0;
        [self addSubview:self.showText];
        [self addSubview:self.bottomLine];

    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.showText.frame = CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height);
    self.bottomLine.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
}

-(UILabel *)showText
{
    if (!_showText) {
        _showText = [[UILabel alloc]init];
        _showText.textColor= [UIColor blackColor];
        _showText.textAlignment = NSTextAlignmentLeft;
        _showText.font = [UIFont systemFontOfSize:13];
        _showText.numberOfLines = 2;
        _showText.lineBreakMode = 0;
    }
    return _showText;
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.3];
    }
    return _bottomLine;
}
@end


static NSString *const AutoCompleteShowListCellID = @"AutoCompleteShowListCell";

@interface AutoCompleteShowList()<UITableViewDataSource,UITableViewDelegate>
@end

@implementation AutoCompleteShowList

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];

    if (self) {
        self.separatorStyle = 0;
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [[UIView alloc]init];
        [self registerClass:[AutoCompleteShowListCell class] forCellReuseIdentifier:AutoCompleteShowListCellID];
    }
    return self;
}

-(void)reloadDataWithIndexPath:(NSIndexPath *)indexPath cell:(AutoCompleteShowListCell *)cell obj:(id)obj
{
    if (self.BSYAutoCompleteShowTextBlock) {
        self.BSYAutoCompleteShowTextBlock(indexPath, cell, obj);
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoCompleteShowListCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteShowListCellID];
    [self reloadDataWithIndexPath:indexPath cell:cell obj:self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AutoCompleteShowListCell *cell = (AutoCompleteShowListCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (self.BSYDidSelectRowAtIndexPathBlock) {
        self.BSYDidSelectRowAtIndexPathBlock(indexPath, cell, self.dataArray[indexPath.row]);
    }
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    if (!dataArray) {
        _dataArray = [NSMutableArray array];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}
@end
