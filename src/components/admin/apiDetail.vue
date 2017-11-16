<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
     <div class="table-page-title">
       <h3>
         新增API / <span class="apilist-product-title">KOI知识关系生成工具</span>
       </h3>
       <span class="yellow-place"></span>
     </div>
     <div class="add-exp-form">
        <el-form :model="form" style="width:94%;" :label-width="formLabelWidth">

          <el-form-item label="API名称" >
            <el-input v-model="form.title" placeholder="请输入名称" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="中文说明">
            <el-input v-model="form.description" placeholder="请输入中文说明" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="所属分类">
            <el-input v-model="form.category" placeholder="请输入描述分类" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="请求方式">
            <el-radio v-model="form.method" label="1" border>GET</el-radio>
            <el-radio v-model="form.method" label="2" border>POST</el-radio>
          </el-form-item>

          <el-form-item label="输入参数">
            <el-button type="primary" plain>新增</el-button>
          </el-form-item>

       
         <!-- 参数 -->
         <el-form-item :label="'参数 ' + (index + 1) " v-for="(item,index) in params">
             <el-row>
                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.title" placeholder="参数名" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="5" style="margin-right:4px">
                  <el-input v-model="item.desc" placeholder="描述" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.type" placeholder="类型" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.default" placeholder="默认值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.test" placeholder="测试值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-checkbox v-model="item.isNecessary">是否必须</el-checkbox>
                </el-col>

                <el-col :span="1" class="close-param">
                  <i class="el-icon-circle-close"></i>
                </el-col>
            </el-row>
          </el-form-item>

          <el-form-item label="科学名称">
            <el-input v-model="form.ScientificName" placeholder="请输入科学名称" type="input" auto-complete="off"></el-input>
          </el-form-item> 


           <el-form-item label="知识关系图" v-if="ExpTypeNum !== 1">
             <div ref="explicitWordSet" class="exp-content">
              
             </div>
           </el-form-item>

        </el-form>

    </div>

  </div>
</template>

<script>
   export default {
     data(){
      return {
           winWidth:window.innerWidth,
           winHeight:window.innerHeight,
           toolsShow:false,
           form: {
              title: '钢筋混泥土加固',
              category: '科学',
              description:'',
              method:'1',
              
           },
           params:[
              {
                title:'',
                desc:'',
                type:'',
                default:'',
                test:'',
                isNecessary:false,
              },
              {
                title:'',
                desc:'',
                type:'',
                default:'',
                test:'',
                isNecessary:false,
              }
           ],
           ExpType:'知识元',
           ExpTypeNum:1,
           formLabelWidth: '80px',
           isShowSearch:false,
           keyWords:'',

        }
     },
     methods:{
       /**
        * [renderForm 渲染搜索结果]
        * @Author   罗文
        * @DateTime 2017-10-26
        * @param    {[Object]}   data [表单数据]
        * @return   {[type]}        [description]
        */
       renderForm(data) {
           if(data.ExplicitWord) {
              this.renderByExplicitWord(data);
              this.ExpType = '知识元';
              this.ExpTypeNum = 1;
           }else if(data.ExplicitWordSet) {
              this.ExpType = '知识簇';
              this.ExpTypeNum = 2;
              this.renderByExplicitWordSet(data);
           }else if(data.ExplicitWordChain) {
              this.ExpType = '知识链';
              this.ExpTypeNum = 3;
              this.renderByExplicitWordChain(data);
           }
       },


     },
     mounted() {
        this.setWindow(window.innerWidth,window.innerHeight);
        window.onresize = ()=>{
           this.setWindow(window.innerWidth,window.innerHeight);
        }

        this.renderForm(this.formData);
     },
   }
</script>
<style lang="css" scoped>
    .add-exp-form {
      margin: 30px auto;
      width: 90%;
    }

    .exp-content {
      margin: 30px auto;
      width: 90%;
      height: 300px;
      border: 1px solid #337ab7;
    }

    .close-param {
      margin-right:4px;
      color:red;
      font-size:24px;
      cursor: pointer;
    }
</style>

