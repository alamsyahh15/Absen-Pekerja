<?php 
	function getAbsen(){
		$idUser = $this->input->post('iduser');
		// $date_now = date('Y-m-d');
		$date = new DateTime('2020-07-27');
		$date_now = $date->format('Y-m-d');
		$hasIdUser = $idUser != null || $idUser != "";
		$sql = "SELECT A.*, tb_absen.id_absen, tb_absen.check_in, tb_absen.check_out, tb_absen.place FROM (
			SELECT tb_user.*, tb_role.name_role FROM tb_user
			left JOIN tb_role ON tb_user.role_id = tb_role.id_role ". ((!$hasIdUser) ? "" : "WHERE tb_user.id_user = ?") .") as A
			LEFT JOIN tb_absen ON A.id_user = tb_absen.id_user AND tb_absen.date_today = '$date_now'";

	        $query = $this->db->get('tb_user');
	        // $q = $this->db->query($sql, array($idUser));
	        // $data = $q->result();



	    if($idUser != null || $idUser != ""){
	    	$query = $this->db->query($sql, array($idUser));
	    	if($query -> num_rows() > 0){
	    		$data['message'] = "Successfully Get Data Absent With Id";
	    		$data['status'] = 200;
	    		$data['absent'] = $query->result();
	                // $data = $query->result();
	        }else{
	        	$data['message'] = "Failed Get Data News";
	        	$data['status'] = 400;
	        }
	    } else {
	    	$q = $this->db->query($sql);
	    	
	    	if($q -> num_rows() > 0){
	    	 $data['message'] = "Successfully Get Data Absent Without Id";
	    	 $data['status'] = 200;
	    	 $data['totalData'] = $q -> num_rows();
	    	 $data['absent'] = $q->result();
	    	}else{
	    		$data['message'] = "Failed Get Data Absent";
	    		$data['status'] = 400;  

	    	}
	    }
	    echo json_encode($data);
	}

?>