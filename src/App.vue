<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import './assets/css/Product.less'

export default {
  name: 'app',
  data() {
  	return {
  		winWidth:window.innerWidth,
        winHeight:window.innerHeight,
  	}
  },
  mounted() {
    this.setWindow(window.innerWidth,window.innerHeight);
    window.onresize = ()=>{
       this.setWindow(window.innerWidth,window.innerHeight);
    }
  }
}
</script>

<style>




</style>
