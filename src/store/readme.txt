vuex就是一个状态管理机，用于管理整个项目中的公共状态，便于在组件之间进行数据传递

1，建议先大概了解一下vuex，了解其涉及到的actions -> mutations -> state -> view的流程

2，整个实例在本文件夹内部，付注释

3，实例阅读流程

   a,先运行npm run dev -> localhost:8080/#/vuex -> 具体操作一下
   b,查看代码 main.js -> components/vuex.vue 查看配置和组件的内容
   c,查看状态机vuex -> src/store

     状态机书写流程： index.js ->types.js ->actions.js ->mutations.js ->getters.js

4，建议阅读者先写一个demo练习

5，建议：对于组件内部的私有状态，并不需要与其他组件共同维护时，请放在组件内部，减少store的冗余
