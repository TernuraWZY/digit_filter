# OpenFoam_tools
OpenFoam工具
U入口边界条件，数值过滤器，使用方法如下：
  1. 在需要使用数值过滤器case中执行cellCenters命令，获取入口面网格中心坐标数组
  2. 将坐标数组放入fuelnode文件，执行fuelnodePro.py把格式修改成matlab可以读取的格式
  3. 25Dpipe文件为fluent得到的充分发展切面上的数据，运行matlab脚本sidian.m，得到面网格中心点插值数据文件ref、L、R
  4. 把ref、L、R复制到Ugenerate文件夹，执行Ugenerate.py，生成文件U即所需U边界文件
