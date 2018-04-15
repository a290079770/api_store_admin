<?php
namespace app\admin\controller;
use think\Controller;
use think\request;
use think\Db;
use think\Validate;

class Category extends Controller
{
    private $Title = [
        'Title'=>'chsAlphaNum'
    ];
    //获取分类列表
    public function cateList()
    { 
         //验证必填项-所属产品
        if(!request()->get('ProductId')) {
          $this->setResponse(21,'所属产品编号为空！');
          return;
        }

        $keywords = request()->get('keywords') ? request()->get('keywords') : '';
        $cp = request()->get('cp') ? request()->get('cp') : 1;
        $ps = request()->get('ps') ? request()->get('ps') : 20;

        $arr = Db::name('category')
               ->where('Title','like','%'.$keywords.'%')
               ->where('ProductId',request()->get('ProductId'))
               ->order('Id','desc')
               ->page($cp,$ps)
               ->select();
        //统计数
        $count = Db::name('category')
                 ->where('Title','like','%'.$keywords.'%')
                 ->where('ProductId',request()->get('ProductId'))
                 ->count();      
        $this->setResponse(200,'ok',$arr,$count);
    }

    //新增或修改分类
    public function createOrUpdate() 
    {
        //参数  Title cateEngName  cateId
        //必须post访问
        if(request()->isGet()) {
          $this->setResponse(21,'请求方式错误！');
          return;
        }

        //验证分类名
        if(!request()->post('Title')) {
          $this->setResponse(21,'分类名不能为空！');
          return;
        }

        //验证分类名
        if(!request()->post('ProductId')) {
          $this->setResponse(21,'所属产品编号为空！');
          return;
        }

        $va = new Validate($this->Title);

        //不能有非法字符
        if(!$va->check(request()->post('Title')) ) {
           //验证手机号
           $this->setResponse(21,'分类名不能有非法字符！');
           return false;
        }

        //判断有没有传入分类ID，如果有则修改，没有则新增
        if(!request()->post('Id')) {
          //新增操作
             $arr = array(
               'Title'=>request()->post('Title'),
               'ProductId'=>request()->post('ProductId'),
             );
             $res = Db::name('category')->insert($arr);

             if($res == 1) {
                $cateId = Db::name('category')->getLastInsID();
                $this->setResponse(200,'新增成功！',$cateId);
             }else {
                $this->setResponse(21,'新增失败！');
             }
        }else {
          //修改操作
             $arr = array(
               'Title'=>request()->post('Title'),
               'ProductId'=>request()->post('ProductId'),
               'Id'=>request()->post('Id'),
             );
             $res = Db::name('category')->where('Id',request()->post('Id'))->update($arr);

             if($res !== 0) {
                $this->setResponse(200,'修改成功！');
             }else {
                $this->setResponse(21,'修改失败！');
             }
        }
    }

    //删除一个分类
    public function delete() 
    {
        //必须post访问
        if(request()->isGet()) {
          $this->setResponse(21,'请求方式错误！');
          return;
        }

        //根据cateId删除
        if(!request()->post('cateId')) {
           $this->setResponse(21,'分类编号不能为空！');
           return;
        }

        $res = Db::name('category')->where('id',request()->post('cateId'))->delete();

        if($res == 0) {
           $this->setResponse(21,'删除失败！');
        }else {
           $this->setResponse(200,'删除成功！');
        }
    }


    //返回数据
    private function setResponse($code,$description,$data='',$recordCount=0) 
    {
        $res = array();
        switch ($code) {
            case 21:
                $res = array(
                   'code'=>$code,
                   'success'=>false,
                   'description'=>$description
                );
                break;
            case 200:
                $res = array(
                     'code'=>$code,
                     'success'=>true,
                     'description'=>$description,
                     'data'=>$data,
                  );
                if(is_array($data)) {
                  $res['recordCount'] = $recordCount;
                }
                
                break;
            
            default:
                # code...
                break;
        }

        print_r(json_encode($res,JSON_UNESCAPED_UNICODE ));
    }

}
