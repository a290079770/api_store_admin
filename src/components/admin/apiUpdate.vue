<template>
  <div class="index-cont" :style="{height:winHeight +'px',width: '92%',margin:'30px auto'}">
     <div class="table-page-title">
       <h3>
         修改API
       </h3>
       <span class="yellow-place"></span>
     </div>
     <div class="add-exp-form">
        <el-form :model="form" style="width:94%;" :label-width="formLabelWidth" :rules="formRules" ref="apiDetail">

          <el-form-item label="API名称" prop="Title">
            <el-input v-model="form.Title" placeholder="请输入名称" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="中文说明" prop="ApiTitle">
            <el-input v-model="form.ApiTitle" placeholder="请输入中文说明" auto-complete="off"></el-input>
          </el-form-item>

          <el-form-item label="所属分类" prop="CateId">
             <el-select :disabled="isAddCateInputShow" v-model="form.CateId" placeholder="请选择">
                <el-option
                  v-for="(item,index) in categoryList"
                  :key="index"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>

              <i class="el-icon-circle-plus-outline api-add-icon" v-show="!isAddCateInputShow" @click="isAddCateInputShow = true"></i>

              <el-input v-model="addCateInput" placeholder="请输入中文说明" auto-complete="off" style="width:20%" v-show="isAddCateInputShow"></el-input>

              <i class="el-icon-circle-check api-add-icon" v-show="isAddCateInputShow" @click="addCategory"></i>

              <i class="el-icon-circle-close api-add-icon close-param" v-show="isAddCateInputShow" @click="addCateInput = '';isAddCateInputShow = false;"></i>
          </el-form-item>

          <el-form-item label="请求方式" prop="Methods">
            <el-radio v-model="form.Methods" label="GET" border>GET</el-radio>
            <el-radio v-model="form.Methods" label="POST" border>POST</el-radio>
          </el-form-item>

          <el-form-item label="输入参数">
            <el-button type="primary" plain @click="addParams(1)">新增</el-button>
          </el-form-item>

       
         <!-- 参数 -->
         <el-form-item :label="'参数 ' + (index + 1) " :key="index +'input'" v-for="(item,index) in form.InputParams">
             <el-row>
                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.Title" placeholder="参数名" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="5" style="margin-right:4px">
                  <el-input v-model="item.Description" placeholder="描述" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.Type" placeholder="类型" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.Default" placeholder="默认值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.Test" placeholder="测试值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-checkbox v-model="item.IsNecessary">是否必须</el-checkbox>
                </el-col>

                <el-col :span="1" class="close-param">
                  <i class="el-icon-circle-close" @click="removeParams(1,index)"></i>
                </el-col>
            </el-row>
          </el-form-item>


          <el-form-item label="输入参数">
            <el-button type="primary" plain @click="addParams(2)">新增</el-button>
          </el-form-item>

       
         <!-- 参数 -->
         <el-form-item :label="'参数 ' + (index + 1) " :key="index +'output'" v-for="(item,index) in form.OutputParams">
             <el-row>
                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.Title" placeholder="参数名" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="5" style="margin-right:4px">
                  <el-input v-model="item.Description" placeholder="描述" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-input v-model="item.Type" placeholder="类型" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.Default" placeholder="默认值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="4" style="margin-right:4px">
                  <el-input v-model="item.Test" placeholder="测试值" auto-complete="off"></el-input>
                </el-col>

                <el-col :span="3" style="margin-right:4px">
                  <el-checkbox v-model="item.IsNecessary">是否必须</el-checkbox>
                </el-col>

                <el-col :span="1" class="close-param">
                  <i class="el-icon-circle-close" @click="removeParams(2,index)"></i>
                </el-col>
            </el-row>
          </el-form-item>


          <el-form-item label="描述">
            <el-input 
            v-model="form.Description" 
            placeholder="请输入描述" 
            type="textarea" 
            auto-complete="off"
            rows="2"
            ></el-input>
          </el-form-item> 

<!--           <el-form-item label="返回数据结构">
            <el-input 
            v-model="form.description" 
            placeholder="请输入返回的数据结构" 
            type="textarea" 
            auto-complete="off"
            rows="4"
            ></el-input>
          </el-form-item>  -->


          <el-form-item>
             <el-button type="primary" @click="createOrUpdate">确认</el-button>
             <el-button @click="$router.go(-1)">返回</el-button>
          </el-form-item>


        </el-form>

    </div>

  </div>
</template>

