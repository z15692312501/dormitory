<?php
namespace app\api\controller;
use think\Controller;
use think\Vendor;
use think\Db;
use app\common\model;
class Exceladd extends Controller{
	public function index(){
		if (request()->isPost()) {
    		Vendor('PHPExcel.PHPExcel');
    		Vendor('PHPExcel.PHPExcel.IOFactory');
    		$file = request()->file('excel');
    		if ($file) {
    			$file_types = explode(".", $_FILES ['excel'] ['name']); // ["name"] => string(25) "excel文件名.xls"
                $file_type = $file_types [count($file_types) - 1];//xls后缀
                $file_name = $file_types [count($file_types) - 2];//xls去后缀的文件名
                /*判别是不是.xls文件，判别是不是excel文件*/
                if (strtolower($file_type) != "xls" && strtolower($file_type) != "xlsx"){
                    echo '不是Excel文件，重新上传';
                    die;
                }
                $info = $file->move(ROOT_PATH . 'public' . DS . 'excel');//上传位置
                $path = ROOT_PATH . 'public' . DS . 'excel' . DS;
                $file_path = $path . $info->getSaveName();//上传后的EXCEL路径
                //echo $file_path;//文件路径
                //$objReader = \PHPExcel_IOFactory::createReader('Excel5');
                $objPHPExcel = \PHPExcel_IOFactory::load($file_path);
                $sheet = $objPHPExcel->getSheet(0);
                $highestRow = $sheet->getHighestRow(); // 取得总行数 
                $highestColumn = $sheet->getHighestColumn(); // 取得总列数
                $str = array();
                for($j=2;$j<=$highestRow;$j++){ 
                    for($k='A';$k<=$highestColumn;$k++){ 
                        $str[]= iconv("utf-8","utf-8",$objPHPExcel->getActiveSheet()->getCell("$k$j")->getValue());//读取单元格
                    }
                    $sql = "INSERT INTO ts_student (stuid,stuname,sex,idcard,birthday,phone,place,address,department,major,class,job,fdid,motherphone,fatherphone) VALUES('".$str[0]."','".$str[1]."','".$str[2]."','".$str[3]."','".$str[4]."','".$str[5]."','".$str[6]."','".$str[7]."','".$str[8]."','".$str[9]."','".$str[10]."','".$str[11]."','".$str[12]."','".$str[13]."','".$str[14]."')";
                    echo $sql.'<br/>';
                    //Db::query($sql);
                    $str = array();
                }
    		}
    	}
	}


    public function banji(){
        if (request()->isPost()) {
            Vendor('PHPExcel.PHPExcel');
            Vendor('PHPExcel.PHPExcel.IOFactory');
            $file = request()->file('excel');
            if ($file) {
                $file_types = explode(".", $_FILES ['excel'] ['name']); // ["name"] => string(25) "excel文件名.xls"
                $file_type = $file_types [count($file_types) - 1];//xls后缀
                $file_name = $file_types [count($file_types) - 2];//xls去后缀的文件名
                /*判别是不是.xls文件，判别是不是excel文件*/
                if (strtolower($file_type) != "xls" && strtolower($file_type) != "xlsx"){
                    echo '不是Excel文件，重新上传';
                    die;
                }
                $info = $file->move(ROOT_PATH . 'public' . DS . 'excel');//上传位置
                $path = ROOT_PATH . 'public' . DS . 'excel' . DS;
                $file_path = $path . $info->getSaveName();//上传后的EXCEL路径
                //echo $file_path;//文件路径
                //$objReader = \PHPExcel_IOFactory::createReader('Excel5');

                $objPHPExcel = \PHPExcel_IOFactory::load($file_path);
                $sheet = $objPHPExcel->getSheet(0);
                $highestRow = $sheet->getHighestRow(); // 取得总行数 
                $highestColumn = $sheet->getHighestColumn(); // 取得总列数
                echo $highestRow;
                $str = array();
                for($j=2;$j<=$highestRow;$j++){ 
                    for($k='A';$k<=$highestColumn;$k++){ 
                        $str[]= iconv("utf-8","utf-8",$objPHPExcel->getActiveSheet()->getCell("$k$j")->getValue());//读取单元格
                    }
                    $sql = "INSERT INTO ts_grade (class_name,fd_id,department_id) VALUES('".$str[0]."','".$str[1]."','".$str[2]."')";
                    echo $sql.'<br/>';
                    Db::query($sql);
                    $str = array();
                }
            }
        }
    }

    public function studentOut(){
	    $num = 0;
        $renNum = 0;
        if (!request()->isPost()){
            Vendor('PHPExcel.PHPExcel');
            Vendor('PHPExcel.PHPExcel.IOFactory');
            $student = new model\Student();
            $Data = $student->findlstss();
            //dump($Data);
            $objPhpexcle = new \PHPExcel();
            $objPhpexcle->getProperties()->setCreator("作者张圣恩")
                ->setLastModifiedBy("最后更改者")
                ->setTitle("文档标题")
                ->setSubject("文档主题")
                ->setDescription("文档的描述信息")
                ->setKeywords("设置文档关键词")
                ->setCategory("设置文档的分类");

            for ($j=2;$j<count($Data);$j++){
                $objPhpexcle->setActiveSheetIndex(0)
                    ->setCellValue('A'.$j,$Data[$renNum]['id'])
                    ->setCellValue('B'.$j,$Data[$renNum]['student_id'])
                    ->setCellValue('C'.$j,$Data[$renNum]['student_cardid'])
                    ->setCellValue('D'.$j,$Data[$renNum]['student_sex'])
                    ->setCellValue('E'.$j,$Data[$renNum]['student_name'])
                    ->setCellValue('F'.$j,$Data[$renNum]['studentx_id'])
                    ->setCellValue('G'.$j,$Data[$renNum]['xxstudent_birthday'])
                    ->setCellValue('H'.$j,$Data[$renNum]['xxstudent_phone'])
                    ->setCellValue('I'.$j,$Data[$renNum]['xxstudent_place'])
                    ->setCellValue('J'.$j,$Data[$renNum]['xxstudent_addres'])
                    ->setCellValue('K'.$j,$Data[$renNum]['xxstudent_major'])
                    ->setCellValue('L'.$j,$Data[$renNum]['xxstudent_job'])
                    ->setCellValue('M'.$j,$Data[$renNum]['xxstudent_fphone'])
                    ->setCellValue('N'.$j,$Data[$renNum]['xxstudent_mphone'])
                    ->setCellValue('O'.$j,$Data[$renNum]['xxdepartment_id'])
                    ->setCellValue('P'.$j,$Data[$renNum]['fd_id'])
                    ->setCellValue('Q'.$j,$Data[$renNum]['class_id'])
                    ->setCellValue('R'.$j,$Data[$renNum]['xxstudent_qq'])
                    ->setCellValue('S'.$j,$Data[$renNum]['department_name'])
                    ->setCellValue('T'.$j,$Data[$renNum]['fd_name'])
                    ->setCellValue('U'.$j,$Data[$renNum]['class_name']);
                $renNum++;
            }
            echo 1;
            $objWriter = \PHPExcel_IOFactory::createWriter($objPhpexcle, 'Excel5');
            $objWriter->save('export.xls');


        }
    }
}