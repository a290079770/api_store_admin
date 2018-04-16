<?php 
namespace lib;

class Response
{
    public function setResponse($code,$description,$data='',$recordCount=0) 
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

?>