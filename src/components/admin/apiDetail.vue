<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
     <div class="table-page-title">
       <h3>
         {{form.ApiTitle}} / <span class="apilist-product-title">{{product.Title}}</span> / <span style="cursor:pointer" class="apilist-product-title" @click="$router.go(-1)">返回</span>
       </h3>
       <span class="yellow-place"></span>
     </div>
     <div class="add-exp-form">
        <el-form :model="form" style="width:94%;" :label-width="formLabelWidth">

          <el-form-item label="API名称：" >
             <span class="detail-green">{{form.Title}}</span>
          </el-form-item>

          <el-form-item label="API名称：" >
             <span class="detail-green">{{form.ApiTitle}}</span>
          </el-form-item>

          <el-form-item label="请求方式：">
            <el-radio v-model="form.Methods" :disabled="form.Methods == 'POST'" label="GET" border>GET</el-radio>
            <el-radio v-model="form.Methods" :disabled="form.Methods == 'GET'" label="POST" border>POST</el-radio>
          </el-form-item>

<!--           <el-form-item label="系统参数：">
            <el-checkbox v-model="form.needSys">需要系统参数</el-checkbox>
          </el-form-item> -->

<!--           <el-form-item label="签名状态：">
            <el-checkbox v-model="form.needToken">需要签名</el-checkbox>
          </el-form-item> -->

          <el-form-item label="输入参数：">
              <el-table
                :data="form.InputParams"
                :border="true"
                >
                <el-table-column
                  prop="Title"
                  label="名称"
                  >
                </el-table-column>

                <el-table-column
                  prop="Description"
                  label="说明"
                  >
                </el-table-column>

                <el-table-column
                  prop="Type"
                  label="类型"
                  >
                </el-table-column>

                <el-table-column
                  label="是否必须"
                  >
                  <template slot-scope="scope">
                     {{scope.row.IsNecessary ? '是':'否'}}
                  </template>
                </el-table-column>
                <el-table-column
                  prop="Default"
                  label="默认值">
                </el-table-column>
              </el-table>
          </el-form-item>


          <el-form-item label="输出参数：">
              <el-table
                :data="form.OutputParams"
                style="width: 100%"
                :border="true"
                :stripe="true"
                >
                <el-table-column
                  prop="Title"
                  label="名称"
                  width="250px"
                  >
                </el-table-column>

                <el-table-column
                  prop="Type"
                  label="类型"
                  width="250px"
                  >
                </el-table-column>

                <el-table-column
                  prop="Description"
                  label="说明"
                  >
                </el-table-column>

              </el-table>
          </el-form-item>

          <el-form-item label="URL调用示例：">
            <a class="detail-green" target="_blank" :href="requestUrl">{{requestUrl}}</a>
          </el-form-item>

<!--           <el-form-item label="描述：">
            {{form.Description}}
          </el-form-item> -->
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
           form: {
              Id:this.$route.query.apiId,
              Title:'',
              Description:'',
              ApiTitle:'',
              CateId:'',
              Methods:'GET',
              InputParams:[],
              OutputParams:[],
              ProductId:this.$route.query.proId
           },

           product:{},
           formLabelWidth: '150px',
           requestUrl:'',

        }
     },
     methods:{
       /**
        * [getDetail 获取api详情]
        * @Author   罗文
        * @DateTime 2018-04-17
        * @return   {[type]}   [description]
        */
       getDetail() {
         this.$http.get('/api/detail',{
            params:{
              ApiId:this.$route.query.apiId
            }
          })
          .then((res)=>{
              if(res.data.code == 200) {
                  res.data.data.InputParams = res.data.data.InputParams.map((item)=>{
                     item.IsNecessary = item.IsNecessary === 0 ? false : true;
                     return item;
                  })

                  res.data.data.OutputParams = res.data.data.OutputParams.map((item)=>{
                     item.IsNecessary = item.IsNecessary === 0 ? false : true;
                     return item;
                  })

                  this.form = res.data.data;

                  this.getProduct();
              }else {
                  this.$message.error(res.data.description);
              }
          })
       },

       getProduct() {
          this.$http.get('/product/detail',{
            params:{
              Id:this.$route.query.proId
            }
          })
          .then((res)=>{
              if(res.data.code == 200) {
                this.product = res.data.data;

                //设置调用url链接
                if(this.form.Methods == 'GET') {
                   let queryStr = '';

                   this.form.InputParams.forEach((item,index)=>{
                      queryStr += item.Title + '=' + item.Test + '&' ;
                   })

                   this.requestUrl = 'http://'+this.product.Url + this.form.Title + '?'+queryStr.slice(0,-1);
                }else this.requestUrl = 'http://'+this.product.Url + this.form.Title;
              }else {
                this.$message.error(res.data.description);
              }
          })
       }

     },
     created() {
       this.getDetail();
     },
     mounted() {

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

    .detail-green {
      color:#13ce66;
    }
</style>

