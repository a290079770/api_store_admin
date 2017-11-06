<template>
  <div >
     <div class="add-exp-form">
        <div style="margin-bottom:40px"> 

            <el-input 
            placeholder="请输入KOI编码进行精确查找" 
            suffix-icon="el-icon-search" 
            v-model="keyWords" 
            style="width:40%;margin-top:50px;"
            @keyup.enter.native="searchKeyWord"
            >
            </el-input>
        </div>
        <koi-detail :formData="formData" v-show="isShowSearch"></koi-detail>

    </div>

  </div>
</template>

<script>
   import KoiDetail from './koiDetail.vue';
   export default {
     data(){
      return {
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
          
           ExpType:'知识元',
           ExpTypeNum:1,
           formLabelWidth: '100px',
           isShowSearch:false,
           keyWords:'',
           formData:{}

        }
     },
     components:{
      'koi-detail':KoiDetail,
     },
     methods:{
        setWindow() {
           this.winWidth = window.innerWidth;
           this.winHeight = window.innerHeight;
       },
       
       /**
        * [searchKeyWord 搜索KOI]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @return   {[type]}   [description]
        */
       searchKeyWord() {
          if(!this.keyWords) return;
         
          this.$http.get('/KoiNumber/Detail',{
             params:{
               KoiNumber:this.keyWords
             }
          }).then((res) => {
            if (res.data.Code == 200) {
               this.isShowSearch = true;

               this.formData = res.data.Data;

               this.$message({
                  message: '查找成功！',
                  type: 'success'
                });

            }else {
               this.$message({
                  message: res.data.Description,
                  type: 'error'
                });
             }
          })
       },
       

     },
     mounted() {
        this.setWindow();
        window.onresize = ()=>{
           this.setWindow();
        }
     },
     watch:{
      'keyWords':function(nv) {
         if(nv === '')  this.isShowSearch = false;
      }
     }
   }
</script>
<style lang="css" scoped>
    .add-exp-form {
      margin: 0 auto;
      width: 90%;
    }

    .exp-content {
      margin: 30px auto;
      width: 90%;
      height: 300px;
      border: 1px solid #337ab7;
    }
</style>

