<?php

	class Api extends CI_Controller{
		
		function __construct(){
			parent:: __construct();
			date_default_timezone_set('Asia/Jakarta');
			error_reporting(E_ALL);
			ini_set('Display Error', 1);	
		}


		


		function updateProfile(){
			$update = array(
				'id_user' => $this->input->post('iduser'),
				'fullname_user' => $this->input->post('fullname'),
				'email_user' => $this->input->post('email'),
				'username_user' => $this->input->post('username'),
			);

			$this->db->where('id_user', $update['id_user']);
			$this->db->update('tb_user', $update);

			if($this->db->affected_rows() > 0){
				$data = array(
					'message' => 'Successfully Update '.$this->db->affected_rows().' User',
					'status' => 200,
					'dataUpdate' => $update,
				);
			}else{
				$data = array(
					'message' => 'Failed Update User',
					'status' => 404,
				);

			}
			echo json_encode($data);

		}



		function updatePhoto(){

			$idUser = $this->input->post('iduser');
			$config['upload_path'] = './image/';
			$config['allowed_types'] = 'gif|png|jpg|jpeg';

			
			$this->load->library('upload', $config);

			if(! $this->upload->do_upload('image')){
				$error = array('error' => $this->upload->display_errors());
				$data = array(
					'message' => $error, 
					'status' => 404,
				);
			}else{
				$this->db->where('id_user', $idUser);
				// upload to folder
				$tempData = array('upload_data' => $this->upload->data());
				
				// update to database
				$save['photo_user'] = $tempData['upload_data']['file_name'];
				$query = $this->db->update('tb_user', $save);
				$data = array(
					'message' => "Successfully update image", 
					'status' => 200,
					'data' => $tempData['upload_data'],
				);
				
			}
			echo json_encode($data);
		}



		function getHistory(){
			$idUser = $this->input->post('iduser');
			if($idUser != null){
				$this->db->where('id_user', $idUser);
				$q = $this->db->get('tb_absen');
				if($q -> num_rows() > 0){
					$data = array(
						'status' => 200,
						'message' => "Successfully get History with id .$idUser.",
						'dataHistory' =>  $q->result(),
					);
				}else{
					$data = array(
						'status' => 200,
						'message' => "Failde get History with id .$idUser.",
					);
				}

			}else{
				$data = array(
					'status' => 200,
					'message' => "Failde get History with id",
				);

			}
			echo json_encode($data);

		}
		
		function checkOut(){
			$update = array(
				'check_out' => date('Y-m-d  H:i:s'),
				'id_absen' => $this->input->post('id_absen'),
				'checkout_by' => $this->input->post('checkout_by'),
				'id_user' => $this->input->post('iduser'),
				'jam_kerja' => $this->input->post('jam_kerja'),
			);

			$this->db->where('id_absen', $update['id_absen']);
			$this->db->update('tb_absen', $update);

			if($this->db->affected_rows() > 0){
				$data  = array(
					'message' => 'Successfully Update '.$this->db->affected_rows().' User',
					'status' => 200,
					'checkout' => $update

				);
			}else{

				$data  = array(
					'message' => 'Failed Update User',
					'status' => 200,
					'checkout' => $update

				);
			}

			echo json_encode($data);
		}

		function checkIn(){
			$insert = array(
				'check_in' => date('Y-m-d  H:i:s'),
				'date_today' => date('Y-m-d'),
				'place' => $this->input->post('place'),
				'checkin_by' => $this->input->post('checkin_by'),
				'id_user' => $this->input->post('iduser'),
			);

			$this->db->insert('tb_absen', $insert);
			if($this->db->affected_rows() > 0){
				$data  = array(
					'message' => 'Successfully Insert '.$this->db->affected_rows().' Absen',
					'status' => 200,
					'checkin' => $insert

				);
			}else{

				$data  = array(
					'message' => 'Failed Insert Absen',
					'status' => 200,
					'checkin' => $insert

				);
			}

			echo json_encode($data);
		}


		function getAbsen(){

			$idUser = $this->input->post('iduser');
			$date_now = date('Y-m-d');
			$hasIdUser = $idUser != null || $idUser != "";
			$sql = "SELECT A.*, tb_absen.id_absen, tb_absen.check_in, tb_absen.check_out, tb_absen.place FROM (SELECT tb_user.*, tb_role.name_role FROM tb_user 
			left JOIN tb_role ON tb_user.role_id = tb_role.id_role ".((!$hasIdUser) ? "": "WHERE tb_user.id_user = ?").") as A LEFT JOIN tb_absen ON A.id_user = tb_absen.id_user AND tb_absen.date_today = '$date_now'";


			$query = $this->db->get('tb_user');

			if($idUser != null || $idUser != ""){
				$query = $this->db->query($sql,array($idUser));
				if($query -> num_rows() > 0){

					$data['status'] = 200;
					$data['message'] = "Successfully get data absen with ID";
					$data['absen'] = $query->result();

				}else{
					$data['status'] = 404;
					$data['message'] = "Failed get data absen";
				}
			}else{
				$query = $this->db->query($sql);
				if($query -> num_rows() > 0){

					$data['status'] = 200;
					$data['message'] = "Successfully get data absen without ID";
					$data['absen'] = $query->result();

				}else{
					$data['status'] = 404;
					$data['message'] = "Failed get data absen";
				}

			}
			echo json_encode($data);

		}


		function getRole(){
			$q = $this->db->get('tb_role');
			if($q -> num_rows() > 0){
				$data['message'] = "Successfully get Role";
				$data['status'] = 200;
				$data['dataRole'] = $q->result();
			}else{
				$data['message'] = "Failed get Role";
				$data['status'] = 404;
			}

			echo json_encode($data);
		}


		function registerUser(){
			$fullname = $this->input->post('fullname');
			$username = $this->input->post('username');
			$email = $this->input->post('email');
			$password = $this->input->post('password');
			$role = $this->input->post('role');

			$this->db->where('email_user', $email);
			$q = $this->db->get('tb_user');

			if($q -> num_rows() > 0){
				$data['status'] = 404;
				$data['message'] = "Failed Register, Email Telah terdaftar";
			}else{
				$save['fullname_user'] = $fullname;
				$save['username_user'] = $username;
				$save['email_user'] = $email;
				$save['password_user'] = md5($password);
				$save['role_id'] = $role;

				$querySaved = $this->db->insert('tb_user', $save);

				if($querySaved){
					$data['status'] = 200;
					$data['message'] = "Successfully Register";
				}else{
					$data['status'] = 404;
					$data['message'] = "Failed Register";
				}

			}

			echo json_encode($data);
		}


		function loginUser(){
			$email = $this->input->post('email');
			$password = $this->input->post('password');
			$this->db->where('email_user', $email);
			$this->db->where('password_user', md5($password));

			$this->db->join("tb_role", "tb_user.role_id = tb_role.id_role");

			$q = $this->db->get('tb_user');

			if($q -> num_rows() > 0){
				$data['status'] = 200;
				$data['message'] = "Successfully Login User";
				$data['user'] = $q->row();
			}else{
				$data['status'] = 404;
				$data['message'] = "Failed Login User";
			}

			echo json_encode($data);
		}


		
	}


	
?>