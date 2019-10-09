# LSCGDTimer
一个GCD倒计时的工具。
在开发中我们往往都会碰到 发送短信倒计时的按钮，比如相隔多久table 滚动一个cell 这样的需求。
所以我自己就封装一个只有倒计时功能的小工具。
可能在别的地方会使用。
代码不多 里面都有注释 

使用方式：

````
@property (copy, nonatomic) NSString *task; ///创建一个标示来接收 LSGCDTimer 返回出来的timerName 标示。
////创建 开始  start 几秒后开始   interval  时间间隔   repeats 是否是重复   async  是否同步和异步 YES 就是异步
  self.task = [LSGCDTimer execTask:^{
        NSLog(@"倒计时");
    } start:1 interval:1 repeats:YES async:YES];
    
////取消倒计时
[LSGCDTimer cancelTask:self.task];
    
````
