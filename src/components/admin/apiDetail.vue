<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
     <div class="table-page-title">
       <h3>
         用户列表 / <span class="apilist-product-title">多维边疆</span> / <span class="apilist-product-title">返回</span>
       </h3>
       <span class="yellow-place"></span>
     </div>
     <div class="add-exp-form">
        <el-form :model="form" style="width:94%;" :label-width="formLabelWidth">

          <el-form-item label="API名称：" >
             <span class="detail-green">/ApplyLog/Pass</span>
          </el-form-item>

          <el-form-item label="API名称：" >
             <span class="detail-green">审核通过</span>
          </el-form-item>

          <el-form-item label="请求方式：">
            <el-radio v-model="form.method" label="1" border>GET</el-radio>
            <el-radio v-model="form.method" label="2" border>POST</el-radio>
          </el-form-item>

          <el-form-item label="系统参数：">
            <el-checkbox v-model="form.needSys">需要系统参数</el-checkbox>
          </el-form-item>

          <el-form-item label="签名状态：">
            <el-checkbox v-model="form.needToken">需要签名</el-checkbox>
          </el-form-item>

          <el-form-item label="输入参数：">
              <el-table
                :data="tableData"
                style="width: 100%"
                :border="true"
                :stripe="true"
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
                  label="必须"
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
                :data="tableData"
                style="width: 100%"
                :border="true"
                :stripe="true"
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
                  label="必须"
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

          <el-form-item label="URL调用示例：">
            <a class="detail-green" href="http://api.koi.kingchannels.cn//ApplyLog/Pass">http://api.koi.kingchannels.cn//ApplyLog/Pass</a>
          </el-form-item>

          <el-form-item label="返回数据结构：">
            <pre>
              {
                a:'zhangsan',
                b:'l4'
              }
            </pre>
          </el-form-item>

          <el-form-item label="描述：">
            通过审核的内容
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
           form: {
              title: '钢筋混泥土加固',
              category: '科学',
              description:'',
              method:'1',
              needSys:false,
              needToken:false,
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
           formLabelWidth: '150px',

           tableData: [{
              Title: '参数1',
              Description: '用户昵称',
              Type: 'String',
              IsNecessary: false,
              Default: ''
            },{
              Title: '参数1',
              Description: '用户昵称',
              Type: 'String',
              IsNecessary: false,
              Default: ''
            },{
              Title: '参数1',
              Description: '用户昵称',
              Type: 'String',
              IsNecessary: false,
              Default: ''
            },{
              Title: '参数1',
              Description: '用户昵称',
              Type: 'String',
              IsNecessary: false,
              Default: ''
            },]

        }
     },
     methods:{


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

