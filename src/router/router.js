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
      beforeEnter: (to, from, next) => {
        if (sessionStorage.getItem('userId') && sessionStorage.getItem('userId') != 'undefined' ) {
          next()
        } else {
          next({ path: '/login' })
        }
      },
      redirect:'/admin/index',
      children:[
         {
            path: 'index',
            component: resolve => require(['@/components/admin/index'], resolve),
         },
         {
            path: 'products',
            component: resolve => require(['@/components/admin/products'], resolve),
         },
         {
            path: 'users',
            component: resolve => require(['@/components/admin/users'], resolve),
         },
         {
            path: 'managers',
            component: resolve => require(['@/components/admin/managers'], resolve),
         },
         {
            path: 'apiList',
            component: resolve => require(['@/components/admin/apiList'], resolve),
         },
         {
            path: 'apiDetail',
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
