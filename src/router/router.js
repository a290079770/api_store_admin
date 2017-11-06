import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
//import Login from 'components/login/Login'

export default new Router({
  routes: [{
      path: '/login',
      component: resolve => require(['@/components/login/Login'], resolve)
    }, 
    {
      path: '/wrap',
      component: resolve => require(['@/components/client/wrap'], resolve),
      redirect: 'wrap/addExp',
      beforeEnter: (to, from, next) => {
        if (sessionStorage.getItem('userId') && sessionStorage.getItem('userId') != 'undefined' && sessionStorage.getItem('nickname') && sessionStorage.getItem('nickname') != 'undefined') {
          next()
        } else {
          next({ path: '/login' })
        }
      },
//    redirect:'/wrap/addExp',
      children:[
         {
            path: 'addExp',
            component: resolve => require(['@/components/client/addExp'], resolve),
         },
         {
            path: 'addExpForm',
            component: resolve => require(['@/components/client/addExpForm'], resolve),
         },
         {
            path: 'addExpSetForm',
            component: resolve => require(['@/components/client/addExpSetForm'], resolve),
         },
         {
            path: 'addExpChainForm',
            component: resolve => require(['@/components/client/addExpChainForm'], resolve),
         },
         {
            path: 'reView',
            component: resolve => require(['@/components/client/reView'], resolve),
         },
         {
            path: 'reViewList',
            component: resolve => require(['@/components/client/reViewList'], resolve),
         },
         {
            path: 'updateList',
            component: resolve => require(['@/components/client/updateList'], resolve),
         },{
            path: 'parse',
            component: resolve => require(['@/components/client/parse'], resolve),
         },
         {
            path: 'parseKoi',
            component: resolve => require(['@/components/client/parseKoi'], resolve),
         },
         {
            path: 'messageList',
            component: resolve => require(['@/components/client/messageList'], resolve),
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
