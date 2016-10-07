
总结：
1.UIStackView提供了一个高效的接口用于平铺一行或一列的视图组合。
2.它神奇的地方：当您添加另一个图像视图时，stack view会自动布局图像视图，为您设置必要的约束
3.属性
    3.1 axis  决定是否应布置的视图垂直或水平布置。
    3.2  alignment选项控制这些视图的对齐方式。比如你如果设置成Leading，stack view管理的视图排列按Leading对齐。
    3.3  distribution 属性决定了其管理的视图的大小和位置。默认设置为Fill。这是stack view尽量让它的所有子视图在一个合理的距离。现在把它改为Fill Equally。stack view会调整它所有的子视图一样的尺寸。
    3.4  spacing  属性让你设置视图之间的间距。把它值改为10来增加图像视图之间的间距。


4. Stack View的核心便是方便垂直或水平排布多个subview
5. Stack View最有用的就是它会自动为每个subview创建和添加Auto Layout constraints。当然你可以控制subview的大小和位置。可以通过选项配置subview的大小、排布以及彼此间的间距。
6.Axis表示Stack View的subview是水平排布还是垂直排布。Alignment控制subview对齐方式。Distribution定义subview的分布方式。Spacing 为subview间的最小间距。
把术语简化一下，你可这样理解：Alignment 用于控制X 和 Y值，而Distribution 用于控制高度和宽度。另两个值都会影响对齐。如果选中Baseline Relative将根据subview的基线调整垂直间距。如果选中Layout Margins Relative 将相对于标准边界空白来调整subview位置。

7. 另一个需要记住的是，Stack View会被当成Container View。所以它是一个不会被渲染的UIView子类。它不像其他UIView子类一样，会被渲染到屏幕上。这也意味着设置其backgroundColor属性或重载drawRect:方法都不会产生任何效果。

8.纯代码写的时候，stack View的属性subViews和arrangedSubvies属性的不同。如果你想添加一个subview给Stack View管理，你应该调用addArrangedSubview:或insertArrangedSubview:atIndex: arrangedSubviews数组是subviews属性的子集。
要移除Stack View管理的subview，需要调用removeArrangedSubview:和removeFromSuperview。移除arrangedSubview只是确保Stack View不再管理其约束，而非从视图层次结构中删除，理解这一点非常重要