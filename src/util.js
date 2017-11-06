export default {
  install(Vue, options) {
      /**
       * [renderActionType 渲染操作类型列]
       * @Author   罗文
       * @DateTime 2017-10-26
       * @return   {[type]}   [description]
       */
    Vue.prototype.renderActionType = function(ActionType) {
        switch (ActionType) {
          case 1:
            return '新增'
            break;
          case 2:
            return '修改'
            break;
          case 3:
            return '一审通过'
            break;
          case 4:
            return '一审驳回'
            break;
          case 5:
            return '二审通过'
            break;
          case 6:
            return '二审驳回'
            break;        
          default:
            return '未知'
            break;
        }
    };


     /**
       * [renderType 渲染知识元类型列]
       * @Author   罗文
       * @DateTime 2017-10-26
       * @return   {[type]}   [description]
       */
    Vue.prototype.renderType = function(ObjectType) {
        switch (ObjectType) {
          case 1:
            return '知识元'
            break;
          case 2:
            return '知识簇'
            break;
          case 3:
            return '知识链'
            break;     
          default:
            return '未知'
            break;
        }
    };
  }
}
