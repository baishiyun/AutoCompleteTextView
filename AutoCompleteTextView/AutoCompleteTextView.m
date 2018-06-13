//
//  AutoCompleteTextView.m
//  AutoCompleteTextViewDemo
//
//  Created by 白仕云 on 2018/6/13.
//  Copyright © 2018年 BSY.com. All rights reserved.
//

#import "AutoCompleteTextView.h"
#import "AutoCompleteShowList.h"



//  #################   文本输入框  ##########################


@interface AutoCompleteTextView()<UITextFieldDelegate>
/**
 显示的list
 */
@property (nonatomic ,strong)AutoCompleteShowList *completeShowList;
@property (nonatomic ,strong)UIView *superView;
@end

@implementation AutoCompleteTextView

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self = [super initWithFrame:frame];
    if (self) {

        self.delegate = self;
        self.superView = superView;
        [self searchTextFieldAttribute];
        [self addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];

        __weak typeof(self)selfWeak  =self;
        [self.completeShowList setBSYAutoCompleteShowTextBlock:^(NSIndexPath *indexPath, AutoCompleteShowListCell *cell, id cellObj) {
            if (selfWeak.BSYAutoCompleteShowChange) {
                selfWeak.BSYAutoCompleteShowChange(indexPath, cell, cellObj);
            }
        }];
        [self.completeShowList setBSYDidSelectRowAtIndexPathBlock:^(NSIndexPath *indexPath, AutoCompleteShowListCell *cell, id cellObj) {
            if (selfWeak.didSelectRowAtIndexPathChange) {
                selfWeak.didSelectRowAtIndexPathChange(indexPath, cell, cellObj);
            }
            selfWeak.completeShowList.hidden = true;
            [selfWeak resignFirstResponder];
        }];
    }
    return self;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    for (AutoCompleteShowList *list in self.superView.subviews) {
        if (![list isKindOfClass:[AutoCompleteShowList class]]) {
            [self.superView addSubview:self.completeShowList];
        }
    }
    if ([textField.text isEqualToString:@""]) {
        self.completeShowList.hidden = true;
    }else{
        self.completeShowList.hidden = false;
        [self textField1TextChange:textField];
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.completeShowList.hidden = true;
    [self resignFirstResponder];

}

-(void)layoutSubviews
{
    [super layoutSubviews];

    self.ShowListHight =(self.ShowListHight==0.00)?200.00:self.ShowListHight;
    self.completeShowList.frame = CGRectMake(self.frame.origin.x,CGRectGetMaxY(self.frame)+1, self.frame.size.width,self.ShowListHight);
}

/**
 监听输入框边框

 @param textChange 变化后的文本
 */
-(void)textField1TextChange:(UITextField *)textChange
{
    if ([textChange.text isEqualToString:@""]) {
        self.completeShowList.hidden = true;
    }else{
        self.completeShowList.hidden = false;
        if (self.AutoCompleteTextViewTextFieldTextChange) {
            self.AutoCompleteTextViewTextFieldTextChange(textChange.text);
        }
    }
}


-(void)setShowListHight:(CGFloat)ShowListHight
{
    _ShowListHight = ShowListHight;
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.completeShowList.dataArray = dataArray;
    });
}

-(AutoCompleteShowList *)completeShowList
{
    if (!_completeShowList) {
        _completeShowList = [[AutoCompleteShowList alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _completeShowList.layer.borderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:0.6].CGColor;
        _completeShowList.layer.borderWidth = 1;
        _completeShowList.layer.cornerRadius = 5;
        _completeShowList.layer.masksToBounds = YES;
    }
    return _completeShowList;
}

-(void )searchTextFieldAttribute
{
    self.textColor = [UIColor blackColor];
    self.font = [UIFont systemFontOfSize:13];
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 30)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.borderStyle = UITextBorderStyleRoundedRect;
}

@end
