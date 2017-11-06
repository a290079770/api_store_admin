<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'app',
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color:#444;
  height: 100%;
  width: 100%;
  overflow-x: hidden;
}

::-webkit-scrollbar{width:0px;}
::-webkit-scrollbar-track{background-color:#bee1eb;}
::-webkit-scrollbar-thumb{background-color:#00aff0;}

.title {
   margin-top :20px;
   color: #3372b7;
}

.yellow-place {
      display: inline-block;
      margin-bottom: 10px;
      height: 5px;
      width: 26px;
      background: #fec708;
    }

 .table-page-title h3{
 	font-weight: normal;
 	margin-bottom: 15px;
 }   

 .add-form {
 	margin-top: 30px;
 }


.background-img {
  position: fixed;
}

.left-top {
  left: 20.6%;
  /*top:4.3%;*/
}

.right-bottom {
  right: 0;
  bottom:0;
}



</style>
