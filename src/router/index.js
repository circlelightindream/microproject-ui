import Vue from 'vue'
import Router from 'vue-router'
import Index from '../components/Index'
import Update from '../components/Update'
import HelloWorld from "../components/HelloWorld";
Vue.use(Router);
export default new Router({
  routes: [
    {
      path: '/',
      redirect: '/index'
    },
    {
      path: '/HelloWorld',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/index',
      name: 'Index',
      component: Index
    },
    {
      path: '/add',
      name: 'Update',
      component: Update
    }
  ]
})
