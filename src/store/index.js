/*
  这里面定义是store的出口，将actions，mutations，和getters整合
  这里需要引入到main.js中
  整个应用都能访问store里的actions，state等
 */
import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import actions from './actions.js';
import mutations from './mutations.js';
import getters from './getters.js';


export default new Vuex.Store({
	actions,
	//mutations里包含mutations和state，所以放在modules
	//另外这里可以将state独立出来，通过import引入
	modules:{
		mutations
	},
	getters
})