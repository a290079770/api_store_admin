/*
  这里面定义所有页面需要的展示数据，具体的内容根据具体组件要求来定义
 */
export default {
   count:(state)=>{
     return state.mutations.count;
   },
   //对应vuex.vue组件中的getter
   isOdd:(state)=>{
     return state.mutations.count % 2 == 0 ? '偶数':'奇数' 
   },
   //登录注册模态框
   openDialog:(state)=>{
   	return state.mutations.loginDialog;
   },
   
   //返回系统宽度
   winWidth:(state)=>{
    return state.mutations.winWidth;
   },
   
   //返回系统高度
   winHeight:(state)=>{
    return state.mutations.winHeight;
   }	
}