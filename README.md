# order_device_flutter

flutter 点餐练习项目

# 项目截图

<div style="float:right">
  <img src="https://github.com/sjjrdfivk/order_device/blob/main/images/1.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/sjjrdfivk/order_device/blob/main/images/2.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/sjjrdfivk/order_device/blob/main/images/3.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/sjjrdfivk/order_device/blob/main/images/4.jpg" width="270"/>&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/sjjrdfivk/order_device/blob/main/images/5.jpg" width="270"/>
</div>

生命周期整体分为三个部分：初始化 / 状态改变 / 销毁；

initState 在整个生命周期中的初始化阶段只会调用一次；

didChangeDependencies 当 State 对象依赖发生变动时调用；

didUpdateWidget 当 Widget 状态发生改变时调用；实际上每次更新状态时，Flutter 会创建一个新的 Widget，并在该函数中进行新旧 Widget 对比；一般调用该方法之后会调用 build；

reassemble 只有在 debug 或 热重载 时调用；

deactivate 从 Widget Tree 中移除 State 对象时会调用，一般用在 dispose 之前；

dispose 用于 Widget 被销毁时，通常会在此方法中移除监听或清理数据等，整个生命周期只会执行一次；

resumed 应用程序可见且获取焦点状态，类似于 Android onResume()；

inactive 应用程序处于非活动状态；

paused 应用程序处于用户不可见，不响应用户状态，处于后台运行状态，类似于 Android onPause()；
