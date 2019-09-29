//
//  managerViewController.m
//  酒店管理
//
//  Created by 杨奇 on 2019/9/19.
//  Copyright © 2019 杨奇. All rights reserved.
//

#import "managerViewController.h"
#import "homeViewCard.h"
#import <BmobSDK/Bmob.h>

#define ZFColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define TEXT_WIDTH ([[UIScreen mainScreen] bounds].size.width) - LABEL_WIDTH - 40
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define ViewHeight 70
#define labelToTop 25
#define labelHeight 20
#define LABEL_WIDTH 120
#define labelToLeft 10

@interface managerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong, readwrite)homeViewCard *homeView;
@property (nonatomic, strong, readwrite)NSMutableArray *nameMutableArray;
@property (nonatomic, strong, readwrite)UIScrollView *scrollView;

@end

@implementation managerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //忽略导航栏的坐标
        self.edgesForExtendedLayout = UIRectEdgeBottom;
        self.view.backgroundColor = [UIColor lightTextColor];
        UIImage *addPic = [UIImage imageNamed:@"增加(3)@2x.png"];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:addPic style:UIBarButtonItemStyleDone target:self action:@selector(addRecord)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.priceTextField.delegate = self;
    //首页卡片获取数据
    [self updateHome];
    //回到首页刷新界面通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIndex:) name:@"updateTransferIndex" object:nil];
}

//MARK:收到通知刷新首页
- (void)updateIndex:(NSNotification *)notification
{
    [self updateHome];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**添加按钮方法*/
- (void)addRecord {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = ZFColor(204, 204, 204);
    [self.navigationController pushViewController:viewController animated:YES];
    //消除返回按钮文字,此方法是没有复杂需求时使用
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:UIButton.new];
    //设置新推出页面标题
    viewController.navigationItem.title = @"添加记录";
    UIImage *successPic = [UIImage imageNamed:@"提交成功(1)@2x.png"];
    //添加记录页面右侧完成按钮
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:successPic style:UIBarButtonItemStyleDone target:self action:@selector(backToForward)];
    //使坐标原点从(0,64)变成(0,0)开始
    viewController.edgesForExtendedLayout = UIRectEdgeBottom;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 960);
    [viewController.view addSubview:_scrollView];
    //两个卡片存在的scrollView
    [_scrollView addSubview:({
        UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH - 20, ViewHeight * 2)];
        view1.backgroundColor = [UIColor whiteColor];
        view1.layer.cornerRadius = 5;
        view1.layer.masksToBounds = YES;
        //添加一条横向的线，使用View实现
        UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight, SCREEN_WIDTH - 20, 1)];
        horizontal.backgroundColor = [UIColor grayColor];
        [view1 addSubview:horizontal];
        
        [view1 addSubview:({
            _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, labelToTop, LABEL_WIDTH, labelHeight)];
            _nameLabel.text = @"姓名:";
            _nameLabel;
        })];
        
        [view1 addSubview:({
            _nameText = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop, TEXT_WIDTH, labelHeight)];
            _nameText.placeholder = @"请输入(最多5个字)";
            _nameText.textAlignment = NSTextAlignmentRight;
            _nameText;
        })];
        
        [view1 addSubview:({
            _IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, labelToTop + ViewHeight, LABEL_WIDTH, labelHeight)];
            _IDLabel.text = @"身份证号码:";
            _IDLabel;
        })];
        
        [view1 addSubview:({
            _IDText = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight, TEXT_WIDTH, labelHeight)];
            _IDText.placeholder = @"请输入";
            _IDText.textAlignment = NSTextAlignmentRight;
            _IDText;
        })];
        view1;
        
    })];
    [_scrollView addSubview:({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + ViewHeight * 2 + 20, SCREEN_WIDTH - 20, ViewHeight * 6)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = YES;
        //添加一条横向的线，使用View实现
        for (int i = 1; i < 7; i++) {
            UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight * i, SCREEN_WIDTH - 20, 1)];
            horizontal.backgroundColor = [UIColor grayColor];
            [view addSubview:horizontal];
        }
        //添加记录页面leftLabel
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 0, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"入住酒店:";
            _leftLabel;
        })];
        
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 1, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"入住房号:";
            _leftLabel;
        })];
        
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 2, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"入住时间:";
            _leftLabel;
        })];
        
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 3, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"入住人数:";
            _leftLabel;
        })];
        
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 4, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"入住天数:";
            _leftLabel;
        })];
        
        [view addSubview:({
            _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelToLeft, labelToTop + ViewHeight * 5, LABEL_WIDTH, labelHeight)];
            _leftLabel.text = @"房间单价:";
            _leftLabel;
        })];
        
        //添加记录页面rightTextField
        [view addSubview:({
            _hotelTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 0, TEXT_WIDTH, labelHeight)];
            _hotelTextField.placeholder = @"请输入(最多15个字)";
            _hotelTextField.textAlignment = NSTextAlignmentRight;
            _hotelTextField;
        })];
        
        [view addSubview:({
            _roomTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 1, TEXT_WIDTH, labelHeight)];
            _roomTextField.placeholder = @"请输入";
            _roomTextField.textAlignment = NSTextAlignmentRight;
            _roomTextField;
        })];
        
        [view addSubview:({
            _timeTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 2, TEXT_WIDTH, labelHeight)];
            _timeTextField.placeholder = @"请选择";
            _timeTextField.textAlignment = NSTextAlignmentRight;
            //添加日期选择器组件
            UIDatePicker *picker = [[UIDatePicker alloc] init];
            picker.datePickerMode = UIDatePickerModeDate;//模式选择
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            _datePicker.locale = locale;
            [picker addTarget:self action:@selector(pickerValueChanged:) forControlEvents:UIControlEventValueChanged];
            self.timeTextField.inputView = picker;
            [_timeTextField addTarget:self action:@selector(clickMe:) forControlEvents:UIControlEventEditingDidBegin];
            _timeTextField;
        })];
        
        [view addSubview:({
            _countTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 3, TEXT_WIDTH, labelHeight)];
            _countTextField.placeholder = @"请选择";
            _countTextField.textAlignment = NSTextAlignmentRight;
            //添加UIPickerView选择器，选择入住人数
            _countPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
            _peopleArray = [NSArray arrayWithObjects:@"1人",@"2人",@"3人",@"4人",@"5人",@"6人",@"7人",@"8人",@"9人",@"10人", nil];
            _countPickerView.delegate = self;
            _countPickerView.dataSource = self;
            self.countTextField.inputView = _countPickerView;
            //设置人数选择器代理
            _countTextField.delegate = self;
            _countTextField;
        })];
        
        [view addSubview:({
            _dayTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 4, TEXT_WIDTH, labelHeight)];
            _dayTextField.placeholder = @"请选择";
            _dayTextField.textAlignment = NSTextAlignmentRight;
            //添加UIPickerView选择器，选择入住天数
            _daysPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
            _daysArray = [NSArray arrayWithObjects:@"1天",@"2天",@"3天",@"4天",@"5天",@"6天",@"7天",@"8天",@"9天",@"10天", nil];
            _daysPickerView.delegate = self;
            _daysPickerView.dataSource = self;
            self.dayTextField.inputView = _daysPickerView;
            //设置天数选择器代理
            _dayTextField.delegate = self;
            _dayTextField;
        })];
        
        [view addSubview:({
            _priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(10 + LABEL_WIDTH, labelToTop + ViewHeight * 5, TEXT_WIDTH, labelHeight)];
            _priceTextField.placeholder = @"请输入";
            _priceTextField.textAlignment = NSTextAlignmentRight;
            _priceTextField;
        })];
        view;
    })];
}

