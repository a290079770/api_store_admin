import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
//import Login from 'components/login/Login'

export default new Router({
  routes: [{
      path: '/login',
      component: resolve => require(['@/components/login/Login_index'], resolve)
      // component: resolve => require(['@/common/canvasTime'], resolve)
    }, 
    {
      path: '/admin',
      component: resolve => require(['@/components/admin/admin'], resolve),
      // beforeEnter: (to, from, next) => {
      //   if (sessionStorage.getItem('userId') && sessionStorage.getItem('userId') != 'undefined' ) {
      //     next()
      //   } else {
      //     next({ path: '/login' })
      //   }
      // },
      redirect:'/admin/index',
      children:[
         {
            path: 'index',
            name:'首页',
            component: resolve => require(['@/components/admin/index'], resolve),
         },
         {
            path: 'products',
            name:'产品列表',
            component: resolve => require(['@/components/admin/products'], resolve),
         },
         {
            path: 'users',
            name:'用户列表',
            component: resolve => require(['@/components/admin/users'], resolve),
         },
         {
            path: 'managers',
            name:'管理员列表',
            component: resolve => require(['@/components/admin/managers'], resolve),
         },
         {
            path: 'apiList',
            name:'api接口列表',
            component: resolve => require(['@/components/admin/apiList'], resolve),
         },
         {
            path: 'apiCreate',
            name:'新增接口',
            component: resolve => require(['@/components/admin/apiCreate'], resolve),
         },
         {
            path: 'apiUpdate',
            name:'修改接口',
            component: resolve => require(['@/components/admin/apiUpdate'], resolve),
         },
         {
            path: 'apiDetail',
            name:'接口详情',
            component: resolve => require(['@/components/admin/apiDetail'], resolve),
         }
      ]
    },
    {
      path: '*',redirect: '/login'
    },
    {
      path: '/',redirect: '/login'
    },
     {
     path: '/index',
     component: resolve => require(['@/components/index'], resolve),
   }
  ]
})
