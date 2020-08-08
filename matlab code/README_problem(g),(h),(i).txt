这是一个用于比较投影梯度法、次梯度方法、近端梯度法、对偶问题的ALM、ADMM方法以及原问题的ADMM方法的代码集合。

程序所用软件：matlab R2018b

所有文件内容注释

1.    l1.m：计算问题目标函数的函数值

2.    l1_cvx_mosek.m：使用cvx的mosek求解器求解问题
输出参数out：
optval：最优值
cputime：运行时间

3.    l1_PGD_primal.m：使用投影梯度法求解问题
输入参数opts：
t：迭代步长
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值

4.    l1_SGD_primal.m：使用次梯度法求解问题
输入参数opts：
t：迭代步长
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值

5.    l1_ProxGD_primal.m：使用近端梯度法求解问题
输入参数opts：
t：迭代步长
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值

6.    l1_ALM_dual.m：使用对偶问题的ALM方法求解问题
输入参数opts：
tau：惩罚系数
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值


7.    l1_ADMM_dual.m：使用对偶问题的ADMM方法求解问题
输入参数opts：
tau：惩罚系数
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值


8.    l1_ADMM_lprimal.m：使用原问题的ADMM方法求解问题
输入参数opts：
tau：惩罚系数
Max：每个mu迭代的最大迭代次数
eps：每个mu迭代的终止精度
输出参数out：
objvalue：最优值
y：每次迭代的目标函数值

9.    subgradient_l1.m：计算问题目标函数的次梯度

10.    shrink.m：计算l_1问题的proximal算子

11.    l1_ALM_dual_DL.m：计算对偶问题的ALM方法求解问题的DL子问题

12.    DL_function.m：计算对偶问题的增广拉格朗日函数的函数值

13.    DL_proj_s.m：将向量投影到区间[-mu,mu]中

14.   Test_l1_regularized_problems.m：测试六种方法的各种性能
为保证问题能够复现,选取随机种子97006855.

强调：在使用l1_cvx_mosek.m时可能会提示出错,
如果提示出错请再运行第二遍即可.