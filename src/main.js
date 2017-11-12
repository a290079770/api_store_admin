
// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'

import ElementUi from 'element-ui'
Vue.use(ElementUi);
// import 'element-ui/lib/theme-chalk/index.css';
import '../theme/index.css';
//引入elementui组件库
//
import './assets/icon/iconfont.css';

import axios from './http.js'
Vue.prototype.$http = axios;
//引入axios

import Vuex from 'vuex'
Vue.use(Vuex);
import store from './store/index.js'
//引入vuex

//引入全局方法
import util from './util'
Vue.use(util);

//解决IE下不支持promise
import 'babel-polyfill';

import router from './router/router.js'
// import './assets/normalize.css'
// //引入初始化样式

Vue.config.productionTip = false
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  template: '<App/>',
  components: { App }
})
