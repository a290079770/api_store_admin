webpackJsonp([8],{557:function(t,e,a){a(601);var r=a(221)(a(570),a(617),"data-v-4ce18be4",null);t.exports=r.exports},570:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default={data:function(){return{winWidth:window.innerWidth,winHeight:window.innerHeight,form:{Id:this.$route.query.apiId,Title:"",Description:"",ApiTitle:"",CateId:"",Methods:"GET",InputParams:[],OutputParams:[],ProductId:this.$route.query.proId},product:{},formLabelWidth:"150px"}},methods:{getDetail:function(){var t=this;this.$http.get("/api/detail",{params:{ApiId:this.$route.query.apiId}}).then(function(e){200==e.data.code?(e.data.data.InputParams=e.data.data.InputParams.map(function(t){return t.IsNecessary=0!==t.IsNecessary,t}),e.data.data.OutputParams=e.data.data.OutputParams.map(function(t){return t.IsNecessary=0!==t.IsNecessary,t}),t.form=e.data.data):t.$message.error(e.data.description)})},getProduct:function(){var t=this;this.$http.get("/product/detail",{params:{Id:this.$route.query.proId}}).then(function(e){200==e.data.code?t.product=e.data.data:t.$message.error(e.data.description)})}},created:function(){this.getDetail(),this.getProduct()},mounted:function(){}}},589:function(t,e,a){e=t.exports=a(553)(!1),e.push([t.i,".add-exp-form[data-v-4ce18be4]{margin:30px auto;width:90%}.exp-content[data-v-4ce18be4]{margin:30px auto;width:90%;height:300px;border:1px solid #337ab7}.close-param[data-v-4ce18be4]{margin-right:4px;color:red;font-size:24px;cursor:pointer}.detail-green[data-v-4ce18be4]{color:#13ce66}",""])},601:function(t,e,a){var r=a(589);"string"==typeof r&&(r=[[t.i,r,""]]),r.locals&&(t.exports=r.locals);a(554)("3de82efe",r,!0)},617:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",{staticClass:"index-cont",style:{height:t.winHeight+"px",width:"92%",margin:"30px auto"}},[a("div",{staticClass:"table-page-title"},[a("h3",[t._v("\n         "+t._s(t.form.ApiTitle)+" / "),a("span",{staticClass:"apilist-product-title"},[t._v(t._s(t.product.Title))]),t._v(" / "),a("span",{staticClass:"apilist-product-title",staticStyle:{cursor:"pointer"},on:{click:function(e){t.$router.go(-1)}}},[t._v("返回")])]),t._v(" "),a("span",{staticClass:"yellow-place"})]),t._v(" "),a("div",{staticClass:"add-exp-form"},[a("el-form",{staticStyle:{width:"94%"},attrs:{model:t.form,"label-width":t.formLabelWidth}},[a("el-form-item",{attrs:{label:"API名称："}},[a("span",{staticClass:"detail-green"},[t._v(t._s(t.form.Title))])]),t._v(" "),a("el-form-item",{attrs:{label:"API名称："}},[a("span",{staticClass:"detail-green"},[t._v(t._s(t.form.ApiTitle))])]),t._v(" "),a("el-form-item",{attrs:{label:"请求方式："}},[a("el-radio",{attrs:{label:"GET",border:""},model:{value:t.form.Methods,callback:function(e){t.$set(t.form,"Methods",e)},expression:"form.Methods"}},[t._v("GET")]),t._v(" "),a("el-radio",{attrs:{label:"POST",border:""},model:{value:t.form.Methods,callback:function(e){t.$set(t.form,"Methods",e)},expression:"form.Methods"}},[t._v("POST")])],1),t._v(" "),a("el-form-item",{attrs:{label:"输入参数："}},[a("el-table",{attrs:{data:t.form.InputParams,border:!0}},[a("el-table-column",{attrs:{prop:"Title",label:"名称"}}),t._v(" "),a("el-table-column",{attrs:{prop:"Description",label:"说明"}}),t._v(" "),a("el-table-column",{attrs:{prop:"Type",label:"类型"}}),t._v(" "),a("el-table-column",{attrs:{label:"是否必须"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v("\n                     "+t._s(e.row.IsNecessary?"是":"否")+"\n                  ")]}}])}),t._v(" "),a("el-table-column",{attrs:{prop:"Default",label:"默认值"}})],1)],1),t._v(" "),a("el-form-item",{attrs:{label:"输出参数："}},[a("el-table",{staticStyle:{width:"100%"},attrs:{data:t.form.OutputParams,border:!0,stripe:!0}},[a("el-table-column",{attrs:{prop:"Title",label:"名称"}}),t._v(" "),a("el-table-column",{attrs:{prop:"Description",label:"说明"}}),t._v(" "),a("el-table-column",{attrs:{prop:"Type",label:"类型"}}),t._v(" "),a("el-table-column",{attrs:{label:"是否必须"},scopedSlots:t._u([{key:"default",fn:function(e){return[t._v("\n                     "+t._s(e.row.IsNecessary?"是":"否")+"\n                  ")]}}])}),t._v(" "),a("el-table-column",{attrs:{prop:"Default",label:"默认值"}})],1)],1),t._v(" "),a("el-form-item",{attrs:{label:"URL调用示例："}},[a("a",{staticClass:"detail-green",attrs:{href:t.product.Url+t.form.Title}},[t._v(t._s(t.product.Url+t.form.Title))])]),t._v(" "),a("el-form-item",{attrs:{label:"描述："}},[t._v("\n            "+t._s(t.form.Description)+"\n          ")])],1)],1)])},staticRenderFns:[]}}});