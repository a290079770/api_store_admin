import Vue from 'vue';
import axios from './http.js'
import store from './store/index.js'

Vue.prototype.$http = axios;

export default {
  install(Vue, options) {
      /**
       * [renderActionType 渲染操作类型列]
       * @Author   罗文
       * @DateTime 2017-10-26
       * @return   {[type]}   [description]
       */
    Vue.prototype.apiTransfer = function(method,apiName,upData,callback) {
        method = method.toLowerCase();

        let params = {};

        if(method == 'get') {
           params = {
             params:upData
           }
        }else if(method == 'post') {
           params = upData;
        }

        this.$http[method](apiName,params).then((res) => {
            if(callback) {
               callback(res);
            }
          })
    };

    
    /**
     * [setWindow 设置系统的宽高]
     * @Author   罗文
     * @DateTime 2017-11-13
     * @param    {[type]}   width  [宽度]
     * @param    {[type]}   height [高度]
     */
    Vue.prototype.setWindow = function(width,height) {
       store.dispatch('setWindow',{
          winWidth:width,
          winHeight:height
       });
    }



  }
}