- (void)clickMe:(UITextField *)textField {
    textField.text = [self getCurrentTime];
}

//获取当前日期
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (void)backToForward {
    BmobObject *info = [BmobObject objectWithClassName:@"hotel3"];
    [info setObject:self.nameText.text forKey:@"name"];
    [info setObject:self.IDText.text forKey:@"identityID"];
    [info setObject:self.hotelTextField.text forKey:@"hotel"];
    [info setObject:self.roomTextField.text forKey:@"roomNumber"];
    [info setObject:self.timeTextField.text forKey:@"time"];
    [info setObject:self.countTextField.text forKey:@"people"];
    [info setObject:self.dayTextField.text forKey:@"day"];
    NSString *priceStr = [NSString stringWithFormat:@"%@元",self.priceTextField.text];
    [info setObject:priceStr forKey:@"price"];
    [info saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    }];
    //发送刷新通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTransferIndex" object:self userInfo:nil];
    //跳转回主页
    [self.navigationController popViewControllerAnimated:YES];
}

//日期选择器时间格式化
- (void)pickerValueChanged:(UIDatePicker *)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    self.timeTextField.text = [formatter stringFromDate:sender.date];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _countPickerView) {
        _countTextField.text = @"1人";
        return _peopleArray.count;
    }else {
        _dayTextField.text = @"1天";
        return _daysArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _countPickerView) {
        return [_peopleArray objectAtIndex:row];
    } else {
        return [_daysArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == _countPickerView) {
        self.countTextField.text = [_peopleArray objectAtIndex:row];
    }else{
        self.dayTextField.text = [_daysArray objectAtIndex:row];
    }
}

- (void)updateHome {
    BmobQuery *bQuery = [BmobQuery queryWithClassName:@"hotel3"];
    NSArray *groupArray = [NSArray arrayWithObject:@"identityID"];
    [bQuery groupbyKeys:groupArray];
    [bQuery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        scrollView.backgroundColor = ZFColor(204, 204, 204);
            [self.view addSubview:scrollView];
            BmobQuery *query = [BmobQuery queryWithClassName:@"hotel3"];
            [query orderByDescending:@"time"];
            [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                //设置scrollView内容范围，即是其滚动范围(控制首页)
                scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (290* array.count) + 100);
                for (int i = 0; i < array.count; i++) {
                    self->_homeView = [[homeViewCard alloc] initWithFrame:CGRectMake(10, 20 + 290 * i, SCREEN_WIDTH - 20, 270)];
                    self->_homeView.backgroundColor = [UIColor whiteColor];
                    self->_homeView.layer.cornerRadius = 5;
                    self->_homeView.layer.masksToBounds = YES;
                    self->_homeView.titleLabel.text = [array[i] objectForKey:@"name"];
                    self->_homeView.IDLabel.text = [array[i] objectForKey:@"identityID"];
                    self->_homeView.hotelLabel.text = [array[i] objectForKey:@"hotel"];
                    self->_homeView.timeLabel.text = [array[i] objectForKey:@"time"];
                    self->_homeView.roomLabel.text = [array[i] objectForKey:@"roomNumber"];
                    self->_homeView.countLabel.text = [array[i] objectForKey:@"people"];
                    self->_homeView.daysLabel.text = [array[i] objectForKey:@"day"];
                    self->_homeView.priceLabel.text = [array[i] objectForKey:@"price"];
                    [scrollView addSubview:self->_homeView];
                }
            }];
        });
    }];
}

@end
