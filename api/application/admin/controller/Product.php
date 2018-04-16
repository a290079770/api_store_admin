<?php
namespace app\admin\controller;
use think\Controller;
use think\request;
use think\Db;

use think\Validate;

use lib\response;
class Product extends Controller
{   
    private $response = null;
    private $valid = [
        'Title'=>'chsAlphaNum',
    ];
    private $error = array(
                            0 => '请求方式错误！',
                            1 => '产品名称不能为空！',
                            2 => '服务名不能为空！',
                            3 => '产品描述不能为空！',
                            4 => '产品地址不能为空',
                            5 => '日期不能为空！',
                            6 => '产品名称不能含有非法字符！',
                            7 => '分类ID不正确，没有这个分类！',
                            8 => '新增成功！',
                            9 => '新增失败！',
                            10 => '修改成功！',
                            11 => '修改失败！',
                            12 => '删除失败！',
                            13 => '删除成功！',
                            14 => '产品ID不正确，没有这个产品！',
                          );
    public function __construct() {
       $this->response = new Response();
    }
    //获取分类列表
    public function productList()
    {
        $keywords = request()->get('keywords') ? request()->get('keywords') : '';
        $cp = request()->get('cp') ? request()->get('cp') : 1;
        $ps = request()->get('ps') ? request()->get('ps') : 20;

        $arr = array();

         $arr = Db::name('products')
             ->where('Title','like','%'.$keywords.'%')
             ->order('CreateTime','desc')
             ->page($cp,$ps)
             ->select();

         //统计数
         $count = Db::name('products')
             ->where('Title','like','%'.$keywords.'%')
             ->count();    

         $this->response->setResponse(200,'ok',$arr,$count);
    }

    //新增或修改分类
    public function createOrUpdate()
    {
        //参数 Id Title Description Url CreateTime
        //必须post访问
        if(request()->isGet()) {
          $this->response->setResponse(21,$this->error[0]);
          return;
        }

        //先迅速验证必填字段
        if(!request()->post('Title')) {
          $this->response->setResponse(21,$this->error[1]);
          return;
        }else if(!request()->post('Description')) {
          $this->response->setResponse(21,$this->error[3]);
          return;
        }else if(!request()->post('Url')) {
          $this->response->setResponse(21,$this->error[4]);
          return;
        }

        $va = new Validate($this->valid);

        //验证产品名
        if(!$va->check(request()->post('Title'))) {
          $this->response->setResponse(21,$this->error[6]);
          return;
        }

        $arr = request()->post();

        if(!isset($arr['CreateTime'])) {
           $arr['CreateTime'] = date('Y-m-d H:i:s',time());
        } 


        //判断有没有传入产品ID，如果有则修改，没有则新增
        if(!request()->post('Id')) {
          //新增操作
             $res = Db::name('products')->insert($arr);

             if($res == 1) {
                $Id = Db::name('products')->getLastInsID();
                $this->response->setResponse(200,$this->error[8],$Id);
             }else {
                $this->response->setResponse(21,$this->error[9]);
             }
        }else {
          //修改操作
             $res = Db::name('products')->where('Id',request()->post('Id'))->update($arr);

             if($res !== 0) {
                $this->response->setResponse(200,$this->error[10]);
             }else {
                $this->response->setResponse(21,$this->error[11]);
             }
        }
    }

    //删除一个分类
    public function delete() 
    {
        //参数 Id
        //必须post访问
        if(request()->isGet()) {
          $this->response->setResponse(21,$this->error[0]);
          return;
        }

        //根据Id删除7
        if(!request()->post('Id')) {
           $this->response->setResponse(21,'产品ID不能为空！');
           return;
        }

        $res = Db::name('products')->where('id',request()->post('Id'))->delete();

        if($res == 0 ) {
           $this->response->setResponse(21,$this->error[12]);
        }else {
           $this->response->setResponse(200,$this->error[13]);
        }
    }


    //获取产品详情
    public function detail() {
        //根据Id查询
        if(!request()->get('Id') && !request()->post('Id')) {
           $this->response->setResponse(21,'产品ID不能为空！');
           return;
        }

        $Id = request()->get('Id') ? request()->get('Id') : request()->post('Id');

        $res = Db::name('products')->where('Id',$Id)->select();

        if(count($res) == 0) {
           $this->response->setResponse(21,$this->error[14]);
        }else {
           $this->response->setResponse(200,'ok',$res[0]);
        }
    }


    //获取首页产品列表及图片
    public function getIndexProductsList() {
        //必须get访问
        if(request()->isPost()) {
          $this->response->setResponse(21,$this->error[0]);
          return;
        }


        $res = Db::name('products')->where('isPublic',1)->select();

        if(count($res) !== 0) {
          //依次找出对应的小图
          foreach ($res as $k => $v) {
             $res[$k]['coverImg'] = Db::name('images')
                                 ->where('pid',$v['id'])
                                 ->where('type',3)
                                 ->select();
          }
        }

        $this->response->setResponse(200,'ok',$res);
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
