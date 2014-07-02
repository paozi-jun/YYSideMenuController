

import UIKit

let SCREEN_WIDTH:Float = UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:Float = UIScreen.mainScreen().bounds.size.height

class YYSideMenuController: UIViewController,UIGestureRecognizerDelegate {

    var _needSwipeShowMenu:Bool!
    var needSwipeShowMenu:Bool!{
    set{
        self._needSwipeShowMenu = newValue
        if newValue {
            self.baseView.addGestureRecognizer(self.panGestureRecognizer)
        }else{
            self.baseView.removeGestureRecognizer(self.panGestureRecognizer)
        }
    }
    get{
        return self._needSwipeShowMenu
    }
    }
    
    var _leftViewController:UIViewController!
    var leftViewController:UIViewController!{
    get{
        return self._leftViewController
    }
    set{
        if self.leftViewController != newValue{
            self._leftViewController = newValue
            if self.leftViewController {
                self.leftViewController.removeFromParentViewController()
            }
            if self.leftViewController {
                self.addChildViewController(self.leftViewController)
            }
        }
    }
    }
    
    var _rightViewController:UIViewController!
    var rightViewController:UIViewController!{
    get{
        return self._rightViewController
    }
    set{
        if self.rightViewController != newValue{
            self._rightViewController = newValue
            if self.rightViewController {
                self.rightViewController.removeFromParentViewController()
            }
            if self.rightViewController {
                self.addChildViewController(self.rightViewController)
            }
        }
    }
    }
    
    var _rootViewController:UIViewController!
    var rootViewController:UIViewController!{
    get{
        return self._rootViewController
    }
    set{
        if self.rootViewController != newValue{
            self._rootViewController = newValue
            if self.rootViewController {
                self.rootViewController.removeFromParentViewController()
            }
            if self.rootViewController {
                self.addChildViewController(self.rootViewController)
            }
        }
    }
    }
    
    var leftViewShowWidth:Float!
    var rightViewShowWidth:Float!
    
    var animationDuration:NSTimeInterval!
    var showBoundsShadow:Bool!
    
    //这里暂时还不知道如何定义私有变量
    
    var baseView:UIView!//目前是_baseView
    var currentView:UIView!//其实就是rootViewController.view
    
    var panGestureRecognizer:UIPanGestureRecognizer!
    
    var startPanPoint:CGPoint!
    var lastPanPoint:CGPoint!
    var panMovingRightOrLeft:Bool!//true是向右，false是向左
    
