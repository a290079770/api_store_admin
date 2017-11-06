/**
 * 统一配置axios
 * 使用qs.stringify解决axios跨域问题
 * 配置axios请求类型为post时，使用qs.stringify来实现跨域访问，以及每次请求携带token
 * 配置请求成功后res，实现诸如登录失败，登录超时，账户密码错误和请求错误等拦截器
 */

import axios from 'axios'
import qs from 'qs'
import { MessageBox } from 'element-ui'
import router from './router/router'

// import * as types from './store/types'

// axios 配置
axios.defaults.timeout = 5000;

var apiUrl = 'http://demo.koi.kingchannels.cn';
// var apiUrl = 'http://api.koi.kingchannels.cn';
//var apiUrl = 'http://192.168.2.53:8100';
if(apiUrl){
    var regExp = /^((https?|ftp|news):\/\/)?([a-z]([a-z0-9\-]*[\.。])+([a-z]{2}|aero|arpa|biz|com|coop|edu|gov|info|int|jobs|mil|museum|name|nato|net|org|pro|travel)|(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))(\/[a-z0-9_\-\.~]+)*(\/([a-z0-9_\-\.]*)(\?[a-z0-9+_\-\.%=&]*)?)?(#[a-z][a-z0-9_]*)?$/g;
    if (apiUrl.match(regExp)){
        // axios.defaults.baseURL = apiUrl+'/bridge';
        axios.defaults.baseURL = apiUrl;
    }else{
      alert('域名配置不正确，请检查 \n文件路径：/static/config.js')
    }
}else{
   alert('域名不存在，请检查 \n文件路径：/static/config.js')
}

// axios.defaults.baseURL = apiUrl;
axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;charset=UTF-8';


// http request 拦截器

axios.interceptors.request.use(
    config => {
      // 如果方法为post，使用qs.stringify实现跨域访问
      if(config.method  === 'post'){
        config.data = qs.stringify(config.data);
      }
      // if (store.state.token) {
      //     config.headers.Authorization = `token ${store.state.token}`;
      // }
      return config;
    },
    err => {
      return Promise.reject(err);
    });

// http response 拦截器
/**
 * @DateTime  2017-05-08T09:19:43+0800
 * 拦截器也可以判定返回的response成功时的状态码进行拦截
 */
axios.interceptors.response.use(
    res => {
      // res.data.Code =34;
       if (res.data.Code == 34) { //连接超时
            MessageBox.alert('你已登录超时，请重新登陆后再试！', '提示', {
              confirmButtonText: '确定',
              type: 'warning',
            }).then(()=>{
              router.push('/');
            })
        }else{ //请求成功
        return res;
      }
    },
    error => {
      if (error.response) {
        switch (error.response.status) {
          case 401:
            // 401 清除token信息并跳转到登录页面
            // store.commit(types.LOGOUT);
            router.replace({
                path: 'login',
                query: {redirect: router.currentRoute.fullPath}
            })
        }
      }
      // console.log(JSON.stringify(error));//console : Error: Request failed with status code 402
      // return Promise.reject(error.response.data)
  });

export default axios;