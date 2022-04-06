//
//  AWUFeatureCardsView.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//  滚动的卡片控件

#import "AWUIFeatureCardsView.h"
#import "AWUIFeatureCardsCell.h"

@interface AWUIFeatureCardsView() <UICollectionViewDelegate,UICollectionViewDataSource>

/// 上面的轮训的卡片的collectionView
@property(strong, nonatomic)UICollectionView *cardsCollectionV;
///定时器
@property(strong, nonatomic)CADisplayLink *displayLink;
///小卡片的数据
@property(strong, nonatomic)NSArray<AWUIFeatureCellModel *> *dataArray;
///整体的数据
@property(strong, nonatomic)AWBaseComponentModel *scrollingModel;

@end

@implementation AWUIFeatureCardsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfig];
    }
    return self;
}

- (void)dealloc {
    [self stopDisplayLink];
}

- (void)initConfig {
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self makeUI];
}

#pragma mark - UI初始化

- (void)makeUI {
    [self addSubview:self.cardsCollectionV];
}

- (UICollectionView *)cardsCollectionV {
    if (!_cardsCollectionV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(120, 160);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
        
        _cardsCollectionV = [[UICollectionView alloc]initWithFrame:
                             CGRectMake(0,
                                        0,
                                        UIScreen.mainScreen.bounds.size.width,
                                        160)
                                              collectionViewLayout:layout];
        
        _cardsCollectionV.showsVerticalScrollIndicator = NO;
        _cardsCollectionV.showsHorizontalScrollIndicator = NO;
        
        _cardsCollectionV.delegate = self;
        _cardsCollectionV.dataSource = self;
        _cardsCollectionV.backgroundColor = UIColor.clearColor;
        
        [_cardsCollectionV registerClass:AWUIFeatureCardsCell.class forCellWithReuseIdentifier:@"AWUIFeatureCardsCell"];

    }
    return _cardsCollectionV;
}

#pragma mark - displayLink
- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(loopCards:)];
    }
    return _displayLink;
}

- (void)loopCards:(CADisplayLink *)displayLink {
    CGFloat x = self.cardsCollectionV.contentOffset.x + 0.83;
    self.cardsCollectionV.contentOffset = CGPointMake(x, 0);
}

- (void)stopDisplayLink {
    if (self.displayLink) {
        [self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [self.displayLink invalidate];
    }
}

#pragma mark - 填充数据
- (void)setData:(AWBaseComponentModel *)scrollingModel {
    self.scrollingModel = scrollingModel;
    //组装小卡片的数据
    NSMutableArray *scrollingArray = [[NSMutableArray alloc]init];
    for (AWBaseComponentModel *itemModel in scrollingModel.components) {
        AWUIFeatureCellModel *model = [[AWUIFeatureCellModel alloc]init];
        if (itemModel.attr && itemModel.attr.src) {
            model.featureImgUrl = itemModel.attr.src;
        }
        model.featureName = itemModel.text;
        [scrollingArray addObject:model];
    }
    if (scrollingArray.count > 0) {
        self.dataArray = scrollingArray;
    }
    //设置滚动方式
    if (scrollingModel.attr && scrollingModel.attr.animation) {
        AWUIScrollType type = scrollingModel.attr.animation;
        if (type == AWUIScrollTypeAuto) {
            //设置不可以手动滑动
            self.cardsCollectionV.scrollEnabled = NO;
        }
        
        if (type == AWUIScrollTypeManual) {
            [self stopDisplayLink];
        }
    }
    //重新刷新数据
    [self.cardsCollectionV reloadData];
}
- (void)setData:(NSArray<AWUIFeatureCellModel *> *)dataArray
     scrollType:(AWUIScrollType)type {
    self.dataArray = dataArray;
    
}


#pragma mark - collection delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AWUIFeatureCardsCell *cell = (AWUIFeatureCardsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"AWUIFeatureCardsCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[AWUIFeatureCardsCell alloc]initWithFrame:CGRectMake(0, 0, 120, 160)];
    }
    cell.model = self.dataArray[indexPath.row];
    //设置文案的颜色
    if (self.scrollingModel) {
        [self.scrollingModel setDataToLabel:cell.label];
    }
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.displayLink setPaused:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self.displayLink setPaused:NO];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        [self.displayLink setPaused:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.cardsCollectionV.contentOffset.x <= 0) {
        CGFloat x = self.cardsCollectionV.contentSize.width / 3.0;
        self.cardsCollectionV.contentOffset = CGPointMake(x, 0);
    } else if (self.cardsCollectionV.contentOffset.x >= self.cardsCollectionV.contentSize.width /2) {
        CGFloat x = self.cardsCollectionV.contentSize.width / 3.0;
        self.cardsCollectionV.contentOffset = CGPointMake(x, 0);
    }
}

@end
