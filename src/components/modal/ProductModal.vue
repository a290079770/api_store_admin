<template>
  <el-dialog
    :title="pid ? '修改产品信息':'新增产品'"
    :visible.sync="dialogVisible"
    top="20vh"
    width="60%"
    :show-close="false"
    @open="getProdDetail"
    @close="product = {}"
    >
    <el-form 
    label-position="right" 
    label-width="120px" 
    :model="product"
    :rules="productRules"
    ref="productModal"
    >
      <el-form-item label="产品名称" prop="Title">
        <el-input v-model="product.Title" placeholder="请输入产品名称" ></el-input>
      </el-form-item>

      <el-form-item label="产品描述" prop="Description">
        <el-input type="textarea" v-model="product.Description" placeholder="请输入产品描述" ></el-input>
      </el-form-item>

      <el-form-item label="产品地址" prop="Url">
        <el-input v-model="product.Url" placeholder="请输入产品地址" ></el-input>
      </el-form-item>

    </el-form>
    <span slot="footer" class="dialog-footer">
      <el-button type="primary" @click="createOrUpdateProduct">确 定</el-button>
      <el-button @click="closeDialog">取 消</el-button>
    </span>
  </el-dialog>
</template>

<script>
   export default {
     props:['dialogVisible','pid'],
     data(){
      return {
          product:{

          },
          productRules:{
            Title:[
              { required: true, message: '请输入产品名称', trigger: 'blur' },
            ],

            Description:[
              { required: true, message: '请输入产品描述', trigger: 'blur' },
            ],

            Url:[
              { required: true, message: '请输入产品地址', trigger: 'blur' },
            ],
          },
        }
     },

     methods:{
       /**
        * [getProdDetail 如果是修改产品信息，需要先获取产品详情]
        * @return {[type]} [description]
        */
       getProdDetail() {
          if(!this.pid) return;

          //获取产品详情
          this.$http.get('/product/detail',{
            params:{
              Id:this.pid
            }
          })
          .then((res)=>{
              if(res.data.code == 200) {
                  //永久存储用于记录密码
                  this.product = res.data.data;
              }else {
                  this.$message({
                    message: res.data.description,
                    type: 'error'
                  });
              }
          })
       },
       /**
        * [createOrUpdateProduct 新增或修改产品]
        * @return {[type]} [description]
        */
       createOrUpdateProduct() {
          this.$refs.productModal.validate((valid) => {
            if (valid) {
               this.$http.post('/product/createOrUpdate',this.product)
                .then((res)=>{
                    if(res.data.code == 200) {
                        //永久存储用于记录密码
                        this.$message({
                          message: this.pid ? '修改产品信息成功！':'新增产品成功！',
                          type: 'success'
                        });

                        this.closeDialog(true);
                    }else {
                        this.$message({
                          message: res.data.description,
                          type: 'error'
                        });
                    }
                })
            }
          })    
       },
       
       /**
        * [closeDialog 关闭弹出框]
        * @param  {[Boolean]} needUpdateList [是否更新产品列表]
        * @return {[type]}                [description]
        */
       closeDialog(needUpdateList = false) {
         this.$emit('closeDialog',needUpdateList);
       }
     },
   }
</script>
<style lang="css">
   .side-bar {
      background: rgb(238,241,236);
   }

   .el-table__body-wrapper {
      overflow: hidden !important;
   }
</style>

