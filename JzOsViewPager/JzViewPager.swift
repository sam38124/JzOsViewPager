//
//  JzViewPager.swift
//  JzOsViewPager
//
//  Created by Jianzhi.wang on 2020/3/21.
//  Copyright © 2020 Jianzhi.wang. All rights reserved.
//

import UIKit

public class JzViewPager: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource,UIScrollViewDelegate{
    var register=[String]()
    public  var timer: Timer?
    
    var collectest: UICollectionView!
    var time:Double=0
    var autoScroll = false
    let layout = UICollectionViewFlowLayout()
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemcount!()
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getcell!(collectionView,indexPath)!
    }
    
    var getcell:((_ cell:UICollectionView,_ indexPath:IndexPath)->UICollectionViewCell?)?=nil
    
    var itemcount:(()->Int)?=nil
    
    
    // var collectest: UICollectionView! = nil
    
    public  override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    public func setUp(getcell:@escaping ((_ cell:UICollectionView,_ indexPath:IndexPath)->UICollectionViewCell),itemcount:@escaping (()->Int),register:[String],autoScroll:Bool=true,switchTimer:Double=1.5){
        self.register=register
        self.getcell=getcell
        self.itemcount=itemcount
        self.autoScroll=autoScroll
        self.time=switchTimer
        if(timer != nil){
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true){_ in
            if(!self.canscroll){return}
            if(self.itemcount==nil){return}
            if(self.itemcount!()==0){return}
            self.scrollposition+=1
            if(self.scrollposition>=self.itemcount!()){
                self.scrollposition=0
            }
            self.collectest.scrollToItem(at: IndexPath(row: self.scrollposition, section: 0), at: .right, animated: true)
        }
    }
    
    public func notifyDataSetChange(){
        if(collectest==nil){return}
        collectest.reloadData()
    }
    var scrollposition=0
    var canscroll=true
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if(collectest==nil){return}
        if(scrollView != collectest){return}
        canscroll=true
        if(scrollView.contentOffset.x==0){return}
        var position=Int(scrollView.contentOffset.x/view.frame.width)
        let less=Int(scrollView.contentOffset.x)%Int(view.frame.width)
        if(less>Int(view.frame.width/2)){
            position += 1
        }
        print("scrollView:position\(position)")
        collectest.scrollToItem(at: IndexPath(row: position, section: 0), at: .right, animated: true)
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(collectest==nil){return}
        if(scrollView != collectest){return}
        canscroll=true
        if(scrollView.contentOffset.x==0){return}
        var position=Int(scrollView.contentOffset.x/view.frame.width)
        let less=Int(scrollView.contentOffset.x)%Int(view.frame.width)
        if(less>Int(UIScreen.main.bounds.width/2)){
            position += 1
        }
        print("DidEndDragging:position\(position)")
        collectest.scrollToItem(at: IndexPath(row: position, section: 0), at: .right, animated: true)
    }
    public  override func viewWillDisappear(_ animated: Bool) {
        if(timer != nil){
            timer?.invalidate()
        }
    }
    override public func viewDidAppear(_ animated: Bool) {
        if(collectest != nil){  collectest.removeFromSuperview()}
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize.height = CGFloat(view.frame.height)
        layout.itemSize.width = CGFloat(view.frame.width)
        collectest=UICollectionView.init(frame:CGRect(x: 0, y: 0, width: Int(view.frame.width), height: Int(view.frame.height)), collectionViewLayout: layout)
        view.addSubview(collectest)
        for i in register{
                   collectest.register(UINib(nibName:i, bundle:nil),
                                       forCellWithReuseIdentifier:i)
               }
        collectest.bounces=false
        collectest.dataSource=self
        collectest.delegate=self
        collectest.collectionViewLayout=layout
        for i in register{
            collectest.register(UINib(nibName:i, bundle:nil),
                                forCellWithReuseIdentifier:i)
        }
        collectest.backgroundColor = UIColor.white
        collectest.reloadData()
    }
    public override func viewWillAppear(_ animated: Bool) {
        if(collectest==nil){return}
        if(timer != nil){
            timer?.invalidate()
        }
        if(autoScroll){
            timer = Timer.scheduledTimer(withTimeInterval: time, repeats: true){_ in
                if(!self.canscroll){return}
                if(self.itemcount==nil){return}
                if(self.itemcount!()==0){return}
                self.scrollposition+=1
                if(self.scrollposition>=self.itemcount!()){
                    self.scrollposition=0
                }
                self.collectest.scrollToItem(at: IndexPath(row: self.scrollposition, section: 0), at: .right, animated: true)
            }
        }
    }
    
}
