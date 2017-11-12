/*
  这里面定义所有action，也就是store的dispatch方法，用于处理接收组件传入的请求
  所有的流程控制、逻辑处理、异步操作都放在这里面进行
  通过commit提交给mutations，通过type作为两者相连的唯一通道
 */
import * as types from './types.js';

var index1 = 1;
export default {
	//这是可以传参数的action
	add:({commit},index)=>{
	   index1 = index || 1;
       commit(types.ADD,index);
	},
	//这是有流程控制的action
	decrement:({commit,state})=>{
       if(state.mutations.count > 0) {
          commit(types.DECREMENT);
       }
	},
	addOdd:({commit,state})=>{
	   if(state.mutations.count % 2 == 0) {
		  commit(types.ADD,index1);
	   }
	},
	//这是有异步的操作
	addAsync:({commit})=>{
       new Promise(resolve=>{
       	  setTimeout(function(){
       	  	commit(types.ADD,index1)
       	  },1000)
       })
	},

	//控制登录注册的模态框
	openLoginModal:({commit},modalState)=>{
		 commit(types.OPENLOGINMODAL,modalState);
	},

	//控制页面的宽高及侧边栏宽度
	setWindow:({commit},{winWidth,winHeight})=>{
		 commit(types.SETWINDOW,winWidth,winHeight);
	},

	



}