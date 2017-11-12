/*
  这里面只用于对state的操作，不允许进行逻辑、流程、异步等操作
 */

import {
     	ADD,
     	DECREMENT,
      OPENLOGINMODAL,
      SETWINDOW
       } from './types.js';

import state from './state.js';


const mutations = {
    [ADD]:(state,index)=>{
      state.count += index;
    },
    
    [DECREMENT]:(state)=>{
      state.count --;
    },

    [OPENLOGINMODAL]:(state,modalState)=>{
      state.loginDialog=modalState;
    },

    [SETWINDOW]:(state,winWidth,winHeight) =>{
      state.winWidth = winWidth;
      state.winHeight = winHeight;
    }
}


export default {
	mutations,
	state,
}

//这里需要将mutations和state一起暴露给index.js
//如果是将state独立出来的，可以另外处理