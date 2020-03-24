[![Platform](https://img.shields.io/badge/平台-%20IOS%20-brightgreen.svg)](https://github.com/sam38124)
[![characteristic](https://img.shields.io/badge/特點-%20輕量級%20%7C%20簡單易用%20%20%7C%20穩定%20-brightgreen.svg)](https://github.com/sam38124)
# JzOsViewPager
基於IOS CollectionView的頁面切換器，同時支援定時跑馬燈!!
## 目錄
* [如何導入到專案](#Import)
* [快速使用](#Use)

<a name="Import"></a>
## 如何導入到項目
> 支持framework導入。 <br/>

#### 1.首先將framework拉入要導入的Project當中
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i2.png" width = "800"  alt="i1" /><a name="Use"></a>
#### 2.將三個選項打勾
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i1.png" width = "800"  alt="i1" /><a name="Use"></a>
#### 3.選擇Embed and signed
<img src="https://github.com/sam38124/JzOsFrameWork/blob/master/i3.png" width = "800"  alt="i1" /><a name="Use"></a>
<a name="Use"></a>
## 快速使用
### 1.第一步宣告你的viewpager(備註：如不調用addchild則不可將宣告放於function內部，否則function執行完則會被回收掉)
```swift
 let pager=JzViewPager()
```
### 2.添加至你的容器
```swift
    //設定你的JzViewPager的frame
    pager.view.frame=contentView.frame
    //添加至你的容器
    contentView.addSubview(pager.view)
```
### 3.初始設定方法
**getcell必須return你的UICollectionViewCell**<br/>
**itemcount必須return你的頁面數量**<br/>
**register則是你要註冊xib**<br/>
**autoScroll是否進行跑馬燈**<br/>
**switchTimer頁面切換的速度**<br/>
```swift
  //進行初始化設定
    public func setUp(getcell: @escaping ((UICollectionView, IndexPath) -> UICollectionViewCell), 
    itemcount: @escaping (() -> Int), register: [String], autoScroll: Bool = true, switchTimer: Double = 1.5)
```
### 4.通知資料更新
```swift
pager.notifyDataSetChange()
```
<a name="About"></a>
### 關於我
橙的電子android and ios developer

*line:sam38124

*gmail:sam38124@gmail.com