    var coverButton:UIButton!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initData()
    }
    
    func initData(){
        self.leftViewShowWidth = 267
        self.rightViewShowWidth = 267
        self.animationDuration = 0.35
        self.showBoundsShadow = true
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target:self,action:"pan:")
        self.panGestureRecognizer.delegate = self
        
        self.panMovingRightOrLeft = false
        self.lastPanPoint = CGPointZero
        
        self.coverButton = UIButton(frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
        self.coverButton.addTarget(self,action:"hideSideViewController", forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView = self.view
        self.baseView.backgroundColor = UIColor(red:0.5,green:0.6,blue:0.8,alpha:1)
        self.needSwipeShowMenu = true
    }
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        assert(!self.rootViewController , "you must set rootViewController!!")
        if self.currentView != self.rootViewController.view {
            self.currentView.removeFromSuperview()
            self.currentView = self.rootViewController.view
            self.baseView.addSubview(self.currentView)
            self.currentView.frame = self.baseView.bounds
        }
    }
    
    func showShadow(show:Bool){
        self.currentView.layer.shadowOpacity    = show ? 0.8 : 0.0
        if show {
            self.currentView.layer.cornerRadius = 4.0
            self.currentView.layer.shadowOffset = CGSizeZero
            self.currentView.layer.shadowRadius = 4.0
            self.currentView.layer.shadowPath   = UIBezierPath(rect:self.currentView.bounds).CGPath;
        }
    }
    
    func willShowLeftViewController(){
        if self.leftViewController  {
            if self.leftViewController.view.superview {
                self.leftViewController.view.frame = self.baseView.bounds
                self.baseView.insertSubview(self.leftViewController.view,belowSubview:self.currentView)
            }
            if self.rightViewController {
                if self.rightViewController.view.superview {
                    self.rightViewController.view.removeFromSuperview()
                }
            }
        }
    }
    
    func willShowRightViewController(){
        if self.rightViewController  {
            if self.rightViewController.view.superview {
                self.rightViewController.view.frame = self.baseView.bounds
                self.baseView.insertSubview(self.rightViewController.view,belowSubview:self.currentView)
            }
            if self.leftViewController {
                if self.leftViewController.view.superview {
                    self.leftViewController.view.removeFromSuperview()
                }
            }
        }
    }
    
    //var rootViewMoveBlock:(rootView:UIView,orginFrame:CGRect,xoffset:Float)->() = {(rootView:UIView,orginFrame:CGRect,xoffset:Float)->() in }
    
    
    func setRootViewMoveBlock(rootViewMoveBlock:(rootView:UIView,orginFrame:CGRect,xoffset:Float)->()){
        
    }
    
    func showLeftViewController(animated:Bool){
        if self.leftViewController {
            return
        }
        self.willShowLeftViewController()
        var animatedTime:Float = 0
        if animated {
            animatedTime = abs(self.leftViewShowWidth - self.currentView.frame.origin.x) / self.leftViewShowWidth * Float(self.animationDuration)
        }
        UIView.animateWithDuration(NSTimeInterval(animatedTime), delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.layoutCurrentViewWithOffset(self.leftViewShowWidth)
            self.currentView.addSubview(self.coverButton)
            self.showShadow(self.showBoundsShadow)
            }, completion: {(_)->Void in
                
            })
    }
    
    func showRightViewController(animated:Bool){
        if self.rightViewController {
            return
        }
        self.willShowRightViewController()
        var animatedTime:Float = 0
        if animated {
            animatedTime = abs(self.rightViewShowWidth + self.currentView.frame.origin.x) / self.rightViewShowWidth * Float(self.animationDuration)
        }
        UIView.animateWithDuration(NSTimeInterval(animatedTime), delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.layoutCurrentViewWithOffset(self.rightViewShowWidth)
            self.currentView.addSubview(self.coverButton)
            self.showShadow(self.showBoundsShadow)
            }, completion: {(_)->Void in
                
            })
    }
    
    func hideSideViewController(animated:Bool){
        self.showShadow(false)
        var animatedTime:Float = 0
        if animated {
            animatedTime = abs(self.currentView.frame.origin.x / (self.currentView.frame.origin.x>0 ? self.leftViewShowWidth:self.rightViewShowWidth)) * Float(self.animationDuration)
        }
        
        UIView.animateWithDuration(NSTimeInterval(animatedTime), delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.layoutCurrentViewWithOffset(0)
            }, completion: {(_)->Void in
                self.coverButton.removeFromSuperview()
                self.leftViewController.view.removeFromSuperview()
                self.rightViewController.view.removeFromSuperview()
            })
    }
    
    func hideSideViewController(){
        self.hideSideViewController(true)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer!) -> Bool
    {
        if gestureRecognizer == self.panGestureRecognizer {
            var panGesture = gestureRecognizer as UIPanGestureRecognizer
            var translation = panGesture.translationInView(self.baseView)
            if panGesture.velocityInView(self.baseView).x < 600 && abs(translation.x)/abs(translation.y)>1 {
                return true
            }
            return false
        }
        return true
    }
    
    func pan(pan:UIPanGestureRecognizer){
        if self.panGestureRecognizer.state == UIGestureRecognizerState.Began {
            self.startPanPoint = self.currentView.frame.origin
            if self.currentView.frame.origin.x == 0 {
                self.showShadow(self.showBoundsShadow)
            }
            var velocity = pan.velocityInView(self.baseView)
            if velocity.x>0 {
                if self.currentView.frame.origin.x>=0  {
                    if self.leftViewController {
                        if !self.leftViewController.view.superview{
                            self.willShowLeftViewController()
                        }
                    }
                }
            }else if velocity.x<0 {
                if self.currentView.frame.origin.x<=0  {
                    if self.rightViewController{
                        if !self.rightViewController.view.superview{
                            self.willShowRightViewController()
                        }
                    }
                }
            }
            return
        }
        var currentPostion = pan.translationInView(self.baseView)
        var xoffset = self.startPanPoint.x + currentPostion.x
        if (xoffset>0) {//向右滑
            if self.leftViewController  {
                if self.leftViewController.view.superview{
                    xoffset = xoffset>self.leftViewShowWidth ? self.leftViewShowWidth : xoffset
                }
            }else{
                xoffset = 0
            }
        }else if xoffset<0 {//向左滑
            if self.rightViewController  {
                if self.rightViewController.view.superview{
                    xoffset = xoffset < -self.rightViewShowWidth ? -self.rightViewShowWidth : xoffset
                }
            }else{
                xoffset = 0
            }
        }
        if xoffset != self.currentView.frame.origin.x {
            self.layoutCurrentViewWithOffset(xoffset)
        }
        if self.panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            if self.currentView.frame.origin.x != 0 && self.currentView.frame.origin.x != self.leftViewShowWidth && self.currentView.frame.origin.x != -self.rightViewShowWidth {
                if self.panMovingRightOrLeft && self.currentView.frame.origin.x>20 {
                    self.showLeftViewController(true)
                }else if !self.panMovingRightOrLeft && self.currentView.frame.origin.x < -20 {
                    self.showRightViewController(true)
                }else{
                    self.hideSideViewController()
                }
            }else if self.currentView.frame.origin.x == 0 {
                self.showShadow(false)
            }
            self.lastPanPoint = CGPointZero
        }else{
            var velocity = pan.velocityInView(self.baseView)
            if velocity.x > 0 {
                self.panMovingRightOrLeft = true
            }else if velocity.x < 0 {
                self.panMovingRightOrLeft = false
            }
        }
    }
    
    func layoutCurrentViewWithOffset(xoffset:Float){
        if self.showBoundsShadow {
            self.currentView.layer.shadowPath = UIBezierPath(rect:self.currentView.bounds).CGPath
        }
//        if self.rootViewMoveBlock {//如果有自定义动画，使用自定义的效果
//            self.rootViewMoveBlock(_currentView,_baseView.bounds,xoffset);
//            return;
//        }
        
//        var h2w:Float = 0;
//        if h2w==0 {
//            h2w = self.baseView.frame.size.height/self.baseView.frame.size.width
//        }
        var scale = abs(600 - abs(xoffset)) / 600
        scale = max(0.8, scale)
        self.currentView.transform = CGAffineTransformMakeScale(scale, scale)
        
        var totalWidth:Float = self.baseView.frame.size.width
        var totalHeight:Float = self.baseView.frame.size.height
        if UIInterfaceOrientationIsLandscape(self.interfaceOrientation) {
            totalHeight = self.baseView.frame.size.width
            totalWidth = self.baseView.frame.size.height
        }
        
        if xoffset > 0  {//向右滑的
            self.currentView.frame = CGRectMake(xoffset,self.baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)
        }else{//向左滑的
            self.currentView.frame = CGRectMake(self.baseView.frame.size.width * (1 - scale) + xoffset, self.baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
