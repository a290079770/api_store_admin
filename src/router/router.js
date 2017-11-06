import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
//import Login from 'components/login/Login'

export default new Router({
  routes: [{
      path: '/login',
      component: resolve => require(['@/components/login/Login_index'], resolve)
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
      redirect:'/admin/investigate',
      children:[
         {
            path: 'investtype',
            component: resolve => require(['@/components/admin/investtype'], resolve),
         },
         {
            path: 'investigate',
            component: resolve => require(['@/components/admin/investigate'], resolve),
         },
         {
            path: 'review',
            component: resolve => require(['@/components/admin/review'], resolve),
         },
         {
            path: 'systemLog',
            component: resolve => require(['@/components/admin/systemLog'], resolve),
         },
         {
            path: 'userAdmin',
            component: resolve => require(['@/components/admin/userAdmin'], resolve),
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