<script>
   export default {
     data(){
      function checkApiTitle(rule, value, callback){
        let reg = /[^a-zA-Z0-9_/]/g;
        if (reg.test(value)) {
          callback(new Error('不能存在特殊字符，只能是英文字符、_、/等！'))
        } else {
          callback();
        }
      }

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

           formRules:{
              Title:[
                {required:true,message:'api接口名不能为空！',trigger: 'blur'},
                { validator: checkApiTitle, trigger: 'blur' }
              ],
              Methods:[
                {required:true,message:'请选择请求方式！',trigger: 'blur'},
              ],
              ApiTitle:[
                {required:true,message:'api中文名不能为空！',trigger: 'blur'},
              ],
              CateId:[
                {type:'number',required:true,message:'请选择api所属的分类！',trigger: 'blur'},
              ],
           },

           formLabelWidth: '120px',

           categoryList:[],
           isAddCateInputShow:false,
           addCateInput:'',
           newCateId:null,

        }
     },
     methods:{
       /**
        * [getDataList 获取分类列表]
        * @Author   罗文
        * @DateTime 2018-04-12
        * @param    {Boolean}  isUpdatedList [是否是更新分类列表，如果是，需要选中刚添加的那个分类]
        * @return   {[type]}                 [description]
        */
       getDataList(isUpdatedList = false) {
          this.$http.get('/category/cateList',{
            params:{
              ps:999,
              ProductId:this.$route.query.proId,
            }
          })
          .then((res)=>{
              if(res.data.code == 200) {
                  //永久存储用于记录密码
                  this.categoryList = res.data.data.map((item)=>{
                     if(isUpdatedList && item.Id == this.newCateId) this.form.CateId =  +this.newCateId;

                     return Object.assign({},{
                       label:item.Title,
                       value:item.Id,
                     })
                  })

                  this.getDetail();
              }else {
                  this.$message.error(res.data.description);
              }
          })
       },
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
              }else {
                  this.$message.error(res.data.description);
              }
          })
       },
       /**
        * [create 新增api]
        * @Author   罗文
        * @DateTime 2018-04-16
        * @return   {[type]}   [description]
        */
       createOrUpdate() {
         this.$refs['apiDetail'].validate((valid) => {
          if (valid) {
             this.$http.post('/api/createOrUpdate',this.form)
            .then((res)=>{
                if(res.data.code == 200) {
                   this.$message.success(res.data.description);

                   setTimeout(()=>{
                      this.$router.push({
                        path:'/admin/apiList',
                        query:{
                          proId:this.$route.query.proId
                        }
                      })
                   }, 1000)   
                }else {
                   this.$message.error(res.data.description);
                }
            })
          }
        })  
         
       },

       /**
        * [addCategory 添加分类]
        * @Author   罗文
        * @DateTime 2018-04-12
        */
       addCategory() {
          if(!this.addCateInput || this.addCateInput.trim() == '' ) {
             this.$message.warning('请输入分类名！');
             return;
          }


          this.$http.post('/category/createOrUpdate',{
            ProductId:this.$route.query.proId,
            Title:this.addCateInput
          })
          .then((res)=>{
              if(res.data.code == 200) {
                this.$message.success('新增分类成功！');
                this.addCateInput = '';
                this.isAddCateInputShow = false;
                this.newCateId = res.data.data;

                this.getDataList(true);
              }else {
                this.$message.error(res.data.description);
              }
          })
       },

       /**
        * [addParams 新增参数]
        * @Author   罗文
        * @DateTime 2018-04-12
        * @param    {[Number]}   type [1 - 输入参数  2-输出参数]
        */
       addParams(type) {
          let newParams = {
              Title:'',
              Description:'',
              Type:'',
              Default:'',
              Test:'',
              IsNecessary:true,
              ApiId:this.$route.query.apiId
          }
 
          if(type == 1) {
            this.form.InputParams.push(newParams);
          }else {
            this.form.OutputParams.push(newParams);
          }
       },
       
       /**
        * [addParams 删除一个参数]
        * @Author   罗文
        * @DateTime 2018-04-12
        * @param    {[Number]}   type [1 - 输入参数  2-输出参数]
        * @param    {[Number]}   index [删除参数的索引]
        */
       removeParams(type,index) {
          if(type == 1) {
            this.form.InputParams.splice(index,1);
          }else {
            this.form.OutputParams.splice(index,1);
          }
       }

     },
     created() {
       this.getDataList();
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
      color:#ff4949 !important;
      font-size:24px;
      cursor: pointer;
    }

    .close-param:hover {
      color:red !important;
    }

    .api-add-icon {
      transform: translate(0,5px);
      font-size: 24px;
      cursor: pointer;
      color:#21b384;
    }

    .api-add-icon:hover {
      color:#13ce66;
    }
</style>

