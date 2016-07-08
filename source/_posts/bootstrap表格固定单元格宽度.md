---
title: bootstrap表格固定单元格宽度
date: 2016-06-27 20:27:58
tags: [bootstrap]
---
bootstrap表格是自适应的，当自动计算的列宽不合适时，可通过colgroup来控制单元格的宽度，如果只定义了部分单元格的宽度，其他的单元格还是会自适应的调整。
```
<table class="table table-bordered table-striped">
    <colgroup>
        <col style>
        <col style>
        <col style>
        <col style="width:10%;">
        <col style>
        <col style="width:20%;">
    </colgroup>
    <thread>
        <tr>
            <th>1</th>
            <th>2</th>
            <th>3</th>
            <th>4</th>
            <th>5</th>
            <th>6</th>
        </tr>
    </thread>
    <tbody>
        <tr>
            <td>a</td>
            <td>b</td>
            <td>c</td>
            <td>d</td>
            <td>e</td>
            <td>f</td>
        </tr>
    </tbody>
```
